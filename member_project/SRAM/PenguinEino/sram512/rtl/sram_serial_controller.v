`timescale 1ns/1ps
`default_nettype none

// 7-pin SRAM's digital controller; see ../SEQUENCER_DESIGN.md.
// External signals: CLK, RESET, SDI, WE, SDO (plus physical VDD/VSS).
// Other ports connect internally to the SRAM and its peripheral circuits.
module sram_serial_controller #(
    parameter integer ROW_BITS = 1,
    parameter integer COL_BITS = 1
) (
    input  wire                CLK,
    input  wire                RESET,       // Active HIGH, asynchronous
    input  wire                SDI,
    input  wire                WE,          // Sampled only at E0
    output wire                SDO,

    output wire [ROW_BITS-1:0] RA,
    output wire [COL_BITS-1:0] CA,
    output wire                DIN,
    output wire                PREB,
    output wire                YPREB,
    output reg                 WRITE_EN,
    output reg                 WL_EN,
    output wire                SAE,
    input  wire                SOUT         // From the sense amplifier
);
    localparam integer N = ROW_BITS + COL_BITS + 1;
    localparam integer COUNT_BITS = $clog2(N + 8);
    localparam [COUNT_BITS-1:0] E0 = N,     E1 = N + 1,
                               E2 = N + 2, E3 = N + 3,
                               E4 = N + 4, E5 = N + 5,
                               E6 = N + 6, E7 = N + 7;

    // Before an edge, count names the action performed ON that edge.
    // After E7 it is 0: the very next edge receives the next frame's MSB.
    reg [COUNT_BITS-1:0] count;
    reg [N-1:0] shift_reg;
    reg W;
    reg READ_DATA;

    // One bank serves both reception and access. These outputs shift during
    // RX (WL/write OFF, SA isolated), then remain fixed throughout E0..E7.
    assign RA  = shift_reg[N-1:COL_BITS+1];
    assign CA  = shift_reg[COL_BITS:1];
    assign DIN = shift_reg[0];

    // All stored bits reset to zero. In a DFFR implementation the inverted
    // outputs can use QB; no asynchronous preset-to-one cell is required.
    reg PC_ON;
    reg TRACK;
    assign PREB  = ~PC_ON;
    assign YPREB = ~PC_ON;
    assign SAE   = ~TRACK;
    assign SDO   = READ_DATA;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            count      <= 0;
            shift_reg  <= 0;
            W          <= 0;
            READ_DATA  <= 0;
            PC_ON      <= 0;
            TRACK      <= 0;
            WRITE_EN   <= 0;
            WL_EN      <= 0;
        end else begin
            if (count < E7)
                count <= count + 1'b1;
            else
                count <= 0;  // E7, or recovery from an unused code

            // Registered outputs default to the non-access levels.
            // The case below describes THIS edge, not the updated count.
            PC_ON    <= 0;
            TRACK    <= 0;
            WRITE_EN <= 0;
            WL_EN    <= 0;

            if (count < E0) begin
                // MSB first: all row bits, all column bits, then DIN.
                shift_reg <= {shift_reg[N-2:0], SDI};
            end else begin
                case (count)
                    E0: begin // Frame already held; sample WE and precharge
                        W     <= WE;
                        PC_ON <= 1;
                        TRACK <= ~WE; // Use this operation's WE, not old W
                    end
                    E1: begin // Release precharge
                        TRACK <= ~W;
                    end
                    E2: begin // Establish the write bitline before WL
                        WRITE_EN <= W;
                        TRACK    <= ~W;
                    end
                    E3: begin // Access the selected row
                        WRITE_EN <= W;
                        WL_EN    <= 1;
                        TRACK    <= ~W;
                    end
                    E4: begin // Sense (SAE rises on reads); continue writes
                        WRITE_EN <= W;
                        WL_EN    <= 1;
                    end
                    E5: begin // Close WL while the write driver stays on
                        WRITE_EN <= W;
                    end
                    E6: begin // Release write driver; latch read result
                        if (!W)
                            READ_DATA <= SOUT;
                    end
                    E7: begin // Finish; default outputs, then receive again
                    end
                    default: begin // Unused code: no transfer or read capture
                    end
                endcase
            end
        end
    end
endmodule

`default_nettype wire
