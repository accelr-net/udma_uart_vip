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
// FILE         :   uart_env.svh
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
class uart_env extends uvm_env;
    `uvm_component_utils(uart_env)
    cfg_agent               cfg_agnt;
    uart_rx_agent           uart_rx_agnt;
    env_config              env_configs;
    uart_rx_agent_config    uart_rx_config;
    cfg_agent_config        cfg_config;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_env",uvm_component parent);
        super.new(name,parent);
        `uvm_info("[ENV]","constructor",UVM_LOW)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("[ENV]","build_phase",UVM_LOW)
        cfg_agnt            = cfg_agent::type_id::create("cfg_agent",this);
        uart_rx_agnt        = uart_rx_agent::type_id::create("uart_rx_agnt",this);

        //create configuration objects for agents
        uart_rx_config      = uart_rx_agent_config::type_id::create("uart_rx_config",this);
        cfg_config          = cfg_agent_config::type_id::create("cfg_config",this);

        //get environment configs
        if(!uvm_config_db #(env_config)::get(this,"","env_configs",env_configs)) begin
            $display("cannot find environment configs ");
        end

        //set for agent configuration
        cfg_config.baud_rate        = env_configs.baud_rate;
        cfg_config.frequency        = env_configs.frequency;

        uart_rx_config.baud_rate    = env_configs.baud_rate;
        uart_rx_config.parity_en    = env_configs.parity_bit_enable;
        uart_rx_config.char_length  = env_configs.char_length;
        uart_rx_config.stop_bits    = env_configs.stop_bits;

        //set configuration into the databse 
        uvm_config_db #(cfg_agent_config)::set(this,"cfg_agent.*","cfg_config",cfg_config);
        uvm_config_db #(uart_rx_agent_config)::set(this,"uart_rx_agnt.*","uart_config",uart_rx_config);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        `uvm_info("[ENV]","run_phase",UVM_LOW)
    endtask: run_phase
endclass : uart_env