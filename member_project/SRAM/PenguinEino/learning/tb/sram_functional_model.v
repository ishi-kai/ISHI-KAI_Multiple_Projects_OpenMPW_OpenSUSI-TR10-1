`timescale 1ns/1ps
`default_nettype none

// TESTBENCH ONLY. Abstract SRAM + sense amplifier, NOT a 6T/7T transistor model.
// No clock/count input: it responds to the actual controller output signals.
// Memory starts X and is not cleared by the controller's RESET.
// A write commits when WL falls while WRITE_EN remains HIGH (E5).
// A read is sensed when SAE rises while WL is HIGH (E4).
// No voltage, RC delay, mismatch, or timing guarantee is represented here.
module sram_functional_model #(
    parameter integer ROW_BITS = 1,
    parameter integer COL_BITS = 1
) (
    input wire [ROW_BITS-1:0] RA,
    input wire [COL_BITS-1:0] CA,
    input wire DIN,
    input wire WRITE_EN,
    input wire WL_EN,
    input wire PREB,
    input wire SAE,
    output reg SOUT
);
    localparam integer DEPTH = 1 << (ROW_BITS + COL_BITS);
    reg memory [0:DEPTH-1];
    wire [ROW_BITS+COL_BITS-1:0] address = {RA, CA};

    always @(negedge WL_EN) begin
        if (WRITE_EN === 1'b1)
            memory[address] <= DIN;
    end

    // Tracking/precharge means that the old binary decision is not valid.
    // X here deliberately exposes premature read-result captures in the TB.
    always @(negedge SAE or negedge PREB) begin
        if (SAE === 1'b0)
            SOUT <= 1'bx;
    end

    always @(posedge SAE) begin
        if (WL_EN === 1'b1 && WRITE_EN === 1'b0)
            SOUT <= memory[address];
    end
endmodule

`default_nettype wire
