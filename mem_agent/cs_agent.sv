class cs_agent extends uvm_agent;
  `uvm_component_utils(cs_agent)
  cs_driver cs_drv;
  cs_sequencer cs_sqr;
  cs_monitor cs_mon;
  
  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(),"Build_phase--->From CS_AGENT",UVM_NONE);
    cs_sqr=cs_sequencer::type_id::create("cs_sqr",this);
    cs_drv=cs_driver::type_id::create("cs_drv",this);
    cs_mon=cs_monitor::type_id::create("cs_mon",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    cs_drv.seq_item_port.connect(cs_sqr.seq_item_export);
    `uvm_info(get_name(),"Driver and Sequencer Ports are connected",UVM_NONE);
  endfunction
  
endclass