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
// FILE         :   udma_rx_agent.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for udma_rx agent
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  20-Oct-2023      Kasun        creation
//
//**************************************************************************************************
class udma_rx_agent extends uvm_agent;
    `uvm_component_utils(udma_rx_agent)

    //declare driver, monitor and sequencer
    udma_rx_driver                          driver;
    udma_rx_monitor                         monitor;
    uvm_sequncer #(udma_rx_seq_item)        sequencer;

    uvm_analysis_port  #(udma_rx_seq_item)  udma_rx_aport;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="udma_rx_agent",uvm_component parent);
        super.new(name, parent);
        `uvm_info("[UVM agent / udma_rx]","constructor", UVM_HIGH)
    endfunction: new 

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase)
        `uvm_info("[UVM agent / uart_rx]", "build_phase", UVM_HIGH)
        
        driver                      = udma_rx_driver::type_id::create("udma_rx_driver", this);
        monitor                     = udma_rx_monitor::type_id::create("udma_rx_monitor",this);
        sequencer                   = uvm_sequencer #(udma_rx_seq_item)::type_id::create("udma_rx_sequencer",this);
        udma_rx_aport               = new("udma_rx_aport",this);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        `uvm_info("AGENT","connect_phase",UVM_HIGH)
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        udma_rx_aport = monitor.udma_aport;
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask: run_phase    

endclass : udma_rx_agent