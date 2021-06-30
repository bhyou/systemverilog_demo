/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_solve_before.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 11:41:51 PM CST
 ************************************************************************/
 
class packet;
  rand bit       a;
  rand bit [3:0] b;
 
  constraint a_b { (a == 1) -> b == 0; }
  constraint sab { solve a before b; }
endclass
 
module inline_constr;
  initial begin
    packet pkt;
    pkt = new();
    repeat(10) begin
      pkt.randomize();
      $display("\tValue of a = %0d, b = %0d",pkt.a,pkt.b);
    end
  end
endmodule