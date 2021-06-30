/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : interface_counter.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 02:36:02 PM CST
 ************************************************************************/
interface cnt_inf #(parameter WIDTH = 4) (input bit clock);
    logic                     rstn;
    logic                     load_en;
    logic  [WIDTH-1:0]        ld_data;
    logic  [WIDTH-1:0]        cntOut ;
    logic                     down   ;
    logic                     rollover;      

    modport tb (input clock, cntOut, rollover,  output rstn, load_en, ld_data, down );  
    modport monitor (  input clock, cntOut, rollover, rstn, load_en, ld_data, down  );
endinterface //cnt_inf 


module counter #(parameter WIDTH = 4)(
    input  wire                    clock  ,
    input  wire                    rstn   ,
    input  wire                    load_en,
    input  wire [WIDTH-1:0]        ld_data,
    input  wire                    down   ,
    output reg  [WIDTH-1:0]        cntOut ,
    output wire                    rollover      
);

    always_ff @( posedge clock, negedge rstn ) begin : cnt
        if(~rstn) begin
            cntOut <= '0;
        end
        else begin
            if(load_en) 
                cntOut <= ld_data;
            else begin
                if(down)
                    cntOut <= cntOut - 1;
                else 
                    cntOut <= cntOut + 1;
            end 
        end
    end
    assign rollover = & cntOut;

endmodule

program automatic test(cnt_inf.tb  tb_inf);

    initial begin
        $display("\nstart testing program!\n");
        tb_inf.rstn    =  0;
        tb_inf.load_en =  0;
        tb_inf.ld_data = '0;
        tb_inf.down    = '0;
        
        @(posedge tb_inf.clock);
        #2;
        tb_inf.rstn    = 1'b1;

        repeat(10) @(posedge tb_inf.clock);
        #2;
        tb_inf.load_en = 1'b1;
        tb_inf.ld_data = 4'he;

        @(posedge tb_inf.clock);
        #2;
        tb_inf.load_en  = 1'b0;
        tb_inf.down     = 1'b1;
        repeat(7) @(posedge tb_inf.clock);
    end
endprogram

program automatic monitor(cnt_inf.monitor mon_inf);
    initial begin
        $monitor($realtime,,"counter out: 'b%b, overflow: 'b%b, down: 'b%b", mon_inf.cntOut, mon_inf.rollover, mon_inf.down);
    end

endprogram

module counter_tb;
    reg  clock;

    cnt_inf cnt_io(clock);
    monitor mon(cnt_io);
    test  testcase(cnt_io);

    counter cnter(
        .clock    (cnt_io.clock   ),
        .rstn     (cnt_io.rstn    ),
        .load_en  (cnt_io.load_en ),
        .ld_data  (cnt_io.ld_data ),
        .down     (cnt_io.down    ),
        .cntOut   (cnt_io.cntOut  ),
        .rollover (cnt_io.rollover)      
    );


   initial begin
       $timeformat(-9, 2, "ns", 6);
       clock = 0;

       forever begin
           #20 clock = ~ clock;
       end
   end 
endmodule