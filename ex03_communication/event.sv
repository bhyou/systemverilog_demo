/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : event.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 10:37:35 AM CST
 ************************************************************************/

/**
    Event      : Different threads synchronize with each other via event handles in a testbench
    Semaphores : Different threads might need to access the same resource; they take turns by using a semaphore
    Mailbox	   : Threads/Components need to exchange data with each other; data is put in a mailbox and sent

    so, event is a way to synchronize two or more different process.  
    for example, one process waits for the event to happen while another process triggers the event. 
    when the event is triggered, the process waitting for the event will resume excution. 

    1. create an event 
        event  start_flush;   // creates a event called start flush
    2. trigger an event using ->
        -> start_flush; // any process that has access to "start flush" can trigger the event
    3. wait for event to happen
        wait(start_flush.triggered);  //  
        @start_flush;                  //
**/ 

module eventTb;
    event start;
    bit  error;


    initial begin
        error = 1'b0;
        #10 ;
        error = 1'b1;
        #20 ; 
        error = 1'b0;
        #30 ;
        error = 1'b1;
        #40;
    end

    always_comb begin : flag
        if(error)  -> start;
    end

    initial begin
        repeat(5) begin
            @start
            $display("something with error happen!\n");
        end 
    end

endmodule




