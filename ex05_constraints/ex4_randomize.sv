/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : ex4_randomize.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 05:52:33 PM CST
 ************************************************************************/

class packet;
  rand  bit [7:0] addr;
  randc bit [7:0] data;  
   
  //pre randomization function
  function void pre_randomize();
    $display("Inside pre_randomize");
  endfunction
   
  //post randomization function
  function void post_randomize();
    $display("Inside post_randomize");
    $display("value of addr = %0d, data = %0d",addr,data);
  endfunction
endclass


class randPkt;
  rand  bit [7:0] addr;
  randc bit       wr_rd;
        bit       tmp_wr_rd;    
 
  //pre randomization function - disabling randomization of addr,
  //if the prevoius operation is write.
  function void pre_randomize();
    if(tmp_wr_rd==1) addr.rand_mode(0);
    else                 addr.rand_mode(1);
  endfunction
 
  //post randomization function - store the wr_rd value to tmp_wr_rd
  //and display randomized values of addr and wr_rd
  function void post_randomize();
    tmp_wr_rd = wr_rd;
    $display("POST_RANDOMIZATION:: Addr = %0h,wr_rd = %0h",addr,wr_rd);
  endfunction
endclass



module rand_methods;
  initial begin
    packet pkt;
    pkt = new();
 
    repeat(4) pkt.randomize();
  end    



//  initial begin
//    packet pkt;
//    pkt = new();
//    pkt.randomize();
//  end
endmodule 
