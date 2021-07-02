/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : ex3_common_constraint.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 07:08:36 PM CST
 ************************************************************************/

 /*
 
 */
 class transaction;

    rand bit [7:0]  min, typ, max;
    rand bit [7:0]  fixed;

    constraint range_limit {
        min > 0;
        typ == 4;
        max  < 10;
        max > typ;
        min < typ;
    }

    function void print();
        $display("min = %d, typ = %d, max = %d", min, typ, max);
    endfunction

 endclass //transaction

program test;

    transaction trns;

    initial begin
        trns = new();
        trns.randomize();

        trns.print();
    end

endprogram