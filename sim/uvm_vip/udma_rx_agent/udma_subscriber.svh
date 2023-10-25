class udma_subscriber extends uvm_subsriber;
    `uvm_component_utils(udma_subscriber)

    uvm_analysis_imp    #(udma_rx_seq_item,udma_subscriber)     sub_export;

    function new(string name="udma_subscriber",uvm_component parent);
        super.new(name,parent);
        sub_export = new("sub_export",this);
    endfunction: new

    function void write(udma_rx_seq_item item);
        `uvm_info("UDMA_SUBSCRIBER",$sformatf("udma_subscriber item : %p",item),UVM_LOW);
    endfunction: write
endfunction: udma_subscriber