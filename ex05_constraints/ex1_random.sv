/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : ex1_random.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 04:44:02 PM CST
 ************************************************************************/

 /*
 *  the type of random variable :
   1. rand
      Variables declared as 'rand' are standard  random variable and their vaules are uniformly distributed over this range.

   2. randc
      Variables declared as 'randc' are standard-cyclic and hence cycle through all the vaules within their range before 
      repeating any particular value.


 *  constraint blocks
      1. introduce
         constraint blocks are class members just like variables, functions and tasks. they have unique names within a class
         

      2. Syntax as follow:
      constraint name_of_constraint {
         [express 1];
         ..... ;
         [express N];
      
      }
 */

class Packet;
   rand bit [3:0]  data;
   randc bit [3:0]  addr;
// in-class constraint 
   constraint addr_limit { 
      addr <= 4'hA; 
      addr >= 4'h1;
   }
   // external class constraint
   extern constraint exconstraints; // must add 'extern' keyword
endclass

// external class constraint
constraint Packet::exconstraints {
   data <= 4'h9;
   data >= 4'h1;
}

program top;

   initial begin 
      Packet pkt = new();

      for(int i = 0; i < 20 ; i++) begin 
         pkt.randomize();
         if(i==4'hf) $display("\n");
         $display("itr = %2d, data = 0x%0x,  addr = 0x%0x", i, pkt.data, pkt.addr);
      end
   end

endprogram

class packet;
  rand  bit [3:0] addr;
  constraint addr_range { addr > 5; }
endclass
 
class packet2 extends packet;
  constraint addr_range { addr < 5; } //overriding constraint of parent class
endclass
 
module const_inhe;
  initial begin
    packet pkt1;
    packet2 pkt2;
 
    pkt1 = new();
    pkt2 = new();
 
    $display("------------------------------------");
    repeat(5) begin
      pkt1.randomize();
      $display("\tpkt1:: addr = %0d",pkt1.addr);
    end
 
    $display("------------------------------------");
    repeat(5) begin
      pkt2.randomize();
      $display("\tpkt2:: addr = %0d",pkt2.addr);
    end
    $display("------------------------------------");
  end
endmodule 