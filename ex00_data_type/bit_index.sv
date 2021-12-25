/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : bit_index.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 19 Jul 2021 09:01:10 AM CST
 ************************************************************************/

/*
   logic [15:0]  var_vect;

   var_vect [lsb_base +: width]  equals to var_vect[lsb_base+width-1:lsb_base]
   var_vect [hsb_base -: width] equals to var_vect[hsb_base:hsb_base-width-1]

   Note: the width must be constant.

*/


`define WIDTH 16
module bitVector;

   bit [15:0]        data;
   bit [`WIDTH-1:0]  value;
   initial begin
      value = {1'b0, {`WIDTH-1{1'b1}}};
      data = $random;
      $display("the value of data is 0x%h, HSB : 0x%h, LSB : 0x%H", data, data[`WIDTH-1 -:8], data[7-:8]);
      $display("the value of value is 0x%h, ", value);
      $display("the value of value is 0x%h, ", value[7:0]+8'h3);
   end

endmodule 
