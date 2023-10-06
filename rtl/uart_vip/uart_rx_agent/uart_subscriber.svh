class uart_subscriber extends uvm_component;
    `uvm_component_utils(uart_subscriber)

    uvm_analysis_imp #(uart_rx_seq_item,uart_subscriber)    subscriber_export;

    function new(string name = "uart_subscriber", uvm_component parent);
        super.new(name,parent);
        subscriber_export = new("subscriber_export",this);
    endfunction: new 

    function void write(uart_rx_seq_item item);
        $display("uart_subscriber item :  %p",item);
    endfunction
endclass: uart_subscriber