/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : class_inheritance.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 10:06:54 AM CST
 ************************************************************************/

 `define virtualFunc

 class packet;
    int addr;

    function new(int addr);
         this.addr = addr;
    endfunction //new()

`ifdef virtualFunc
    virtual function display();
`else
    function display();
`endif
        $display("[Base] addr=0x%0x\n", this.addr);;
    endfunction
 endclass //packet

 class extPacket extends packet;
    int   data;

    function new(int addr, data);
        super.new(addr);
        this.data = data;
    endfunction //new()

    function  display();
        //super.display();
        $display("[Child] addr=0x%0x, data=0x%0x\n", addr, data);;
    endfunction
 endclass //extPacket extends packet

program derivedClass_tb; 
    packet     BaseClass;
    extPacket  SubClass;

    initial begin
//        BaseClass = new(32'hface_cafe);
//        BaseClass.display();

        SubClass = new(32'h87654321, 32'h1234_5678);
        BaseClass = SubClass;
        $display("print infomation from base class:");
        BaseClass.display();
        $display("\n\nprint infomation from sub-class:");
        SubClass.display();
    end
endprogram
 
