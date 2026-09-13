`timescale 1ns/1ps
`default_nettype none

// Functional verification only. Actual transistors and RC are tested separately.
// This memory model acts on decoded WL/COL and PD signals, not command addresses.
module tb_sram512;
    reg CLK=0, RESET=0, SDI=0, WE=0, SOUT=1'bx;
    wire SDO, PREB, SAE, WL_EN, WRITE_EN, DIN, PD_Y, PD_YB;
    wire [3:0] RA; wire [4:0] CA, COUNT;
    wire [15:0] WL; wire [31:0] COL;
    wire [15:0] ACTIVE_WL=WL;
    sram512_digital_gates dut(.*);

    wire ref_sdo, ref_preb, ref_sae, ref_wl_en, ref_write_en, ref_din;
    wire [3:0] ref_ra; wire [4:0] ref_ca;
    sram_serial_controller #(.ROW_BITS(4),.COL_BITS(5)) reference(
        .CLK(CLK),.RESET(RESET),.SDI(SDI),.WE(WE),.SOUT(SOUT),.SDO(ref_sdo),
        .RA(ref_ra),.CA(ref_ca),.DIN(ref_din),.PREB(ref_preb),.YPREB(),
        .WL_EN(ref_wl_en),.WRITE_EN(ref_write_en),.SAE(ref_sae));

    reg memory[0:511], expected[0:511];
    reg [15:0] previous_wl=0;
    integer checks=0, operations=0, reads=0, writes=0, clocks=0;
    integer rr,cc,selected_row,selected_col;
    reg last_sdo=0;

    function integer col_index(input [31:0] c);
        integer k; begin col_index=-1;
            for(k=0;k<32;k=k+1) if(c[k]) col_index=k;
        end
    endfunction
    function integer row_index(input [15:0] r);
        integer k; begin row_index=-1;
            for(k=0;k<16;k=k+1) if(r[k]) row_index=k;
        end
    endfunction

    always @(ACTIVE_WL) begin
        if (previous_wl!=0 && ACTIVE_WL==0 && (PD_Y || PD_YB)) begin
            if(PD_Y && PD_YB) $fatal(1,"both write pulldowns asserted");
            memory[32*row_index(previous_wl)+col_index(COL)] <= PD_YB;
        end
        previous_wl=ACTIVE_WL;
    end
    always @(negedge SAE or negedge PREB) if (!SAE) SOUT<=1'bx;
    always @(posedge SAE) if(ACTIVE_WL!=0 && !WRITE_EN)
        SOUT<=memory[32*row_index(ACTIVE_WL)+col_index(COL)];

    task check_logic;
        begin
            checks=checks+1;
            if({RA,CA,DIN,PREB,SAE,WL_EN,WRITE_EN,SDO,COUNT} !==
               {ref_ra,ref_ca,ref_din,ref_preb,ref_sae,ref_wl_en,ref_write_en,ref_sdo,reference.count})
                $fatal(1,"gate / RTL mismatch clock %0d count=%0d ref=%0d",clocks,COUNT,reference.count);
            if (COL !== (32'b1 << CA)) $fatal(1,"column decoder address %0d",CA);
            if (WL !== (WL_EN ? (16'b1 << RA) : 16'b0)) $fatal(1,"row decoder address %0d",RA);
            if (PD_Y !== (WRITE_EN && !DIN) || PD_YB !== (WRITE_EN && DIN))
                $fatal(1,"write decode");
        end
    endtask
    task tick;
        begin #20;CLK=1;clocks=clocks+1;#20;check_logic;CLK=0;#20;check_logic; end
    endtask
    task async_reset;
        begin RESET=1;#3;check_logic;RESET=0;#3;last_sdo=0;end
    endtask
    task access(input integer addr,input reg wr,input reg value);
        reg [9:0] frame; integer j; begin
            frame={addr[8:0],value};WE=wr;
            for(j=9;j>=0;j=j-1) begin SDI=frame[j];tick;end
            // Toggle unused input data during access: active frame must hold.
            for(j=0;j<8;j=j+1) begin
                if(j>0) WE=~wr; // only E0 is allowed to sample WE
                SDI=~SDI;tick;
            end
            if(wr) begin expected[addr]=value;writes=writes+1;end
            else begin last_sdo=expected[addr];reads=reads+1;end
            if(SDO !== last_sdo) $fatal(1,"read/hold op=%0d addr=%0d wr=%b got=%b expected=%b",operations,addr,wr,SDO,last_sdo);
            operations=operations+1;
        end
    endtask

    integer address,pattern,bitno,phase;
    reg datum;
    initial begin
        #1;async_reset;
        // Whole-address patterns detect address aliases and neighbour corruption.
        for(pattern=0;pattern<4;pattern=pattern+1) begin
            for(address=0;address<512;address=address+1) begin
                datum=(pattern==0)?0:(pattern==1)?1:(^address[8:0])^(pattern==3);
                access(address,1,datum);
            end
            for(address=511;address>=0;address=address-1) access(address,0,0);
        end
        // March C-: upward and downward read / invert / read exercises both transitions.
        for(address=0;address<512;address=address+1) access(address,1,0);
        for(address=0;address<512;address=address+1) begin access(address,0,0);access(address,1,1);end
        for(address=0;address<512;address=address+1) begin access(address,0,0);access(address,1,0);end
        for(address=511;address>=0;address=address-1) begin access(address,0,0);access(address,1,1);end
        for(address=511;address>=0;address=address-1) begin access(address,0,0);access(address,1,0);end
        for(address=0;address<512;address=address+1) access(address,0,0);
        // Address-bit walking and retained result during writes.
        for(bitno=0;bitno<9;bitno=bitno+1) begin
            access(1<<bitno,1,1);access(1<<bitno,0,0);access(0,0,0);
            access(1<<bitno,1,0);
        end
        // RESET during every RX/access phase, without a CLK edge.
        // A reset during an in-progress write has intentionally unspecified target data.
        for(phase=0;phase<18;phase=phase+1) begin
            async_reset;WE=0;
            repeat(phase) begin SDI=0;tick;end
            async_reset;
            if(WL!==0 || WRITE_EN!==0 || PREB!==1 || SAE!==1 || SDO!==0 || COUNT!==0)
                $fatal(1,"async reset phase %0d",phase);
            access(0,0,0);
        end
        $display("PASS: %0d operations, %0d reads, %0d writes, %0d clocks, %0d gate/RTL/decode checks; 512 addresses; March C-; 18 reset phases",operations,reads,writes,clocks,checks);
        $finish;
    end
endmodule
`default_nettype wire
