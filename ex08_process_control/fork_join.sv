/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : fork_join.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 03 Sep 2021 03:30:11 PM CST
 ************************************************************************/
`timescale  1ns/1ps 
module hdl_top ;
    string testname;

    initial begin
        $timeformat(-9, 0, "ns", 4);
        if($value$plusargs("TEST=%s", testname))
        begin
            $display("TESTNAME=%s", testname);
        end
    end

    initial begin
        if(testname=="ALL") begin
            for(int i = 0; i < 16; i++) begin
                fork 
                    automatic int index =i;    
                    send(index);
                join 
            end
            $display("fork-join return @%t", $time);
            #100;
            $finish;
        end

        if(testname=="NONE") begin
            fork
                for(int i = 1; i < 8; i++)  begin
                    fork 
                        automatic int index =i;    
                        while(1) begin
                            //send(index);
                            #index;
                            $display("@%t driving port %d",$realtime, index);
                            if($realtime > 30)   break;
                        end
                    join_none 
                end
                
                for(int i = 1; i < 8; i++)  begin
                    fork 
                        automatic int index =i;    
                        while(1) begin //send(index);
                            #index;
                            $display("@%t moniting port %d",$realtime, index);
                            if($realtime > 30)  break;
                        end
                    join_none 
                end

                while (1) begin
                    #3 $display("@%t one cycle done!", $realtime);
                    if($realtime > 30) break;
                end
            join

            $display("fork-join_none returned @%t", $time);
            wait fork;
            $display("wait-fork returned @%t", $time);
            #100;
            $finish;
        end

        if(testname=="ANY")  begin
            for(int i = 0; i < 16; i++) begin
                fork 
                begin
                    automatic int index =i;    
                    send(index);
                end
                join_any 
            end
            $display("fork-join_any returned @%t", $time);
            wait fork;
            $display("wait-fork returned @%t", $time);
            #100;
            $finish;
        end
    end

    task send (int tmp);
        #(tmp);
        $display("@%0t: driving port %0d",$realtime,tmp);
    endtask
endmodule