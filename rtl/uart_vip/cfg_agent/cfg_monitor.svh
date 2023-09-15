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
// FILE         :   cfg_monitor.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm monitor for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  25-Aug-2023      Kasun        creation
//
//**************************************************************************************************

class cfg_monitor extends uvm_monitor;
    `uvm_component_utils(cfg_monitor)

    virtual udma_if vif;
    
    uvm_analysis_port #(cfg_seq_item) cfg_analysis_port;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="cfg_monitor", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[MONITOR]","constructor", UVM_LOW)
        cfg_analysis_port = new("cfg_analysis_port",this);
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    virtual function void build_phase(uvm_phase phase);
        `uvm_info("[MONITOR]","build_phase", UVM_LOW)
        if(!uvm_config_db #(virtual udma_if)::get(this,"*","vif",vif)) begin
            `uvm_fatal("cfg_monitor/build_phase","No virtual interface specified for this monitor instance");
        end
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[MONITOR]","run_phase", UVM_LOW)
        forever begin
            cfg_seq_item cfg_transaction;

            @(posedge vif.sys_clk_i);
            //create a transaction object
            cfg_transaction = cfg_seq_item::type_id::create("cfg_transaction",this);
            `uvm_info("[MONITOR]","after create transaction",UVM_LOW)
            // check this is a valid signal
            if(vif.cfg_valid_i) begin
                $display("cfg_data_i %d", vif.cfg_data_i);
                cfg_analysis_port.write(cfg_transaction);
            end
        end
    endtask: run_phase
endclass : cfg_monitor