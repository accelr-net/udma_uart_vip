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
// FILE         :   uart_test.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all svh file for uart RX agent
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  18-Sep-2023      Kasun        creation
//
//**************************************************************************************************
class uart_test extends uvm_test;
    `uvm_component_utils(uart_test)

    cfg_env             env;
    uart_rx_env         rx_env;

    virtual     uart_if     uart_vif;
    virtual     udma_if     vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="cfg_test",uvm_component parent);
        super.new(name,parent);
        `uvm_info("[TEST]","top level tconstructor", UVM_LOW)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    //In build phase construct the cfg_env class using factory and
    //Get the virtual interface handle from test then set it config db for the env
    function void build_phase(uvm_phase phase);
        `uvm_info("[TEST]","build_phase", UVM_LOW)
        env     = cfg_env::type_id::create("env",this);
        rx_env  = uart_rx_env::type_id::create("rx_env",this);
   endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------   
    //Run phase create an cfg_sequence
    task run_phase(uvm_phase phase);
        // `uvm_info("[TEST]","run_phase",UVM_LOW)
        cfg_sequence        cfg_seq;
        uart_rx_sequence    rx_seq;
        phase.raise_objection(this, "Starting uvm sequence...");
        repeat(5) begin
            cfg_seq = cfg_sequence::type_id::create("cfg_seq");
            cfg_seq.start(env.cfg_agnt.sequencer);
            #10;
        end
        phase.drop_objection(this);

        phase.raise_objection(this,"rx_data");
        repeat(5) begin
            rx_seq = uart_rx_sequence::type_id::create("uart_rx_seq");
            rx_seq.start(rx_env.agent.sequencer);
        end
        phase.drop_objection(this);
    endtask: run_phase

endclass: uart_test