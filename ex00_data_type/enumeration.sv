/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : enumeration.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 02 Jul 2021 01:47:47 PM CST
 ************************************************************************/

program enumeration;
    enum bit[1:0] { RED, YELLOW, GREEN }  traffic_light;

    // error:
    //  minimum 5 bits are required.
    //enum  bit [1:0] {active=10, disactive=20, reset=30} test_light;  

    //  error:
    // disactive and reset are both assigned 11
    //enum  bit [4:0] {active=10, disactive, reset=11} test_light; 

    enum              {active=10, disactive=20, reset=30} test_light; // right

    enum int {write=100, read=200, idle=300  } FSM1, FSM2;

    typedef enum  {run, walk, seat} animals;

    animals dog, cat; 
    initial begin
        traffic_light = 2'b10;
        $display("the status of the traffic light is %s", traffic_light);
        $display("the status of the traffic light is %d", traffic_light);

        traffic_light = RED;
        $display("the status of the traffic light is %s", traffic_light);
        $display("the status of the traffic light is %d", traffic_light);

        FSM2 = write;
        $display("the status of the FSM is %s", FSM2);
        $display("the status of the FSM is %d", FSM2);

        dog = run;
        cat = walk;
        $display("the status of dog is %s", dog);
        $display("the status of cat is %d", cat);
    end
endprogram
 
