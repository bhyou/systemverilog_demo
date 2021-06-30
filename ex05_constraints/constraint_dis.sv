/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_dis.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 06:47:54 PM CST
 ************************************************************************/
/* 
addr dist { 2 := 5, [10:12] := 8 };
 
for addr == 2 , weight 5
    addr == 10, weight 8
    addr == 11, weight 8
    addr == 12, weight 8

addr dist { 2 := 5, [10:12] :/ 8 };
 
for addr == 2 , weight 5
    addr == 10, weight 8/3
    addr == 11, weight 8/3
    addr == 12, weight 8/3
*/

class packet;
  rand bit [3:0] addr;    
  rand bit [3:0] data;    
  rand bit [3:0] info;

  constraint addr_range { addr dist { 2 := 5, 7 := 8, 10 := 12 }; }
  constraint data_range { data dist { 2 :/ 5, [10:12] :/ 8 };}
  constraint info_range { info dist { 2 := 5, [10:12] := 8 };}
endclass
 
module constr_dist;
  initial begin
    packet pkt;
    pkt = new();
    $display("------------------------------------");
    repeat(10) begin
      pkt.randomize();
      $display("\taddr = %0d",pkt.addr);
    end
    $display("------------------------------------");
    repeat(10) begin
      pkt.randomize();
      $display("\tdata = %0d",pkt.data);
    end
    $display("------------------------------------");
    repeat(10) begin
      pkt.randomize();
      $display("\tinfo = %0d",pkt.info);
    end
    $display("------------------------------------");
  end
endmodule