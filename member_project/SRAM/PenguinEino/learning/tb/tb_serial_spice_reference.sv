`timescale 1ns/1ps
`default_nettype none

// Drive the already-verified RTL with the same external-pin events as the
// SPICE schematic TB. Snapshot after each rising CLK / RESET, not at gate edges.
module tb_serial_spice_reference;
    reg CLK=0, RESET=0, SDI=0, WE=0;
    wire SDO, RA, CA, DIN, PREB, YPREB, WRITE_EN, WL_EN, SAE, SOUT;
    sram_serial_controller dut (
        .CLK(CLK), .RESET(RESET), .SDI(SDI), .WE(WE), .SDO(SDO),
        .RA(RA), .CA(CA), .DIN(DIN), .PREB(PREB), .YPREB(YPREB),
        .WRITE_EN(WRITE_EN), .WL_EN(WL_EN), .SAE(SAE), .SOUT(SOUT)
    );
    sram_functional_model memory_model (
        .RA(RA), .CA(CA), .DIN(DIN), .PREB(PREB), .WRITE_EN(WRITE_EN),
        .WL_EN(WL_EN), .SAE(SAE), .SOUT(SOUT)
    );
    integer fd, result_file, rc, t, previous_time=0, c, r, s, w;
    initial begin
        result_file=$fopen("rtl_reference.tsv","w");
        $fdisplay(result_file,"time_ns count shift RA CA DIN W PREB WRITE_EN WL_EN SAE SDO");
        fd=$fopen("input_events.txt","r");
        if (!fd) $fatal(1,"input_events.txt missing");
        while (!$feof(fd)) begin
            rc=$fscanf(fd,"%d %d %d %d %d\n",t,c,r,s,w);
            if (rc != 5) $fatal(1,"malformed input event");
            #(t-previous_time);
            {CLK,RESET,SDI,WE}={1'(c),1'(r),1'(s),1'(w)};
            previous_time=t;
        end
        #100;
        $fclose(fd);
        $fclose(result_file);
        $finish;
    end
    always @(posedge CLK or posedge RESET) begin
        #35;
        $fdisplay(result_file,"%0.3f %0d %0d %b %b %b %b %b %b %b %b %b",
                  $realtime,dut.count,dut.shift_reg,RA,CA,DIN,dut.W,
                  PREB,WRITE_EN,WL_EN,SAE,SDO);
    end
endmodule
`default_nettype wire
