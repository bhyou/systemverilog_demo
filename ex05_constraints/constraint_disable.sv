/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_disable.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 09:28:24 PM CST
 ************************************************************************/
 

class packet;
  rand  bit [3:0] addr;
   
  constraint addr_range { addr inside {5,10,15}; }
endclass
 
module static_constr;
  initial begin
    packet pkt;
    pkt = new();
     
     
    $display("Before Constraint disable");
    repeat(2) begin //{
      pkt.randomize();
      $display("\taddr = %0d",pkt.addr);
    end //}
     
    //disabling constraint
    pkt.addr_range.constraint_mode(0);
     
    $display("After Constraint disable");
    repeat(2) begin //{
      pkt.randomize();
      $display("\taddr = %0d",pkt.addr);
    end //}

    //disabling constraint
    pkt.addr_range.constraint_mode(1);
     
    $display("After Constraint Enable");
    repeat(2) begin //{
      pkt.randomize();
      $display("\taddr = %0d",pkt.addr);
    end //}
  end
endmodule


class packet;
  rand  bit [3:0] addr;
   
  constraint addr_range { addr inside {5,10,15}; }
endclass
 
module static_constr;
  initial begin
    packet pkt;
    pkt = new();
     
     
    $display("Before Constraint disable");
    $display("Value of constraint mode = %0d",pkt.addr_range.constraint_mode());   
    pkt.randomize();
    $display("\taddr = %0d",pkt.addr);
     
    //disabling constraint
    pkt.addr_range.constraint_mode(0);
     
    $display("After Constraint disable");
    $display("Value of constraint mode = %0d",pkt.addr_range.constraint_mode());   
    pkt.randomize();
    $display("\taddr = %0d",pkt.addr);
     
  end
endmodule