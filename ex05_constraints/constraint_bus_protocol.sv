/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_bus_protocol.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Mon 28 Jun 2021 08:45:40 AM CST
 ************************************************************************/
 
class busTransaction;

    rand int         m_addr;
    rand bit [31:0]  m_data;
    rand bit  [1:0]  m_burst;  // size of a single transaction in byte (4 biyes max)
    rand bit  [2:0]  m_length; // Total number of transactions

    constraint c_addr { m_addr % 4 == 0;  } // always aligned 4-byte boundary

    function  void print(int idx = 0);
        $display("---------- Transaction %0d -----------",idx);
        $display("Addr     = 0x%0h", m_addr);
        $display("Data     = 0x%0h", m_data);
        $display("Burst    = 0x%0h", m_burst);
        $display("Length   = 0x%0h", m_length);
    endfunction

endclass //busTransaction


program tb;
    int  slave_start;
    int  slave_end  ;
    busTransaction  btrns ;

    initial begin
        slave_start = 32'h200;
        slave_end   = 32'h800;
        btrns= new();

        btrns.randomize() with {
            m_addr >= slave_start;
            m_addr <= slave_end;
            (m_burst + 1) * (m_length + 1) + m_addr < slave_end;
        };

        btrns.print();
    end

endprogram