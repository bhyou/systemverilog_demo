/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_inline.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 11:05:03 PM CST
 ************************************************************************/
 

/*
    only inline constraint
class packet;
  rand bit [3:0] addr;
endclass

module inline_constr;
  initial begin
    packet pkt;
    pkt = new();

    repeat(2) begin
      pkt.randomize() with { addr == 8;};
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule
*/
// conflict with inline constraint
/*
*/
class packet;
  rand bit [3:0] addr;
  
  constraint addr_range {addr < 5;};
endclass

module inline_constr;
  initial begin
    packet pkt;
    pkt = new();
    repeat(2) begin
      pkt.randomize() with { addr > 5;};
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule

// 3. combine constraint inside class with inline constraint
class packet;
  rand bit [3:0] addr;
  
  constraint addr_range {addr inside {[6:12]};};
endclass

module inline_constr;
  initial begin
    packet pkt;
    pkt = new();
    repeat(2) begin
      pkt.randomize() with { addr inside {[9:10]};};
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule