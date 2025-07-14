class cs_environment extends uvm_env;
  `uvm_component_utils(cs_environment);
  cs_agent cs_agnt;
  cs_scoreboard cs_scb;
  
  function new(string name="cs_environment", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    cs_scb=cs_scoreboard::type_id::create("cs_scb",this);
    cs_agnt=cs_agent::type_id::create("cs_agnt",this);
    `uvm_info(get_name(),"Build_phase--->From CS_ENV",UVM_NONE);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    cs_agnt.cs_mon.analysis_port_mon.connect(cs_scb.analysis_imp_scb);
    `uvm_info(get_name(),"Uvm analysis port Monitor <--> Scoreboard Connected",UVM_NONE);
    endfunction
endclass