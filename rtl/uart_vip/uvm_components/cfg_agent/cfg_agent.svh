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
// FILE         :   cfg_agent.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm agent for cfg. 
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

class cfg_agent extends uvm_agent;
    `uvm_component_utils(cfg_agent)
    
    //Agent will have driver, monitor component
    cfg_driver      driver;
    cfg_monitor     monitor;
    cfg_sequencer   sequencer;
    
    //virtual interface
    virtual udma_if vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_agent",uvm_component parent);
        super.new(name,parent);
        $display("[AGENT] - constructor");
        `uvm_info("AGENT","constructor",UVM_HIGH)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        $display("[AGENT] - build_phase");
        driver  = cfg_driver::type_id::create("driver",this);
        monitor = cfg_monitor::type_id::create("monitor",this);
        sequencer = cfg_sequencer::type_id::create("sequencer",this);

        // if(!uvm_config_db#(virtual udma_if)::get(this,"*","vif",vif)) begin
        //     `uvm_fatal("cfg_agent","No virtual interface specified for this agent instance")
        // end
        // uvm_config_db #(virtual udma_if)::set(this,"driver","vif",vif);
        // uvm_config_db #(virtual udma_if)::set(this,"monitor","vif",vif);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        $display("[AGENT] - connect_phase");
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask

endclass : cfg_agent