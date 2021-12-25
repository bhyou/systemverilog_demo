/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : semaphore_cross_class.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 05 Jul 2021 04:53:45 PM CST
 ************************************************************************/

class packet;
   rand  int addr;
   rand  int data;

   function print(int num);
      $display("----------------------------");
      $display("%d: packet",num);
      $display("data = %d, addr = %d",data, addr);
      $display("\n");
   endfunction
endclass

class generator;
   mailbox    mbx;  
   mailbox    sync_mb;

   function new(mailbox mbx, syncmbx);
      this.mbx = mbx;
      this.sync_mb = syncmbx;
   endfunction

   task run();
      packet pkt;
      bit    flag;
      pkt = new();

      sync_mb.get(flag);
      if(flag)   pkt.randomize() with { data>0; addr>0; };
      mbx.put(pkt);
   endtask
 
endclass

class driver;
   mailbox   mbx;
   mailbox   synmbx;
   int       num;
   bit       flag;

   function new(semaphore key,mailbox mbx, synmbx);
      this.mbx = mbx;
      this.synmbx = synmbx;
   endfunction

   task drv();
      packet   pkt;
      mbx.get(pkt);
      pkt.print(num);      
      num++;
      #20;
      flag  = 0;
   endtask
endclass

 
module semaphore_tb ;
   semaphore key; // create 
   driver    drv;
   generator gen;
   mailbox   mbx;
   mailbox   synmbx;

    initial begin
        key = new(1);
        mbx = new();
        synmbx = new();
        drv = new(mbx,synmbx);
        gen = new(mbx,synmbx); 

      repeat(4) fork
         gen.run();
         drv.drv();
      join
    end

    initial begin
        $timeformat(-12, 2,"ps", 5);
    end

endmodule
