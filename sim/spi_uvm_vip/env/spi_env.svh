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
// PROJECT      :   SPI Verification Env
// PRODUCT      :   N/A
// FILE         :   spi_env.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm environment for spi command. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  20-Feb-2024     Kasun         creation
//
//**************************************************************************************************

class spi_env extends uvm_env;
    `uvm_component_utils(spi_env)

    env_configs         configs;
    //cmd
    cmd_agent           cmd_agnt;
    udma_tx_agent       udma_tx_agnt;
    udma_rx_agent       udma_rx_agnt;
    //for spi tx
    spi_agent           spi_agnt;

    //for spi rx
    spi_agent           spi_rx_agnt;

    function new(string name="spi_env",uvm_component parent);
        super.new(name, parent);
        `uvm_info("[ENV]","constructor",UVM_LOW)
    endfunction: new

    function void build_phase(uvm_phase phase);
        cmd_agent_config        cmd_config;
        spi_agent_config        spi_config;
        spi_agent_config        spi_rx_config;

        super.build_phase(phase);
        `uvm_info("[ENV]","constructor",UVM_LOW)

        cmd_agnt        = cmd_agent::type_id::create("cmd_agnt",this); 
        cmd_config      = cmd_agent_config::type_id::create("cmd_config",this);
        spi_config      = spi_agent_config::type_id::create("spi_config",this);
        spi_rx_config   = spi_agent_config::type_id::create("spi_rx_config",this);

        udma_tx_agnt = udma_tx_agent::type_id::create("udma_tx_agnt",this);
        udma_rx_agnt = udma_rx_agent::type_id::create("udma_rx_agnt",this);
        spi_agnt     = spi_agent::type_id::create("spi_agnt",this);

        spi_rx_agnt  = spi_agent::type_id::create("spi_rx_agnt",this);

        if(!uvm_config_db #(env_configs)::get(this,"","env_configs",configs)) begin
            `uvm_fatal("[spi_env]","connot find configs")
        end
        //set configs for command agent
        cmd_config.cpol                 = configs.cpol;
        cmd_config.cpha                 = configs.cpha;
        cmd_config.chip_select          = configs.chip_select;
        cmd_config.is_lsb               = configs.is_lsb;
        cmd_config.word_size            = configs.word_size;
        cmd_config.word_count           = configs.word_count;
        cmd_config.clkdiv               = configs.clkdiv;
        cmd_config.is_atomic_test       = configs.is_atomic_test;
        cmd_config.communication_mode   = configs.communication_mode;

        //set configs for spi tx agents
        spi_config.cpol                 = configs.cpol;
        spi_config.cpha                 = configs.cpha;
        spi_config.is_lsb               = configs.is_lsb;
        spi_config.word_size            = configs.word_size;
        spi_config.is_rx_agent          = 1'b0;

        //set configs for spi rx agents
        spi_rx_config.cpol              = configs.cpol;
        spi_rx_config.cpha              = configs.cpha;
        spi_rx_config.is_lsb            = configs.is_lsb;
        spi_rx_config.word_size         = configs.word_size;
        spi_rx_config.is_rx_agent       = 1'b1;

        uvm_config_db #(cmd_agent_config)::set(this,"cmd_agnt","cmd_config",cmd_config);
        uvm_config_db #(spi_agent_config)::set(this,"spi_agnt.*","spi_config",spi_config);
        uvm_config_db #(spi_agent_config)::set(this,"spi_rx_agnt.*","spi_config",spi_rx_config);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[ENV]","constructor",UVM_LOW)
    endtask: run_phase
endclass : spi_env