class cs_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (cs_scoreboard)
  bit [31:0] ref_mem[1024];
  uvm_analysis_imp#(cs_sequence_item, cs_scoreboard) analysis_imp_scb;
  
  
  function new (string name="scoreboard",uvm_component parent);
    super.new (name,parent);
    analysis_imp_scb=new("Analysis_imp_scb",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), "Build_Phase--->CS_SCOREBOARD", UVM_NONE);
  endfunction
  
  function void write(cs_sequence_item mem_item);
    if (mem_item.wr_rd == 1) begin
      ref_mem[mem_item.addr] = mem_item.data;
      `uvm_info(get_name(),
                $sformatf("Write Operation: addr=0x%0h data=0x%0h",mem_item.addr,mem_item.data), UVM_NONE)
    end 
    else begin
      if (ref_mem[mem_item.addr] == mem_item.data) begin
        `uvm_info(get_name(),
                  $sformatf("Read Data Matched: addr=0x%0h data=0x%0h", mem_item.addr,mem_item.data),UVM_LOW)
      end
      else begin
        `uvm_error(get_full_name(),
                   $sformatf("Read Data Mismatched: addr=0x%0h Expected=0x%0h Actual=0x%0h",
                             mem_item.addr, ref_mem[mem_item.addr], mem_item.data))
      end
    end
  endfunction
  
endclass