/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : example_part_for_prgm_data.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 28 Jun 2021 09:36:05 AM CST
 ************************************************************************/
 
typedef struct packed {
    int start_addr;
    int end_start ;
} e_range;


class space;

    rand int  num_pgm  ;  // Total number of program blocks
    rand int  num_data ;
    rand int  num_space;

    rand int  max_pgm_size ;
    rand int  max_data_size;

    rand int pgm_size [] ;
    rand int data_size [];
    rand int space_size[];

    int total_ram ;

    constraint c_num_size { max_}

    function print();
        
    endfunction //new()
endclass //space