// ************************************************************************************************
//
// Copyright 2023, Acceler Logic (Pvt) Ltd, Sri Lanka
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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
    env_config                                      env_configs;    
    udma_cfg_agent                                  cfg_agnt;

    //udma_rx
    udma_rx_agent                                   udma_rx_agnt;
    uart_agent                                      uart_rx_agnt;
    uart_udma_predictor                             udma_predictor;

    //udma_tx
    uart_agent                                      uart_tx_agnt;
    udma_tx_agent                                   udma_tx_agnt;
    udma_uart_predictor                             uart_predictor;

    //uart_checker
    uart_udma_checker                               uart_checker;
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
        uart_agent_config                               uart_rx_config; 
        uart_agent_config                               uart_tx_config; 
        analysis_configs                                analysis_cf;    

        super.build_phase(phase);
    
        cfg_agnt            = udma_cfg_agent::type_id::create("cfg_agnt",this);
        uart_rx_agnt        = uart_agent::type_id::create("uart_rx_agnt",this);
        uart_tx_agnt        = uart_agent::type_id::create("uart_tx_agnt",this);
        udma_rx_agnt        = udma_rx_agent::type_id::create("udma_rx_agnt",this);

        udma_predictor      = uart_udma_predictor::type_id::create("udma_predictor",this);
        uart_checker        = uart_udma_checker::type_id::create("uart_checker",this);

        uart_predictor      = udma_uart_predictor::type_id::create("uart_predictor",this);
        
        //create configuration objects for agents
        uart_rx_config      = uart_agent_config::type_id::create("uart_rx_config",this);
        uart_tx_config      = uart_agent_config::type_id::create("uart_tx_config",this);

        //udma_tx_agents
        udma_tx_agnt        = udma_tx_agent::type_id::create("udma_tx_agnt",this);

        analysis_cf         = analysis_configs::type_id::create("analysis_cf",this);

        //get environment configs
        if(!uvm_config_db #(env_config)::get(this,"","env_configs",env_configs)) begin
            `uvm_fatal("[ENV]","cannot find environment configs ")
        end

        uart_rx_config.baud_rate    = env_configs.baud_rate;
        uart_rx_config.parity_en    = env_configs.parity_en;
        uart_rx_config.char_length  = env_configs.char_length;
        uart_rx_config.stop_bits    = env_configs.stop_bits;
        uart_rx_config.clock_period = env_configs.clock_period;
        uart_rx_config.is_rx_agent  = 1'b1;

        uart_tx_config.baud_rate    = env_configs.baud_rate;
        uart_tx_config.parity_en    = env_configs.parity_en;
        uart_tx_config.char_length  = env_configs.char_length;
        uart_tx_config.stop_bits    = env_configs.stop_bits;
        uart_tx_config.clock_period = env_configs.clock_period;
        uart_tx_config.is_rx_agent  = 1'b0;

        analysis_cf.parity_en       = env_configs.parity_en;     
        analysis_cf.char_length     = env_configs.char_length;

        uvm_config_db #(uart_agent_config)::set(this,"uart_rx_agnt*","uart_config",uart_rx_config);
        uvm_config_db #(uart_agent_config)::set(this,"uart_tx_agnt*","uart_config",uart_tx_config);
        uvm_config_db #(analysis_configs)::set(this,"uart_predictor","analysis_cf",analysis_cf);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        uart_rx_agnt.uart_rx_agent_aport.connect(udma_predictor.analysis_export);
        udma_predictor.expected_udma_aport.connect(uart_checker.udma_before_export);
        udma_rx_agnt.udma_rx_aport.connect(uart_checker.udma_after_export);

        udma_tx_agnt.udma_tx_aport.connect(uart_predictor.analysis_export);
        uart_predictor.expected_uart_aport.connect(uart_checker.uart_before_export);
        uart_tx_agnt.uart_rx_agent_aport.connect(uart_checker.uart_after_export);
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        `uvm_info("[ENV]","run_phase",UVM_LOW)
    endtask: run_phase
endclass : uart_env