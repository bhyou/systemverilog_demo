/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_unique.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 08:27:21 PM CST
 ************************************************************************/
 
//constraint unique_limit { unique {variable's/arrary};}

class unique_elements;
  rand bit [3:0] var_1,var_2,var_3;
  rand bit [7:0] array[6];
  constraint varis_c {unique {var_1,var_2,var_3};}
  constraint array_c {unique {array};}
   
  function void display();
    $display("var_1 = %p",var_1);
    $display("var_2 = %p",var_2);
    $display("var_3 = %p",var_3);
    $display("array = %p",array);
  endfunction
endclass
 
program unique_elements_randomization;
  unique_elements pkt;
 
  initial begin
    pkt = new();
    pkt.randomize();
    pkt.display();  
  end
endprogram