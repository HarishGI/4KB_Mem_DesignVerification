class cs_monitor extends uvm_monitor;
  `uvm_component_utils (cs_monitor)
  
  cs_sequence_item mem_item;
  virtual cs_mem_interface cs_mem_vintf;
  uvm_analysis_port#(cs_sequence_item) analysis_port_mon;
  
  function new(string name = "cs_monitor", uvm_component parent);
    super.new(name, parent);
    analysis_port_mon=new("Analysis_port_mon",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(),"From Build_Phase -->CS_MON", UVM_NONE);
    mem_item=cs_sequence_item::type_id::create("mem_item");
    uvm_config_db#(virtual cs_mem_interface)::get(this,"*","cs_mem_interface", cs_mem_vintf);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        run_mon();
      end
  endtask
  
  task run_mon();
    fork
      begin
        mon_wr();
      end
      begin      
        mon_rd();
      end 
    join
  endtask
  
  task mon_wr();
    forever begin
      @(cs_mem_vintf.mon_cb);
      if (cs_mem_vintf.mon_cb.valid ==1 && cs_mem_vintf.mon_cb.ready==1 && cs_mem_vintf.mon_cb.wr_rd ==1)
        begin
          mem_item.addr=cs_mem_vintf.mon_cb.addr;
          mem_item.data=cs_mem_vintf.mon_cb.wdata;
          mem_item.wr_rd=1;
        end
      analysis_port_mon.write(mem_item);
    end
  endtask
  
  task mon_rd();
    forever begin
      @(cs_mem_vintf.mon_cb);
      if (cs_mem_vintf.mon_cb.valid ==1 && cs_mem_vintf.mon_cb.ready==1 && cs_mem_vintf.mon_cb.wr_rd ==0)
        begin
          mem_item.addr=cs_mem_vintf.mon_cb.addr;
          mem_item.data=cs_mem_vintf.mon_cb.rdata; 
          mem_item.wr_rd=0;
        end
      analysis_port_mon.write(mem_item);
    end
  endtask
  
endclass