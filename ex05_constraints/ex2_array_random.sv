/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : ex2_array_random.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 05:25:46 PM CST
 ************************************************************************/
 
/*
    * randomization also works on array data structures like static or dynamic array and queue. 
    * 
*/

class Packet;
    // declare a static array with 'rand'
    rand bit [7:0] s_array [7];
    // dynamic array  
    rand bit [7:0] d_array [ ];
    rand bit [7:0] queue   [$];

    // constraint size of dynamic array beween 4 and 14
    constraint size_limit { 
        d_array.size() > 4;
        d_array.size() < 14;
    }

    // constraint value at each index to equal to the index itself
    constraint value_limit {
        foreach (d_array[i]) {
            d_array[i]  >= i + 100;
            d_array[i]  <= i + 102;
        }
    }

    constraint queue_limit {
        queue.size() <= 10;
        queue.size() >= 6;
    }

    function void print();
        foreach (d_array[idx])
            $display("d_array[%2d] = %3d",idx, d_array[idx]);
    endfunction
endclass //Packet

program  array_rand;
    Packet pkt;

    initial begin
        pkt = new();
        pkt.randomize();

        $display("queue = %p", pkt.s_array);
        $display("queue = %p", pkt.queue);
        $display("\n");
        pkt.print();
    end
endprogram