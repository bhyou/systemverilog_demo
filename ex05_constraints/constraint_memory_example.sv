/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_memory_example.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 28 Jun 2021 08:57:20 AM CST
 ************************************************************************/
 
class memBlock;

    bit [31:0]     m_ram_start ; // start address of RAM
    bit [31:0]     m_ram_end ;   // end address of RAM

    rand bit [31:0]   m_start_addr;  // pointer to start addr of block
    rand bit [31:0]   m_end_addr  ;  // pointer to last addr of block
    rand int          m_block_size;  // block size in KB

    constraint c_addr { m_start_addr >= m_ram_start ;
                        m_end_addr <  m_ram_end   ;
                        m_start_addr % 4 == 0;
                        m_end_addr == m_start_addr + m_block_size -1 ; }

    constraint c_block_size { m_block_size inside {64, 128, 512} ;}
    function void print();
        $display("----------- Memory Block ------------");
        $display("RAM Start Addr   = 0x%0h", m_ram_start);
        $display("RAM End Addr     = 0x%0h", m_ram_end);
        $display("Block Start Addr = 0x%0h", m_start_addr);
        $display("Block End Addr   = 0x%0h", m_end_addr);
        $display("Block Size       = %0d bytes", m_block_size);
    endfunction

endclass //memBlock

class PartBlock;

    bit [31:0]     m_ram_start ; // start address of RAM
    bit [31:0]     m_ram_end ;   // end address of RAM

    rand int          m_num_part    ;  // number of parttions
    rand bit [31:0]   m_part_start [];  // pointer to start addr of block
    rand int          m_part_size [] ;     // size of each partition
    rand int          m_tmp         ;

    constraint c_partrs { m_num_part inside {[1:9]}; }

    constraint c_size { m_part_size.size() == m_num_part ;
                        m_part_size.sum() == m_ram_end - m_ram_start + 1;
                        foreach (m_part_size[i])
                            m_part_size[i] inside {16, 32, 64, 128, 256, 512};
    }

    constraint c_start { m_part_start.size() == m_num_part;
                         foreach (m_part_start[i])
                            if(i)
                                m_part_start[i] == m_part_start[i-1] + m_part_size[i-1];
                            else
                                m_part_start[i] == m_ram_start;
    }

    function void print();
        $display("----------- Memory Block ------------");
        $display("RAM Start Addr   = 0x%0h", m_ram_start);
        $display("RAM End Addr     = 0x%0h", m_ram_end);
        $display("# Partitions     = %0d", m_num_part);
        $display("----------- Partitions Block ------------");
        foreach (m_part_size[i])
            $display("Partition %0d start = 0x%0h, size = %0d bytes", i, m_part_start[i], m_part_size[i]);
    endfunction
endclass //memBlock

program memBlock_test;
    memBlock MB;

    initial begin 
        MB = new();
        MB.m_ram_start = 32'h0;
        MB.m_ram_end   = 32'h7FF;
        MB.randomize();
        MB.print();
    end
endprogram


program part_test();
    PartBlock pb;
    initial begin
        pb = new();
        pb.m_ram_start = 32'h000;
        pb.m_ram_end   = 32'h7FF;
        pb.randomize();
        pb.print();
    end
endprogram

module testbench ;
        part_test();
//    memBlock_test();
    
endmodul