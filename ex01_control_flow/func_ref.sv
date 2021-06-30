/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : func_ref.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Fri 25 Jun 2021 03:50:05 PM CST
 ************************************************************************/
 
module func_ref ;

    initial begin
        int     maxVal;
        int val,  result;
        int valRef,  resultRef;
        int s = sum(3,4);
        $display("sum(3,4) = %0d", s);

        $display("sum(5,9) = %0d", sum(5,9));

        $display("mul(3,1) = %0d", mul(3,1));

        $display("max(65,99) function return %0d", max(65,99, maxVal));
        $display("max(65,99) value return  %0d", maxVal);


        // pass arguments by value
        val = $urandom_range(1,10);

        $display("Before calling fn: val = %0d, result = %0d", val, result);
        result = fn(val);
        $display("after calling fn: val = %0d, result = %0d", val, result);

        // pass arguments by ref
        valRef = $urandom_range(1,10);
        $display("\nBefore calling fn_ref: val = %0d, result = %0d", valRef, resultRef);
        resultRef = fn_ref(valRef);
        $display("after calling fn_ref: val = %0d, result = %0d", valRef, resultRef);
    end

    function byte sum (int x, y);
        sum = x + y;
    endfunction

    function byte mul (int x, y);
        return x*y;
    endfunction

    // must be declare a variable to receive the ouptut of the function
    // the declared variable is changed
    function byte max(input int x, y, output int max_val);
        if(x >y) begin 
            max_val = x;
            return y;
        end
        else begin
            max_val = y;
            return x;
        end        
    endfunction

    // pass arguements by value function
    // this function accepts arguments in "pass by value" mode
    // and hence copies whatever arguments it gets into this local
    // variable call 'a'.
    function int fn(int a);
        // Any change to this local variable is not reflected in the main 
        // variable declared above within the initial block.
        a = a + 5;
        return a * 10;
    endfunction

    // Use the 'ref' keyword to make this funciton accepts argument by reference
    function automatic int fn_ref(ref int a);

        // Any change to this local variable will be reflected in the main  variable
        // declared within the initial block.
        a  = a + 5;

        return a * 10;
        
    endfunction

endmodule