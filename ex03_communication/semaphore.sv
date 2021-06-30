/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : semaphore.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 10:37:52 AM CST
 ************************************************************************/

/*
    Events	   : Different threads synchronize with each other via event handles in a testbench
    Semaphores : Different threads might need to access the same resource; they take turns by using a semaphore
    Mailbox	   : Threads/Components need to exchange data with each other; data is put in a mailbox and sent

    so, a somaphore is used to control access to a resource and is known as a mutex (mutually exclusive) because 
    only one entity can have the semaphore at a time.

    1. declare a semaphore hanle
        semaphore key;
    2. create one or more keys to acccess the resource
        key = new(1);  // specify only one can
    3.  get the key by using the get() keyword 
        key.get(1)
    4. put the key back using the put() keyword
        key.put(1)
*/

module semaphore_tb ;
    semaphore key; // create 

    initial begin
        key = new(1);
        fork
            personA();
            personB();
            #25 personA();
        join
    end

    initial begin
        $timeformat(-12, 2,"ps", 5);
    end

    task automatic getRoom(bit[1:0] id);
        $display("[%t] Trying to get a room for id[%d] ...",$time, id);
        key.get(1);
        $display("[%t] Room  key retrieved for id[%0d]", $time, id);
    endtask

    task automatic putRoom(bit[1:0] id);
        $display("[%t] Leaving room id[%0d] ...",$time, id);
        key.put(1);
        $display("[%t] Room key put back id[%0d]", $time, id);

    endtask

    task automatic personA();
        getRoom(1);
        #20  putRoom(1);
    endtask

    task automatic personB();
        getRoom(2);
        #20 putRoom(2);        
    endtask 

endmodule