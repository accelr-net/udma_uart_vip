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
// FILE         :   uart_base_test.svh
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
class uart_base_test extends uvm_test;
    `uvm_component_utils(uart_base_test)
    //primary configurations
    int                                 baud_rate           = 115200;
    int                                 char_length         = 8;
    int                                 clock_frequency     = 50000000;
    int                                 stop_bits           = 1;
    bit                                 parity_en           = 1'b0;
    int                                 clock_period;
    bit                                 rx_ena              = 1'b1;
    bit                                 tx_ena              = 1'b1;

    bit                                 error_inject_enabled = 1'b0;

    uart_env                            env;
    env_config                          env_config_obj;

//---------------------------------------------------------------------------------------------------------------------
// Set parameter methods
//---------------------------------------------------------------------------------------------------------------------
    virtual function void set_baud_rate(int baud_rate);
        this.baud_rate = baud_rate;
    endfunction: set_baud_rate
    
    virtual function void set_char_length(int char_length);
        this.char_length = char_length;
    endfunction: set_char_length

    virtual function void set_stop_bits(int stop_bits);
        this.stop_bits = stop_bits;
    endfunction: set_stop_bits

    virtual function void set_parity_en(bit parity_en);
        this.parity_en = parity_en;
    endfunction: set_parity_en

    virtual function void set_rx_ena(bit rx_ena);
        this.rx_ena = rx_ena;
    endfunction: set_rx_ena

    virtual function void set_tx_ena(bit tx_ena);
        this.tx_ena = tx_ena;
    endfunction: set_tx_ena

    virtual function void enable_error_injection(bit error_inject_enabled);
        this.error_inject_enabled = error_inject_enabled;
    endfunction: enable_error_injection
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_base_test",uvm_component parent);
        super.new(name,parent);
        `uvm_info("[TEST]","top level uart_base_test constructor", UVM_LOW)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    //In build phase construct the cfg_env class using factory and
    //Get the virtual interface handle from test then set it config db for the env
    function void build_phase(uvm_phase phase);
        `uvm_info("[TEST]","build_phase", UVM_LOW)
        
        //get values from top
        if(!uvm_config_db #(int)::get(this,"","clock_period",clock_period)) begin
            `uvm_fatal("[TEST]","Cannot find clock_period value!");
        end
        if(!uvm_config_db #(int)::get(this,"","clock_frequency",clock_frequency)) begin
            `uvm_fatal("[TEST]","Cannot find clock frequency!");
        end
        env_config_obj  = env_config::type_id::create("env_config_obj",this);
        env             = uart_env::type_id::create("env",this);

        //assign values to objects 
        env_config_obj.baud_rate    = baud_rate;
        env_config_obj.clock_freq   = clock_frequency;
        env_config_obj.char_length  = char_length;
        env_config_obj.stop_bits    = stop_bits;
        env_config_obj.clock_period = clock_period;
        env_config_obj.parity_en    = parity_en;
        env_config_obj.rx_ena       = rx_ena;
        env_config_obj.tx_ena       = tx_ena;

        //set environment configuration into the config_db
        uvm_config_db #(env_config)::set(this,"env","env_configs",env_config_obj);
        uvm_config_db #(int)::set(null,"*","baud_rate",baud_rate);
        uvm_config_db #(int)::set(null,"*","clock_freq",clock_frequency);
        uvm_config_db #(int)::set(null,"*","char_length",char_length);
        uvm_config_db #(int)::set(null,"*","stop_bits",stop_bits);
        uvm_config_db #(bit)::set(null,"*","parity_en",parity_en);
        uvm_config_db #(bit)::set(null,"*","rx_ena",rx_ena);
        uvm_config_db #(bit)::set(null,"*","tx_ena",tx_ena);
        uvm_config_db #(bit)::set(null,"*","parity_error",error_inject_enabled);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------   
    task run_phase(uvm_phase phase);
        // `uvm_info("[TEST]","run_phase",UVM_LOW)
        cfg_sequence        cfg_seq;
        uart_sequence       uart_rx_seq;
        udma_rx_sequence    udma_rx_seq; 
        udma_tx_sequence    udma_tx_seq;
        phase.raise_objection(this, "Starting uvm sequence...");
        cfg_seq = cfg_sequence::type_id::create("cfg_seq");
        cfg_seq.start(env.cfg_agnt.sequencer);
        #10;
        phase.drop_objection(this);

        phase.raise_objection(this,"rx_data");
        uart_rx_seq = uart_sequence::type_id::create("uart_rx_seq");
        udma_rx_seq = udma_rx_sequence::type_id::create("udma_rx_seq");
        udma_tx_seq = udma_tx_sequence::type_id::create("udma_tx_seq");
        fork
            uart_rx_seq.start(env.uart_rx_agnt.sequencer);
            udma_rx_seq.start(env.udma_rx_agnt.sequencer);
            udma_tx_seq.start(env.udma_tx_agnt.sequencer);
        join_any

        #100000ns;
        phase.drop_objection(this);
    endtask: run_phase
endclass: uart_base_test