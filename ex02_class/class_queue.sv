/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : class_queue.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Tue 20 Jul 2021 08:42:35 AM CST
 ************************************************************************/

class packet;
   rand bit [7:0]  data;
   rand bit [7:0]  addr;
   rand bit [7:0] payload [$];

   constraint payload_size {
      payload.size() == 5;
   }

   function bit compare(packet pkt2cmp);
      if(payload.size() == pkt2cmp.payload.size()) begin
         $display("@packet: payload size is matched!");
         return (1);
      end else begin
         $display("payload size isn't matched!");
         return (0);
      end
   endfunction

   function void print();
      $display("addr: %h, data: %h", this.addr, this.data);
      foreach(payload[index])
         $display("payload[%0d]: %h", index, payload[index]);
   endfunction
endclass 

program testcase();
   packet  p1;
   packet  p2;

   initial begin 
      p1 = new();
      p2 = new();

      assert(p1.randomize())
      else $display("p1 randomize failed!");

      assert(p2.randomize())
      else $display("p2 randomize failed!");

      p1.print();
      p2.print();
      if(p1.compare(p2)) begin 
         $display("@testcase: payload size is mathched");
      end else begin 
         $display("payload size of p1: %d, p2:%d",p1.payload.size, p2.payload.size);
      end
   end
   
endprogram
