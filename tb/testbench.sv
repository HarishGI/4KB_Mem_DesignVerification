// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
 import uvm_pkg::*;

`include "cs_mem_interface.sv"
`include "cs_sequence_item.sv"
`include "cs_sequence.sv"
`include "cs_sequencer.sv"
`include "cs_driver.sv"
`include "cs_monitor.sv"
`include "cs_agent.sv"
`include "cs_scoreboard.sv"
`include "cs_environment.sv"
`include "cs_test.sv"

module testbench();
  bit tb_clk=0;
  bit tb_rst_n=1;
  
  cs_mem_interface cs_mem_intf();
  mem_1024_32 dut_mem(.mem_intf(cs_mem_intf));
  
  always #500 tb_clk = ~tb_clk;
  assign cs_mem_intf.clk = tb_clk;
  assign cs_mem_intf.rst_n = tb_rst_n;
    
  initial begin
    run_test("cs_test");
  end
  
  initial
    begin
      uvm_config_db#(virtual cs_mem_interface)::set(null,"*","cs_mem_interface",cs_mem_intf);
      cs_mem_intf.valid=0;
      #500;
      tb_rst_n=0; //Issue active low reset
      #500;
      tb_rst_n=1;
      cs_mem_intf.valid=1;
      
      $dumpfile("dump.vcd");
      $dumpvars(0);
      #100000 $finish;
    end
endmodule