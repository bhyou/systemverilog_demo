/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : pgm_block.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 28 Jun 2021 01:05:39 PM CST
 ************************************************************************/
 
module design_ex(output bit [7:0] addr);
  initial begin
    addr <= 10;
  end  
endmodule

//testbench
module testbench(input bit [7:0] addr);
  initial begin
    $display("\t module Addr = %0d",addr);
  end
endmodule
 
program testPGM(input bit [7:0] addr);
  initial begin
    $display("\t program Addr = %0d",addr);
  end
endprogram

//testbench top
module tbench_top;
  wire [7:0] addr;
 
  //design instance
  design_ex dut(addr);
  //testbench instance
  testbench test(addr);
  testPGM tpgm (addr);
endmodule