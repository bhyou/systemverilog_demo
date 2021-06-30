/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_soft.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 11:26:18 PM CST
 ************************************************************************/
 
class packet;
  rand bit [3:0] addr;
  constraint addr_range { soft addr > 6; }
endclass
 
module soft_constr;
  initial begin
    packet pkt;
    pkt = new();
 
    repeat(2) begin
      pkt.randomize() with { addr < 6;};
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule