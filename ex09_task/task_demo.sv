/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : task_demo.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sat 18 Dec 2021 10:24:46 PM CST
 ************************************************************************/

/*
   the parameter of task can be user-defined type.
*/

module task_demo;

   typedef struct packed {
      logic [31:0]  addr;
      logic [31:0]  data;
   } trans;

   trans slv1;
   task write(input trans trans_in);
      $display("write %X to  %x",trans_in.data, trans_in.addr);
   endtask

task print_array(ref byte darray[]);
   $display("the size of array is %d", darray.size());
   foreach(darray[i]) 
      $display("darray[%d] :  %d", i, darray[i]);
endtask

   byte darray0 [];

   initial begin
      slv1.addr = 32'h01234567;
      slv1.data = 32'h89ABCDEF;
      write(slv1);
      #20;
      slv1.data = 32'h01234567;
      slv1.addr = 32'h89ABCDEF;
      write(slv1);
      #20;

      darray0 = new[4];
      darray0 = '{23,45,67,78};
      print_array(darray0);
      $finish;
   end
endmodule
 
