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
// FILE         :   uart_rx_driver.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm driver for uart RX. 
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
class uart_rx_driver extends uvm_driver #(uart_rx_seq_item);
    `uvm_component_utils(uart_rx_driver)
    parameter               char_length = 8;
    virtual uart_if         intf_uart_side;
    int                     period;

    uart_rx_agent_config    rx_config;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_rx_driver", uvm_component parent);
        super.new(name,parent);
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual uart_if)::get(this,"*","intf_uart_side",intf_uart_side)) begin
            `uvm_fatal("uart_rx_driver/build_phase","No virtual interface is found");
        end

        if(!uvm_config_db #(uart_rx_agent_config)::get(this,"","uart_config",rx_config)) begin
            `uvm_fatal("uart_rx_driver/build_phase","Please set uart_rx_configs connot find uart_config from uvm_config_db");
        end
        uvm_config_db #(int)::get(this,"","period",period);
        $display("period %d",period);
        `uvm_info("[DRIVER]","build_phase",UVM_LOW);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("[DRIVER]","connect_phase",UVM_LOW);
    endfunction: connect_phase

    task configure_phase(uvm_phase phase);
        super.configure_phase(phase);
        `uvm_info("[DRIVER]", "configure_phase", UVM_LOW)
    endtask : configure_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[DRIVER]","run_phase",UVM_LOW)

        forever begin
            uart_rx_seq_item   uart_rx_transaction;
            uart_rx_transaction = uart_rx_seq_item::type_id::create("uart_rx_transaction");
            seq_item_port.get_next_item(uart_rx_transaction);
            $display("calling do_uart_rx");
            do_uart_rx(uart_rx_transaction);

            seq_item_port.item_done();
        end
    endtask: run_phase
    
    task do_uart_rx(uart_rx_seq_item    uart_rx_transaction);
        bit     parity;
        #period;
        intf_uart_side.uart_rx_i = 1'b0; //start bit
        for(integer i=0; i < $size(uart_rx_transaction.charactor); i++) begin
            #period;
            intf_uart_side.uart_rx_i   = uart_rx_transaction.charactor[i];
        end
        if(uart_rx_transaction.parity_en == uart_rx_seq_item::PARITY_ENABLE) begin
            #period;
            intf_uart_side.uart_rx_i   = 1'b1;
        end
        for(int j=0; j < rx_config.stop_bits; j++) begin
            #period;
            intf_uart_side.uart_rx_i = 1'b1; //stop bit
        end
    endtask: do_uart_rx
endclass: uart_rx_driver

