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
// FILE         :   cmd_seq_item.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence item for spi command. 
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

    function new(string name="spi_env",uvm_component parent);
        super.new(name, parent);
        `uvm_info("[ENV]","constructor",UVM_LOW)
    endfunction: new

    function void build_phase(uvm_phase phase);
        cmd_agent_config        cmd_config;

        super.build_phase(phase);
        `uvm_info("[ENV]","constructor",UVM_LOW)

        cmd_agnt    = cmd_agent::type_id::create("cmd_agnt",this); 
        cmd_config  = cmd_agent_config::type_id::create("cmd_config",this);

        if(!uvm_config_db #(env_configs)::get(this,"","env_configs",configs)) begin
            `uvm_fatal("[spi_env]","connot find configs")
        end
        cmd_config.cpol                 = configs.cpol;
        cmd_config.cpha                 = configs.cpha;
        cmd_config.chip_select          = configs.chip_select;
        cmd_config.is_lsb               = configs.is_lsb;
        cmd_config.word_size            = configs.word_size;
        cmd_config.word_count           = configs.word_count;
        cmd_config.clkdiv               = configs.clkdiv;
        cmd_config.is_atomic_test       = configs.is_atomic_test;
        cmd_config.communication_mode   = configs.communication_mode;

        uvm_config_db #(cmd_agent_config)::set(this,"cmd_agnt","cmd_config",cmd_config);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("[ENV]","constructor",UVM_LOW)
    endtask: run_phase
endclass : spi_env