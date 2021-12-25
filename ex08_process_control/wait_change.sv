/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : wait_change.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Thu 23 Dec 2021 11:22:50 AM CST
 ************************************************************************/
module wait_change;
   
   time start_t, stop_t;
   logic clk;

   logic [7:0] data;
   logic [7:0] payload [];
   logic [7:0] tmp [];
   initial begin
      #20;
      repeat(4) begin
         @(data);
         $display("%0t data is changing",$time);
      end

      tmp = new [1] (payload);
      tmp[0] = 8'h01;

      payload = new[1];
      payload = tmp;

      $display("\n");
      foreach(payload[index])
         $display("payload[%0d] : %x", index, payload[index]);
      $display("\n");

      tmp = new [2] (payload);
      tmp[1] = 8'h02;
      payload = new[2];
      payload = tmp;
      foreach(payload[index])
         $display("payload[%0d] : %x", index, payload[index]);
      $display("\n");

      tmp = new [3] (payload);
      tmp[2] = 8'h03;
      payload = new[3];
      payload = tmp;
      foreach(payload[index])
         $display("payload[%0d] : %x", index, payload[index]);
      $display("\n");
   end

   initial begin
      data = 0;
      #30 data = 1;
      #30 data = 2;
      #30 data = 3;
      #30 data = 2;
      #30 data = 1;
      #30 data = 1;
   end
endmodule
 
