/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : vif_class.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 03:16:48 PM CST
 ************************************************************************/


// declare memory interface
interface memory (input bit clk);
  wire [7:0] addr;
  wire [7:0] data_i;
  wire [7:0] data_o;
  wire       rw;
  wire       ce;

  // Define the DUT modport
  modport  dut (input  addr, data_i, rw, ce, clk, output data_o);

  // Define the Testbench Driver modport
  modport  tb  (output addr, data_i, rw, ce, input data_o, clk);

  // Define the Testbench Monitor modport
  modport  mon (input  addr, data_i, rw, ce, clk, data_o);

endinterface

module ram(memory.dut mif);
    reg [7:0] memr [0:255];

    // Memory read operation
    assign mif.data_o = (~mif.rw && mif.ce) ?   memr[mif.addr] : 8'b0;

    // Memory write operation
    always @ (posedge mif.clk)
        if (mif.ce && mif.rw) 
           memr[mif.addr] = mif.data_i;

endmodule

// top-level of memory model ( DUT top)
module ram_top(memory.dut mif0,memory.dut mif1,memory.dut mif2);
    ram U_ram0(mif0);
    ram U_ram1(mif1);
    ram U_ram2(mif2);
endmodule

// top-level of TestBench
module mem_tb();
  logic clk = 0;
  always #1 clk = ~clk;

  // interface with clock connected
  memory mem_if0(clk);
  memory mem_if1(clk);
  memory mem_if2(clk);

  // Connect the DUT
  ram_top U_ram_top(
    .mif0(mem_if0.dut),
    .mif1(mem_if1.dut),
    .mif2(mem_if2.dut)
  );

  // Connect the testbench
  testcase U_test(
   .tbf0(mem_if0),
   .tbf1(mem_if1),
   .tbf2(mem_if2)
  );
endmodule

//  Driver class
class driver;
    virtual memory.tb ports;

    // Constructor
    function new(virtual memory.tb ports);
       this.ports = ports;
    endfunction

    // Test vector generation
    task run_t();
      integer i = 0;
      for (i= 0; i < 4; i ++) begin
         @ (posedge ports.clk);
         $display("Writing address %0d with data %0d",i,i);
         ports.addr = i;
         ports.data_i = i;
         ports.ce = 1;
         ports.rw = 1;
         @ (posedge ports.clk);
         ports.addr = 0;
         ports.data_i = 0;
         ports.ce = 0;
         ports.rw = 0;
      end
      for (i= 0; i < 4; i ++) begin
         @ (posedge ports.clk);
         $display("Read address %0d",i);
         ports.addr = i;
         ports.data_i = i;
         ports.ce = 1;
         ports.rw = 0;
         @ (posedge ports.clk);
         ports.addr = 0;
         ports.data_i = 0;
         ports.ce = 0;
         ports.rw = 0;
      end
    endtask
endclass

class monitor;
    reg  [7:0] tbmem [255];
    virtual memory.mon ports;

    // Constructor
    function new(virtual memory.mon ports);
       this.ports = ports;
    endfunction

    // Monitor method
    task run_t();
      while(1) begin
         @ (negedge ports.clk);
         if (ports.ce) begin
           if (ports.rw) begin
             tbmem[ports.addr] = ports.data_i;
           end else begin
             if (ports.data_o != tbmem[ports.addr]) begin
               $display("Error : Expected %0x Got %0x",
                 tbmem[ports.addr],ports.data_o);
             end else begin
               $display("Pass  : Expected %0x Got %0x",
                 tbmem[ports.addr],ports.data_o);
             end
           end
         end
      end
    endtask
 endclass


program automatic testcase(memory tbf0, memory tbf1, memory tbf2 );

    initial begin
        driver   tb_driver0  = new(tbf0.tb);
        monitor  tb_monitor0 = new(tbf0.mon);

        driver   tb_driver1  = new(tbf1.tb);
        monitor  tb_monitor1 = new(tbf1.mon);

        driver   tb_driver2  = new(tbf2.tb);
        monitor  tb_monitor2 = new(tbf2.mon);

        fork
            tb_monitor0.run_t();
            tb_monitor1.run_t();
            tb_monitor2.run_t();
        join_none

        fork
            tb_driver0.run_t();
            #100 tb_driver1.run_t();
            #200 tb_driver2.run_t();
        join
    end

endprogram





