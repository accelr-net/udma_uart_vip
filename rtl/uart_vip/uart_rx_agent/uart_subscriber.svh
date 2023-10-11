class uart_subscriber extends uvm_component;
    `uvm_component_utils(uart_subscriber)

    uvm_analysis_imp #(uart_seq_item,uart_subscriber)    subscriber_export;

    function new(string name = "uart_subscriber", uvm_component parent);
        super.new(name,parent);
        subscriber_export = new("subscriber_export",this);
    endfunction: new 

    function void write(uart_seq_item item);
        `uvm_info("UART_SUBSCRIBER",$sformatf("uart_subscriber item :  %p",item),UVM_LOW);
    endfunction
endclass: uart_subscriber