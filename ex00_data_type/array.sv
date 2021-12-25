/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : array.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 19 Jul 2021 06:36:34 PM CST
 ************************************************************************/
/*
   the '==' can be used to check whether two dynamic array are equal.
*/

program testcase;

   logic [7:0]  data [];
   logic [7:0]  value[];

   initial begin 
      data = {1,2,3,4,5,6,7,8};
      value = {1,2,3,4,5,6,7,8};
   
      if(data == value) begin
         $display("they are equal!");
      end else begin
         $display("they aren't equal!");
      end
   end

endprogram 
