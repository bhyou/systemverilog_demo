/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : class_method.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Thu 24 Jun 2021 03:23:24 PM CST
 ************************************************************************/
class packet;
    integer  size;
    integer payload[];
    integer i;

    function new(integer size);
        this.size = size;
        payload = new[size];

        for(i=0; i<this.size; i++) begin
            payload[i] = $random;
        end
        
    endfunction

    // task in class (object method)
    task print();
        $write("\nPayload:\n");
        for (i = 0; i < size; i++) begin
           $write("payload[%0d]:   %x\n", i,payload[i]); 
        end
    endtask

    function display();
        $display("[base] size=%0d\n", this.size);
    endfunction

    //function in class (object method)
    function integer get_size();
        get_size = this.size;        
    endfunction
endclass


class extPacket extends packet;

    function new(integer size);
        super.new(size);
    endfunction 

    function display();
        super.display();
        $display("[child] size=%0d\n", size);
    endfunction
endclass //className extends superClass


program class_tb;
    // declare a handle
    packet    pkt;
    extPacket extPkt;

    initial begin
        pkt = new(5);  // create a actual object with size five
        extPkt = new(8);

        extPkt.display();
        pkt.print();

        $display("the size of packet : %d\n", pkt.get_size());
    end
endprogram