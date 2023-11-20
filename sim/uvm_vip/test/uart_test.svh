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

//ToDo: change name uart_test into uart_base_test
class uart_test extends uvm_test;
    `uvm_component_utils(uart_test)
    //primary configurations
    int                                 baud_rate    = 115200;
    int                                 char_length  = 8;
    int                                 frequency    = 50000000;
    int                                 stop_bits    = 1;
    uart_seq_item::parity_type          parity_en    = uart_seq_item::PARITY_DISABLE;
    int                                 period;
    bit                                 rx_ena       = 1'b1;
    bit                                 tx_ena       = 1'b1;

    uart_env                            env;
    env_config                          env_config_obj;

    virtual     uart_if                 uart_vif;
    virtual     udma_if                 vif; //ToDo: change into vif into udma_vif

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

    virtual function void set_parity_en(uart_seq_item::parity_type parity_en);
        this.parity_en = parity_en;
    endfunction: set_parity_en

    virtual function void set_rx_ena(bit rx_ena);
        this.rx_ena = rx_ena;
    endfunction: set_rx_ena

    virtual function void set_tx_ena(bit tx_ena);
        this.tx_ena = tx_ena;
    endfunction: set_tx_ena
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_test",uvm_component parent);
        super.new(name,parent);
        `uvm_info("[TEST]","top level tconstructor", UVM_LOW)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    //In build phase construct the cfg_env class using factory and
    //Get the virtual interface handle from test then set it config db for the env
    function void build_phase(uvm_phase phase);
        $display("baud_rate %d",this.baud_rate);
        $display("char_length %d",this.char_length);
        `uvm_info("[TEST]","build_phase", UVM_LOW)
        
        //get values from top
        if(!uvm_config_db #(int)::get(this,"","period",period)) begin
            `uvm_fatal("[TEST]","Cannot find period value!");
        end
        env_config_obj  = env_config::type_id::create("env_config_obj",this);
        env             = uart_env::type_id::create("env",this);

        //assign values to objects 
        env_config_obj.baud_rate    = baud_rate;
        env_config_obj.frequency    = frequency;
        env_config_obj.char_length  = char_length;
        env_config_obj.stop_bits    = stop_bits;
        env_config_obj.period       = period;
        env_config_obj.parity_en    = parity_en;
        env_config_obj.rx_ena       = rx_ena;
        env_config_obj.tx_ena       = tx_ena;

        //set environment configuration into the config_db
        uvm_config_db #(env_config)::set(this,"env","env_configs",env_config_obj);
        uvm_config_db #(int)::set(null,"*","baud_rate",baud_rate);
        uvm_config_db #(int)::set(null,"*","frequency",frequency);
        uvm_config_db #(int)::set(null,"*","char_length",char_length);
        uvm_config_db #(int)::set(null,"*","stop_bits",stop_bits);
        uvm_config_db #(bit)::set(null,"*","parity_en",parity_en);

        //set configuration for cfg_sequence
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------   
    //Run phase create an cfg_sequence
    task run_phase(uvm_phase phase);
        // `uvm_info("[TEST]","run_phase",UVM_LOW)
        cfg_sequence        cfg_seq;
        uart_sequence       rx_seq;
        udma_rx_sequence    udma_rx_seq; 
        udma_tx_sequence    udma_tx_seq;
        phase.raise_objection(this, "Starting uvm sequence...");
        cfg_seq = cfg_sequence::type_id::create("cfg_seq");
        cfg_seq.start(env.cfg_agnt.sequencer);
        #10;
        phase.drop_objection(this);

        phase.raise_objection(this,"rx_data");
        rx_seq = uart_sequence::type_id::create("uart_rx_seq");
        udma_rx_seq = udma_rx_sequence::type_id::create("udma_rx_seq");
        udma_tx_seq = udma_tx_sequence::type_id::create("udma_tx_seq");
        fork
            rx_seq.start(env.uart_rx_agnt.sequencer);
            udma_rx_seq.start(env.udma_rx_agnt.sequencer);
            udma_tx_seq.start(env.udma_tx_agnt.sequencer);
        join_any

        #100000ns;
        phase.drop_objection(this);
    endtask: run_phase
endclass: uart_test