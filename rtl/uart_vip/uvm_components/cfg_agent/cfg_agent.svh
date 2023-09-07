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
    uvm_sequencer #(cfg_seq_item) sequencer;
    
    //virtual interface
    virtual udma_if vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_agent",uvm_component parent);
        super.new(name,parent);
        `uvm_info("[UVM agent]","constructor", UVM_MEDIUM)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        `uvm_info("[UVM agent]","build_phase", UVM_MEDIUM)
        driver  = cfg_driver::type_id::create("driver",this);
        monitor = cfg_monitor::type_id::create("monitor",this);
        sequencer = uvm_sequencer #(cfg_seq_item)::type_id::create("sequencer",this);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        `uvm_info("[UVM agent]","connect_phase", UVM_MEDIUM)
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask
endclass : cfg_agent