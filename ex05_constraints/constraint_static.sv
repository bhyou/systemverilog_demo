/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_static.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 10:29:07 PM CST
 ************************************************************************/

/*
    The constraint is disabled by using one of the object handles. as the 
    constraint is static in nature, the constraint will get disabled for 
    both the objects.
*/ 
class packet;
  rand  bit [7:0] addr;
  
  static constraint addr_range { addr == 5; }
endclass

module static_constr;
  initial begin
    packet pkt1;
    packet pkt2;
    pkt1 = new();
    pkt2 = new();
    
    $display("Before disabling constraint");    
    pkt1.randomize();
    $display("\tpkt1.addr = %0d",pkt1.addr);
    pkt2.randomize();
    $display("\tpkt2.addr = %0d",pkt2.addr);  
    
    pkt2.addr_range.constraint_mode(0);
    
    $display("After disabling constraint");
    pkt1.randomize();
    $display("\tpkt1.addr = %0d",pkt1.addr);
    pkt2.randomize();
    $display("\tpkt2.addr = %0d",pkt2.addr);      
  end
endmodule
