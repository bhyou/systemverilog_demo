/*************************************************************************
 > Copyright (C) 2021 Sangfor Ltd. All rights reserved.
 > File Name   : constraint_foreach.sv
 > Author      : bhyou
 > Mail        : bhyou@foxmail.com 
 > Created Time: Sun 27 Jun 2021 09:13:53 PM CST
 ************************************************************************/
 
//constraint constraint_name { foreach ( variable[iterator] )  variable[iterator] <..conditions..>  }


class packet;
  rand byte addr [];
  rand byte data [];
 
  constraint avalues { foreach( addr[i] ) addr[i] inside {4,8,12,16}; }
  constraint dvalues { foreach( data[j] ) data[j] > 4 * j; }
  constraint asize   { addr.size < 4; }
  constraint dsize   { data.size == addr.size; }
endclass
 
module constr_iteration;
  initial begin
    packet pkt;
    pkt = new();
 
    $display("------------------------------------");
    repeat(2) begin
      pkt.randomize();
      $display("\taddr-size = %0d data-size = %0d",pkt.addr.size(),pkt.data.size());
      foreach(pkt.addr[i]) $display("\taddr = %0d data = %0d",pkt.addr[i],pkt.data[i]);
      $display("------------------------------------");
    end
  end
endmodule