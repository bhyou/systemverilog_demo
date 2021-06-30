/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_ifelse.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 09:07:09 PM CST
 ************************************************************************/
 
class packet;
  rand bit [3:0] addr;
       string    addr_range;
 
  constraint address_range { if(addr_range == "small")
                                addr < 8;
                             else
                                addr > 8;
                           }
endclass
 
module constr_if_else;
  initial begin
    packet pkt;
    pkt = new();
    pkt.addr_range = "small";
    $display("------------------------------------");
    repeat(3) begin
      pkt.randomize();
      $display("\taddr_range = %s addr = %0d",pkt.addr_range,pkt.addr);
    end
    $display("------------------------------------");
 
    pkt.addr_range = "high";
    $display("------------------------------------");
    repeat(3) begin
      pkt.randomize();
      $display("\taddr_range = %s addr = %0d",pkt.addr_range,pkt.addr);
    end
    $display("------------------------------------");
  end
endmodule