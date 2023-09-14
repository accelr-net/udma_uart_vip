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

    virtual uart_if     vif;

    uvm_analysis_port #(uart_rx_seq_item)       uart_rx_analysis_port;

    function new(string name="uart_rx_monitor", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[monitor]", "constructor", UVM_LOW)

        uart_rx_analysis_port   = new("uart_rx_analysis_port",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info("MONITOR","build_phase", UVM_LOW)
        if(!uvm_config_db #(virtual udma_if)::get(this, "*","vif",vif)) begin
            `uvm_fatal("[MONITOR]","No virtual interface specified for this monitor instance")
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[MONITOR]","run_phase",UVM_LOW)

        forever begin
            uart_rx_seq_item    uart_rx_transaction;

            @(posedge vif.sys_clk_i);
            //create a transaction object 
            uart_rx_transaction = uart_rx_seq_item::type_id::create("uart_rx_transaction",this);
        end
    endtask: run_phase

endclass