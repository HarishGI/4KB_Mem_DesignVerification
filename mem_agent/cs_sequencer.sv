class cs_sequencer extends uvm_sequencer#(cs_sequence_item);
  `uvm_component_utils(cs_sequencer)
  function new(string name="cs_sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction
endclass