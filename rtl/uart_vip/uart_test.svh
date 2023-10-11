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
    //primary configurations
    int                                 baud_rate    = 115200;
    const int                           char_length  = 5;
    int                                 frequency    = 50000000;
    int                                 stop_bits    = 1;
    uart_seq_item::parity_type       parity_en    = uart_seq_item::PARITY_ENABLE;
    int                                 period;

    uart_env                            env;
    env_config                          env_config_obj;

    virtual     uart_if                 uart_vif;
    virtual     udma_if                 vif;

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
        
        //get values from top
        uvm_config_db #(int)::get(this,"","period",period);
        env_config_obj  = env_config::type_id::create("env_config_obj",this);
        env             = uart_env::type_id::create("env",this);

        //assign values to objects 
        env_config_obj.baud_rate    = baud_rate;
        env_config_obj.frequency    = frequency;
        env_config_obj.char_length  = char_length;
        env_config_obj.stop_bits    = stop_bits;
        env_config_obj.period       = period;
        env_config_obj.parity_en    = parity_en;

        //set environment configuration into the config_db
        uvm_config_db #(env_config)::set(this,"env","env_configs",env_config_obj);
        uvm_config_db #(int)::set(null,"*","baud_rate",baud_rate);
        uvm_config_db #(int)::set(null,"*","frequency",frequency);
        uvm_config_db #(int)::set(null,"*","char_length",char_length);
        uvm_config_db #(int)::set(null,"*","stop_bits",stop_bits);
        uvm_config_db #(bit)::set(null,"*","parity_en",parity_en);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------   
    //Run phase create an cfg_sequence
    task run_phase(uvm_phase phase);
        // `uvm_info("[TEST]","run_phase",UVM_LOW)
        cfg_sequence        cfg_seq;
        uart_sequence    rx_seq;
        phase.raise_objection(this, "Starting uvm sequence...");
        repeat(5) begin
            cfg_seq = cfg_sequence::type_id::create("cfg_seq");
            cfg_seq.start(env.cfg_agnt.sequencer);
            #10;
        end
        phase.drop_objection(this);

        phase.raise_objection(this,"rx_data");
        rx_seq = uart_sequence::type_id::create("uart_rx_seq");
        rx_seq.start(env.uart_rx_agnt.sequencer);
        phase.drop_objection(this);
    endtask: run_phase
endclass: uart_test