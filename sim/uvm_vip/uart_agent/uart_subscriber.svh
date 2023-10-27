class uart_subscriber extends uvm_subscriber #(uart_seq_item);
    `uvm_component_utils(uart_subscriber)

    // uvm_analysis_imp #(uart_seq_item,uart_subscriber)    subscriber_export;

    function new(string name = "uart_subscriber", uvm_component parent);
        super.new(name,parent);
        // subscriber_export = new("subscriber_export",this);
    endfunction: new 

    virtual function void write(uart_seq_item t);
        bit [7:0] character;
        t.get_data(character);
        `uvm_info("UART_SUBSCRIBER",$sformatf("%s uart_subscriber item :  %d %s",PURPLE,character,WHITE),UVM_LOW);
    endfunction
endclass: uart_subscriber