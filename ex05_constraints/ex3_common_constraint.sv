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
        min > 3;


    }
 endclass //transaction