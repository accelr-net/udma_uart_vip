// ************************************************************************************************
//
// Copyright(C) 2023 ACCELR
// All rights reserved.
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
// ACCELER LOGIC (PVT) LTD, SRI LANKA.
//
// This copy of the Source Code is intended for ACCELR's internal use only and is
// intended for view by persons duly authorized by the management of ACCELR. No
// part of this file may be reproduced or distributed in any form or by any
// means without the written approval of the Management of ACCELR.
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka         +94 77 3166850
//
// ************************************************************************************************
//
// PROJECT      :   UART Verification Env
// PRODUCT      :   N/A
// FILE         :   uart_rx_monitor.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm monitor for uart RX. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  11-Sep-2023      Kasun        creation
//
//**************************************************************************************************
class uart_rx_monitor extends uvm_monitor;
    `uvm_component_utils(uart_rx_monitor)

    virtual uart_if                             intf_uart_side;
    uart_rx_agent_config                        rx_config;
    uvm_analysis_port #(uart_rx_seq_item)       uart_rx_analysis_port;

    function new(string name="uart_rx_monitor", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[monitor]", "constructor", UVM_LOW)

        uart_rx_analysis_port   = new("uart_rx_analysis_port",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info("MONITOR","build_phase", UVM_LOW)
        if(!uvm_config_db #(virtual uart_if)::get(this, "*","intf_uart_side",intf_uart_side)) begin
            `uvm_fatal("[MONITOR]","No virtual interface specified for this monitor instance")
        end
        uvm_config_db #(uart_rx_agent_config)::get(this,"","uart_config",rx_config);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[MONITOR]","run_phase",UVM_LOW)

        forever begin
            uart_rx_seq_item   uart_rx_transaction;
            bit                parity;
            //create a transaction object 
            uart_rx_transaction = uart_rx_seq_item::type_id::create("uart_rx_transaction",this);
            uart_rx_transaction.character_length = rx_config.char_length;

            @(negedge intf_uart_side.uart_rx_i);
            #(rx_config.period/2);
            #rx_config.period; // wait for start_bit
            //getting character
            for(int i=0; i < rx_config.char_length; i++) begin
                uart_rx_transaction.character[i] = intf_uart_side.uart_rx_i;
                #rx_config.period;
            end
            //get parity
            if(rx_config.parity_en == uart_rx_seq_item::PARITY_ENABLE) begin
                uart_rx_transaction.parity   = intf_uart_side.uart_rx_i;
                #rx_config.period; 
            end
            //delay for 2 stopbits 
            if(rx_config.stop_bits == 2) begin
                #rx_config.period;
            end
            #(rx_config.period/2); // wait for stop
            uart_rx_analysis_port.write(uart_rx_transaction);
        end
    endtask: run_phase
endclass: uart_rx_monitor