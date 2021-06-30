/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : interface.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 01:56:52 PM CST
 ************************************************************************/
 
interface apb_if(input clock);
    logic [31:0]   addr;
    logic [31:0]   wdata;
    logic [31:0]   rdata;
    logic          enable;
    logic          write;
    logic          sel;

    //define port directions

    // from testbench perspective, ''
    modport tb (    input clock, rdata, output addr, wdata, enable, write, sel );
    modport dut (   input clock, addr, wdata, enable, write, sel, output rdata );
    
endinterface  