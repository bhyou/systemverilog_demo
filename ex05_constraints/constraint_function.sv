/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_function.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 11:20:08 PM CST
 ************************************************************************/
 
class packet;
  rand bit [3:0] start_addr;
  rand bit [3:0] end_addr;
   
  constraint start_addr_c { start_addr == s_addr(end_addr); }
   
  function bit [3:0] s_addr(bit [3:0] e_addr);
    if(e_addr < 4)
      s_addr = 0;
    else
      s_addr = e_addr - 4;
  endfunction
   
endclass
 
module func_constr;
  initial begin
    packet pkt;
    pkt = new();
    repeat(3) begin
      pkt.randomize();
      $display("\tstart_addr = %0d end_addr =",pkt.start_addr,pkt.end_addr);
    end
  end
endmodule