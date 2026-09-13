`timescale 1ns/1ps
`default_nettype none

module tb_sram_serial_controller;
    parameter integer ROW_BITS = 1;
    parameter integer COL_BITS = 1;
    localparam integer ADDRESS_BITS = ROW_BITS + COL_BITS;
    localparam integer N = ADDRESS_BITS + 1;
    localparam integer DEPTH = 1 << ADDRESS_BITS;
    localparam integer COUNT_BITS = $clog2(N + 8);

    reg CLK = 0;
    reg RESET = 0;
    reg SDI = 0;
    reg WE = 0;
    wire SDO, DIN, PREB, YPREB, WRITE_EN, WL_EN, SAE, SOUT;
    wire [ROW_BITS-1:0] RA;
    wire [COL_BITS-1:0] CA;

    sram_serial_controller #(.ROW_BITS(ROW_BITS), .COL_BITS(COL_BITS)) dut (
        .CLK(CLK), .RESET(RESET), .SDI(SDI), .WE(WE), .SDO(SDO),
        .RA(RA), .CA(CA), .DIN(DIN), .PREB(PREB), .YPREB(YPREB),
        .WRITE_EN(WRITE_EN), .WL_EN(WL_EN), .SAE(SAE), .SOUT(SOUT)
    );
    sram_functional_model #(.ROW_BITS(ROW_BITS), .COL_BITS(COL_BITS)) array_model (
        .RA(RA), .CA(CA), .DIN(DIN), .PREB(PREB),
        .WRITE_EN(WRITE_EN), .WL_EN(WL_EN), .SAE(SAE), .SOUT(SOUT)
    );

    // Independent host-side scoreboard: updated from requested commands,
    // never from the DUT's decoded address or control outputs.
    reg expected_memory [0:DEPTH-1]; // Unwritten cells intentionally remain X
    reg last_read;
    integer checks = 0;
    integer operations = 0;
    integer reset_tests = 0;
    integer rises = 0;
    integer i, pass, phase, addr;
    integer background, previous_cmd, next_cmd, command_index, command_code;
    integer exhaustive_pairs = 0;
    reg [31:0] random_state = 32'h51a70b3d;
    reg data_bit;

    task automatic check(input logic condition, input string message);
        checks = checks + 1;
        if (condition !== 1'b1) begin
            $error("%0dx%0d t=%0t count=%0d: %s", 1 << ROW_BITS,
                   1 << COL_BITS, $time, dut.count, message);
            $fatal(1, "FAIL after %0d operations, %0d checks", operations, checks);
        end
    endtask

    // Literal specification table, packed as {P, WRITE_EN, WL_EN, SAE}.
    function automatic [3:0] controls(input integer e, input logic wr);
        if (wr) begin
            case (e)
                0:       controls = 4'b0001;
                1:       controls = 4'b1001;
                2, 5:    controls = 4'b1101;
                3, 4:    controls = 4'b1111;
                default: controls = 4'b1001;
            endcase
        end else begin
            case (e)
                0:       controls = 4'b0000;
                1, 2:    controls = 4'b1000;
                3:       controls = 4'b1010;
                4:       controls = 4'b1011;
                default: controls = 4'b1001;
            endcase
        end
    endfunction

    task automatic check_controls(input [3:0] expected);
        check({PREB, WRITE_EN, WL_EN, SAE} === expected, "control truth table");
        check(YPREB === PREB, "common and local precharge agree");
    endtask

    // Drive only external inputs. Each call sends one complete 100 ns CLK.
    // Checking before the rising edge catches unintended direct input paths.
    task automatic tick(input logic serial_bit, input logic write_pin);
        reg [ADDRESS_BITS+6:0] before_outputs;
        before_outputs = {RA, CA, DIN, PREB, YPREB, WRITE_EN, WL_EN, SAE, SDO};
        SDI = serial_bit;
        WE = write_pin;
        #1;
        check({RA, CA, DIN, PREB, YPREB, WRITE_EN, WL_EN, SAE, SDO}
              === before_outputs, "external input change must not bypass FFs");
        #49;
        CLK = 1;
        rises = rises + 1;
        #50;
        CLK = 0;
    endtask

    task automatic check_reset;
        check(dut.count === 0 && dut.shift_reg === 0, "reset receive state");
        check(RA === 0 && CA === 0 && DIN === 0 && dut.W === 0,
              "reset frame outputs and write mode");
        check(dut.PC_ON === 0 && dut.TRACK === 0, "reset inverted controls");
        check(SDO === 0, "reset read result");
        check_controls(4'b1001);
    endtask

    // No CLK during reset: proves this is asynchronous, even after real work.
    task automatic apply_reset;
        integer old_rises;
        check(CLK === 0, "reset release policy: CLK stopped LOW");
        old_rises = rises;
        #7 RESET = 1;
        #3;
        check_reset();
        SDI = ~SDI;
        WE = ~WE;
        #20;
        check_reset();
        check(rises == old_rises, "reset required no clock");
        RESET = 0;
        #20;
        check_reset();
        last_read = 0;
        reset_tests = reset_tests + 1;
    endtask

    task automatic pause_clock;
        reg [COUNT_BITS+N+ADDRESS_BITS+7:0] snapshot;
        check(CLK === 0, "pause only with CLK LOW");
        check_controls(4'b1001);
        snapshot = {dut.count, dut.shift_reg, RA, CA, DIN, dut.W,
                    PREB, YPREB, WRITE_EN, WL_EN, SAE, SDO};
        #213;
        SDI = ~SDI;
        WE = ~WE;
        #287;
        check({dut.count, dut.shift_reg, RA, CA, DIN, dut.W,
               PREB, YPREB, WRITE_EN, WL_EN, SAE, SDO} === snapshot,
              "clock pause retains state and outputs");
    endtask

    // The host knows the frame length; it does not wait on an internal START
    // or on dut.count. Count is observed solely to assert correct behavior.
    task automatic send_frame(input integer address, input logic value,
                              input logic pause_midway);
        reg [N-1:0] frame;
        reg [N-1:0] received;
        reg old_mode;
        reg receive_memory [0:3];
        integer bit_index, k;
        frame = {ADDRESS_BITS'(address), value};
        received = {RA, CA, DIN};
        old_mode = dut.W;
        if (DEPTH == 4)
            for (k = 0; k < 4; k = k+1)
                receive_memory[k] = array_model.memory[k];
        check(dut.count === 0, "frame starts at count=0");
        for (bit_index = N-1; bit_index >= 0; bit_index = bit_index-1) begin
            // Deliberately unrelated WE during reception: only E0 samples it.
            tick(frame[bit_index], bit_index % 2);
            received = {received[N-2:0], frame[bit_index]};
            check(dut.count == N-bit_index, "receive count");
            check({RA, CA, DIN} === received,
                  "frame outputs follow each received bit");
            check(dut.W === old_mode, "reception must not sample WE");
            check(SDO === last_read, "receive preserves SDO");
            check_controls(4'b1001);
            if (DEPTH == 4)
                for (k = 0; k < 4; k = k+1)
                    check(array_model.memory[k] === receive_memory[k],
                          "shifting addresses must not alter any cell");
            if (pause_midway && bit_index == N-2)
                pause_clock();
        end
        check(dut.shift_reg === frame, "MSB-first frame assembled");
    endtask

    task automatic check_command(input integer address, input logic wr,
                                 input logic value);
        check(RA === ROW_BITS'(address >> COL_BITS), "held row address");
        check(CA === COL_BITS'(address), "held column address");
        check(DIN === value && dut.W === wr, "held DIN and write mode");
    endtask

    task automatic check_memory;
        integer k;
        for (k = 0; k < DEPTH; k = k+1)
            check(array_model.memory[k] === expected_memory[k],
                  $sformatf("stored/unchosen cell %0d", k));
    endtask

    task automatic access(input integer address, input logic wr,
                          input logic value, input logic pause_midway);
        integer e, old_rises;
        reg [N-1:0] frame;
        frame = {ADDRESS_BITS'(address), value};
        old_rises = rises;
        send_frame(address, value, pause_midway);
        for (e = 0; e < 8; e = e+1) begin
            // At E0 use this command's WE; afterwards invert it to prove hold.
            // SDI is deliberately toggled throughout the access interval.
            tick(e % 2, (e == 0) ? wr : ~wr);
            check(dut.count == ((e == 7) ? 0 : N+e+1), "access count/wrap");
            check_controls(controls(e, wr));
            check_command(address, wr, value);
            check(dut.shift_reg === frame, "no shifting during E0..E7");
            if (!wr && e >= 4)
                check(SOUT === expected_memory[address], "sensed selected cell");
            if (!wr && e == 6)
                last_read = expected_memory[address];
            check(SDO === last_read, "SDO changes only on read E6 or RESET");
        end
        if (wr)
            expected_memory[address] = value;
        if (DEPTH == 4)
            check_memory(); // Every other cell checked after each small-array op
        check(rises - old_rises == N+8, "fixed number of clocks per operation");
        operations = operations + 1;
    endtask

    // Abort an operation at each stage. Its memory result is not specified;
    // forget that expectation, reset, and rewrite before checking its contents.
    task automatic abort_access(input integer last_phase, input logic wr);
        integer e;
        send_frame(DEPTH-1, 1'b1, 0);
        for (e = 0; e <= last_phase; e = e+1) begin
            tick(0, wr);
            check_controls(controls(e, wr));
        end
        apply_reset();
        // Do not inspect the aborted cell until this external write has
        // established its next known value. Other cells retain their expectations.
        access(DEPTH-1, 1, 0, 0);
        access(DEPTH-1, 0, 0, 0);
    endtask

    // Bound a broken simulation instead of waiting forever.
    initial begin
        #100000000;
        $fatal(1, "simulation timeout");
    end

    initial begin
        if (ROW_BITS < 1 || COL_BITS < 1)
            $fatal(1, "address widths must be >= 1");
        if ($test$plusargs("waves")) begin
            $dumpfile("serial_controller.vcd");
            $dumpvars(0, tb_sram_serial_controller);
        end

        apply_reset();
        check_memory();
        // RESET also wins when clocks are present (not just when stopped).
        RESET = 1;
        #3;
        tick(1, 1);
        check_reset();
        tick(1, 1);
        check_reset();
        RESET = 0;
        #20;
        pause_clock();
        access(0, 0, 0, 0); // Unknown memory must stay unknown, not appear reset
        check(SDO === 1'bx, "unwritten memory reads X");
        apply_reset();

        // Both values at every address; opposite traversal helps expose aliasing.
        for (pass = 0; pass < 2; pass = pass+1) begin
            for (i = 0; i < DEPTH; i = i+1) begin
                data_bit = (^(ADDRESS_BITS'(i))) ^ (pass != 0);
                access(i, 1, data_bit, i == 0);
            end
            check_memory();
            for (i = DEPTH-1; i >= 0; i = i-1)
                access(i, 0, 0, 0);
        end
        pause_clock();

        // Deterministic mixed accesses: mode changes, individual rewrites and
        // prior read-result retention during subsequent writes/receptions.
        for (i = 0; i < 64; i = i+1) begin
            random_state = {random_state[30:0], random_state[31] ^
                            random_state[21] ^ random_state[1] ^ random_state[0]};
            addr = (random_state >> 8) % DEPTH;
            access(addr, 1, random_state[0], 0);
            access(addr, 0, 0, 0);
        end
        check_memory();

        // Assert reset after a known HIGH result; it must clear without a CLK.
        access(0, 1, 1, 0);
        access(0, 0, 0, 0);
        check(SDO === 1, "prepare nonzero result for asynchronous reset");
        apply_reset();
        check_memory(); // SRAM contents survive a non-access reset
        access(0, 0, 0, 0);
        check(SDO === 1, "reset does not clear SRAM");

        // Reset with a partly received frame, including after its final bit.
        for (phase = 1; phase <= N; phase = phase+1) begin
            for (i = 0; i < phase; i = i+1)
                tick(1, 0);
            apply_reset();
            check_memory();
            access(0, 0, 0, 0);
        end

        for (phase = 0; phase < 8; phase = phase+1) begin
            abort_access(phase, 0);
            abort_access(phase, 1);
        end
        check_memory();

        // Recover every unused binary count without accepting/capturing data.
        // Fault injection is only for this check, not normal stimulus.
        for (i = N+8; i < (1 << COUNT_BITS); i = i+1) begin
            dut.count = COUNT_BITS'(i);
            tick(1, 1);
            check(dut.count === 0, "unused count returns to receive start");
            check_controls(4'b1001);
            check(SDO === last_read, "unused count must not capture SOUT");
        end
        access(0, 0, 0, 0);

        // Exhaust every legal ordered command pair over all 16 initial 2x2
        // memory backgrounds. Commands are read, write-0, write-1 per address.
        // Establish backgrounds only through the public serial interface.
        if ($test$plusargs("exhaustive")) begin
            if (DEPTH != 4) $fatal(1, "exhaustive command pairs require 2x2");
            for (background = 0; background < 16; background = background+1)
                for (previous_cmd = 0; previous_cmd < 12; previous_cmd = previous_cmd+1)
                    for (next_cmd = 0; next_cmd < 12; next_cmd = next_cmd+1) begin
                        for (i = 0; i < 4; i = i+1)
                            access(i, 1, (background >> i) & 1, 0);
                        for (command_index = 0; command_index < 2; command_index = command_index+1) begin
                            command_code = command_index == 0 ? previous_cmd : next_cmd;
                            access(command_code / 3, command_code % 3 != 0,
                                   command_code % 3 == 2, 0);
                        end
                        exhaustive_pairs = exhaustive_pairs + 1;
                    end
            $display("COVERAGE: %0d ordered command pairs over 16 initial memory backgrounds", exhaustive_pairs);
        end

        $display("PASS %0dx%0d: %0d operations, %0d checks, %0d async resets; N=%0d, count=%0d bits",
                 1 << ROW_BITS, 1 << COL_BITS, operations, checks, reset_tests,
                 N, COUNT_BITS);
        $finish;
    end
endmodule

`default_nettype wire
