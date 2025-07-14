class cs_sequence_item extends uvm_sequence_item;
  rand bit [14:0]addr;
  rand bit [31:0]data;
  rand bit wr_rd;
  rand bit err_gen;
  constraint addr_err_gen { if(err_gen == 0)
                           {
                             addr<1024;
                           }else{
                             addr>1023;
                           }
    }
  
 `uvm_object_utils_begin(cs_sequence_item)
  `uvm_field_int(addr, UVM_ALL_ON)
  `uvm_field_int(data, UVM_ALL_ON)
  `uvm_field_int(wr_rd, UVM_ALL_ON)
  `uvm_field_int(err_gen, UVM_ALL_ON)
 `uvm_object_utils_end
  
  function new(string name="cs_sequence_item");
    super.new(name);
  endfunction
  
endclass