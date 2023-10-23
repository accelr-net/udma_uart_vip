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
// FILE         :   uart_agent_config.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for configuration for uart_agent. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  20-Sep-2023      Kasun        creation
//
//**************************************************************************************************

class udma_rx_monitor extends uvm_monitor;
    `uvm_component_utils(udma_rx_monitor)

    virtual udma_if         vif;

    uvm_analysis_port #(udma_rx_seq_item)   udma_aport;

    function new(string name="udma_rx_monitor",uvm_component parent);
        super.new(name,parent);
        udma_aport  = new("udma_aport",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("MONITOR","build_phase",UVM_HIGH)
        if(!uvm_config_db #(virtual udma_if)::get(this,"","vif",vif)) begin
            `uvm_fatal("[MONITOR]","No virtual interface specified for this monitor instance")
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[MONITOR]","run_phase",UVM_HIGH)
        forever begin
            udma_rx_seq_item        udma_rx_transaction;
            $display("--------------udma_rx monitor------------");
            udma_rx_transaction  =  udma_rx_seq_item::type_id::create("udma_rx_transaction",this);
            @(posedge vif.sys_clk_i);
            if(vif.data_rx_valid_o) begin
                udma_rx_transaction.data = vif.data_rx_o;
                $display("vif.data_rx_o %p",vif.data_rx_o);
                udma_aport.write(udma_rx_transaction);
            end
            $display("udma_rx_transaction : %p",udma_rx_transaction.data);
        end
    endtask: run_phase

endclass: udma_rx_monitor