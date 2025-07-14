class cs_test extends uvm_test;
  `uvm_component_utils(cs_test);
  cs_environment cs_env;
  cs_sequence cs_seq;
  
  function new(string name="cs_test", uvm_component parent);
    super.new(name,parent);
  endfunction
  
   function void build_phase(uvm_phase phase);
     `uvm_info(get_name(),"Build_phase--->From CS_TEST",UVM_NONE);
     cs_env=cs_environment::type_id::create("cs_env",this);
     cs_seq=cs_sequence::type_id::create("cs_seq");
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info(get_name(),"Run_phase--->From CS_TEST",UVM_NONE);
    phase.raise_objection(this);
    cs_seq.start(cs_env.cs_agnt.cs_sqr);
    phase.drop_objection(this);
  endtask
endclass