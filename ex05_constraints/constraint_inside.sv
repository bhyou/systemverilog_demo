/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_inside.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 06:30:54 PM CST
 ************************************************************************/
 

class packet;
  rand bit [3:0] addr;
  rand bit [3:0] start_addr;
  rand bit [3:0] end_addr;
   
  constraint addr_1_range { addr inside {[start_addr:end_addr]}; }
endclass
 
module constr_inside;
  initial begin
    packet pkt;
    pkt = new();
    $display("------------------------------------");
    repeat(3) begin
      pkt.randomize();
      $display("\tstart_addr = %0d,end_addr = %0d",pkt.start_addr,pkt.end_addr);
      $display("\taddr = %0d",pkt.addr);
      $display("------------------------------------");
    end
  end
endmodule


class packet;
  rand bit [3:0] addr;
  rand bit [3:0] start_addr;
  rand bit [3:0] end_addr;
   
  constraint addr_1_range { !(addr inside {[start_addr:end_addr]}); }
endclass
 
module constr_inside;
  initial begin
    packet pkt;
    pkt = new();
    $display("------------------------------------");
    repeat(3) begin
      pkt.randomize();
      $display("\tstart_addr = %0d,end_addr = %0d",pkt.start_addr,pkt.end_addr);
      $display("\taddr = %0d",pkt.addr);
      $display("------------------------------------");
    end
  end
endmodule

