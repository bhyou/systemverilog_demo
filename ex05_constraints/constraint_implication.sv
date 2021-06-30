/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_implication.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 09:02:48 PM CST
 ************************************************************************/
 
class packet;
  rand bit [3:0] addr;
       string    addr_range;
  constraint address_range { (addr_range == "small") -> (addr < 8);}
endclass
 
module constr_implication;
  initial begin
    packet pkt;
    pkt = new();
 
    pkt.addr_range = "small";
    $display("------------------------------------");
    repeat(4) begin
      pkt.randomize();
      $display("\taddr_range = %s addr = %0d",pkt.addr_range,pkt.addr);
    end
    $display("------------------------------------");
  end
endmodule