class cs_sequence extends uvm_sequence#(cs_sequence_item);
  `uvm_object_utils(cs_sequence)
  cs_sequence_item mem_item;
  
  function new(string name="cs_sequence");
    super.new(name);
  endfunction
  
  task body;
    repeat(5)
      begin
    wait_for_grant();
    mem_item=cs_sequence_item::type_id::create("mem_item");
    mem_item.randomize() with { data inside {[32'h00000000:32'hFFFFFFFF]};
                               addr inside {[90:100]};};
    `uvm_info(get_name(),"Sequence_Item Generated",UVM_NONE);
        //$display(mem_item.data, mem_item.addr, mem_item.wr_rd);
    send_request(mem_item);
    wait_for_item_done();
      end
  endtask
  
endclass
