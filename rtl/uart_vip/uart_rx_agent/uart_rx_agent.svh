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
// FILE         :   uart_rx_agent.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm agent for uart RX. 
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

class uart_rx_agent extends uvm_agent;
    `uvm_component_utils(uart_rx_agent)

    //Agent have driver, monitor and sequencer
    uart_rx_driver                          driver;
    uart_rx_monitor                         monitor; 
    uvm_sequencer  #(uart_rx_seq_item)      sequencer;
    
    //virtual interface
    virtual uart_if                         vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_rx_agent",uvm_component parent);
        super.new(name, parent);
        `uvm_info("[UVM agent / uart_rx]","constructor", UVM_LOW)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        `uvm_info("[UVM agent / uart_rx]", "build_phase", UVM_LOW)
        driver      = uart_rx_driver::type_id::create("driver", this);
        monitor     = uart_rx_monitor::type_id::create("monitor",this);
        sequencer   = uvm_sequencer #(uart_rx_seq_item)::type_id::create("sequencer",this);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        `uvm_info("AGENT","connect_phase",UVM_LOW)
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
       super.run_phase(phase);
    endtask: run_phase
endclass : uart_rx_agent