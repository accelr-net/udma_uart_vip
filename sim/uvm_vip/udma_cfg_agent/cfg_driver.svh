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
// FILE         :   cfg_driver.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm driver for cfg. 
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
class cfg_driver extends uvm_driver #(cfg_seq_item);
    `uvm_component_utils(cfg_driver)
    virtual udma_if     vif;
    cfg_agent_config    config_obj;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_driver", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[DRIVER]","constructor", UVM_LOW)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual udma_if)::get(this, "*", "vif",vif)) begin
            `uvm_fatal("cfg_driver/build_phase","No virtual interface specified for this driver instance");
        end
        `uvm_info("[DRIVER]","build_phase", UVM_LOW)
        uvm_config_db #(cfg_agent_config)::get(this,"","cfg_config",config_obj);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("[DRIVER]","connect_phase", UVM_LOW)
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[DRIVER]","run_phase", UVM_LOW)
        @(negedge vif.rstn_i);
        forever begin
            // @(posedge vif.sys_clk_i);
            cfg_seq_item cfg_transaction;

            @(posedge vif.sys_clk_i);
            //First get an item from sequencer
            cfg_transaction = cfg_seq_item::type_id::create("cfg_transaction");
            seq_item_port.try_next_item(cfg_transaction);
            if(cfg_transaction) begin
                cfg_transaction.print();
                `uvm_info("[DRIVER]","Transaction is sent", UVM_LOW)
                if(cfg_transaction.rw.name() == "WRITE") begin
                    do_config(cfg_transaction);
                end
                seq_item_port.item_done();
            end
        end
    endtask : run_phase

    task do_config(cfg_seq_item transaction);
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i      <= transaction.addr;
        vif.cfg_data_i      <= transaction.data;
        vif.cfg_rwn_i       <= 1'b0;
        vif.cfg_valid_i     <= 1'b1;
        @(posedge vif.sys_clk_i);
        vif.cfg_rwn_i       <= 1'b1;
        vif.cfg_valid_i     <= 1'b0;
    endtask: do_config 
endclass: cfg_driver