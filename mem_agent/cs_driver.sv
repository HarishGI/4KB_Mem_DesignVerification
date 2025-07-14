class cs_driver extends uvm_driver#(cs_sequence_item);
  `uvm_component_utils(cs_driver)
  
  cs_sequence_item mem_item;
  virtual cs_mem_interface cs_mem_vintf;
  
  function new(string name="cs_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    `uvm_info(get_name(),"From Build_Phase -->CS_DRIVER", UVM_NONE);
    uvm_config_db#(virtual cs_mem_interface)::get(this,"","cs_mem_interface",cs_mem_vintf);
  endfunction
  
task run_phase(uvm_phase phase);
  forever
    begin
      seq_item_port.get_next_item(mem_item);
      run_txn();
      `uvm_info(get_full_name(),$sformatf("---->Driver Driven Data to DUT----->"),UVM_NONE);
      seq_item_port.item_done();
      mem_item.print();
    end
endtask
  
  
task run_txn();
        if(mem_item.wr_rd ==1)
          begin
            mem_wr();
          end else begin
            mem_rd();
          end
  endtask
 
  task mem_wr();
    @(cs_mem_vintf.drv_cb);
    cs_mem_vintf.drv_cb.addr<=mem_item.addr;
    cs_mem_vintf.drv_cb.wdata<=mem_item.data;
    cs_mem_vintf.drv_cb.wr_rd<=1;
    cs_mem_vintf.drv_cb.valid<=1;
    forever
      begin
        @(cs_mem_vintf.drv_cb);
        if(cs_mem_vintf.drv_cb.ready==1)
          break;
      end
      cs_mem_vintf.drv_cb.valid<=0;
  endtask
  
  task mem_rd();
    @(cs_mem_vintf.drv_cb);
    cs_mem_vintf.drv_cb.addr<=mem_item.addr;
    cs_mem_vintf.drv_cb.wr_rd<=0;
    cs_mem_vintf.drv_cb.valid<=1;
    forever
      begin
        @(cs_mem_vintf.drv_cb);
        if(cs_mem_vintf.drv_cb.ready==1)
          break;
      end
      cs_mem_vintf.drv_cb.valid<=0;
  endtask
    
endclass