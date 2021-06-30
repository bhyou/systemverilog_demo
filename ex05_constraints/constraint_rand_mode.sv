/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_rand_mode.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 28 Jun 2021 08:39:15 AM CST
 ************************************************************************/
 
class Fruits;
    rand bit [3:0]   var1;
    rand bit [3:0]   var2;

endclass //Fruits


program tb;
    initial begin
        Fruits f = new();
        $display("Before randomization variable 1=%0d, variable 2=%0d", f.var1, f.var2);

        // turn off randomization for var1
        f.var1.rand_mode(0);

        if(f.var1.rand_mode())
            $display("Randomization of var1 enabled");
        else
            $display("Randomization of var1 disabled");
        
        f.randomize();

        $display("After randomization var1=%0d var2=%0d", f.var1, f.var2);
    end
endprogram