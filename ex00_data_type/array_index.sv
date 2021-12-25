/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : array_index.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Thu 15 Jul 2021 10:36:54 AM CST
 ************************************************************************/

/*
   the elements of a queue can be a class.  
*/

class seq_item;
   rand bit [7:0]  addr;
   rand bit [7:0]  data;

   function void print(string str);
      $display("@%s --> addr : %x, data : %x",str, addr, data);
   endfunction
endclass

program array_index;

   seq_item   items_qu[$];

   initial begin
      seq_item  trns1, trns2, trns3;
      trns1 = new();
      trns2 = new();
      trns3 = new();
      trns1.randomize();
      trns2.randomize();

      trns3 = trns1;
      trns1.print("transaction 1");
      trns2.print("transaction 2");
      trns3.print("transaction 3");

      items_qu.push_back(trns1);
      items_qu.push_back(trns2);
   end

   initial begin 
      seq_item  trns4, trns5, trns6;
      trns4 = new();
      trns5 = new();
      trns4.randomize();
      trns5.randomize();
      trns4.print("transaction 4");
      trns5.print("transaction 5");
      items_qu.push_back(trns4);
      items_qu.push_back(trns5);

      #10 ;
      $display("\n Collected packet:");
      foreach(items_qu[idx]) begin 
         items_qu[idx].print($sformatf("items_qu[%0d]",idx));
         
      end
   end      


endprogram 
