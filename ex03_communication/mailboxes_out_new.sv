/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : mailboxes.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 10:38:07 AM CST
 ************************************************************************/

/*
      Events	 : Different threads synchronize with each other via event handles in a testbench
      Semaphores : Different threads might need to access the same resource; they take turns by using a semaphore
      Mailbox	 : Threads/Components need to exchange data with each other; data is put in a mailbox and sent

    mailbox is like a dedicated channel established to send data beween two components.

    for example, a mailbox can be ceated and handles be passed to a data generator and driver. the generator can 
    push the data object into the mailbox and the driver will be able to retrieve the packet and drive the signals 
    onto the bus.
*/

class transaction;
    rand bit [7:0]  value;
    rand bit [7:0]  address;

    function display();
        $display("[%t] Data = 0x%0x", $time, value);
    endfunction

endclass


class generator;

    mailbox mbx;

//    function new(mailbox mbx);
//        this.mbx = mbx;  
//    endfunction //new()

    task  genData();
        transaction trns = new();
        trns.randomize();
        trns.display();
        $display("[%t] [Generator] Going to put data pakcet into mailbox", $time);
        mbx.put(trns);
        $display("[%t] [Generator] Data put into mailbox", $time);
    endtask
endclass //generator

class driver;
    mailbox mbx;

    bit [7:0]   testData;
 //   function new(mailbox mbx);
 //       this.mbx = mbx;
 //   endfunction //new()

    task automatic drvData();
        transaction drvTrns = new();
        $display("[%t] [Driver] Waiting for available data", $time);

        mbx.get(drvTrns);
        $display("[%t] [Driver] Data received from Mailbox", $time);
        drvTrns.display();

        testData = drvTrns.value;
        $display("[%t] [Driver] driver Data is %d", $time, testData);
    endtask // drvData
endclass //driver

program mailbox_tb;
    mailbox   mbx;
    generator Gen;
    driver    Drv;

    initial begin
        mbx = new();
        Gen = new();
        Drv = new();

        Gen.mbx = mbx;
        Drv.mbx = mbx;

        fork
            #10 Gen.genData();
            Drv.drvData();
        join
    end

endprogram