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

class cmd_agent extends uvm_agent;
    `uvm_component_utils(cmd_agent)

    cmd_driver                                  driver;
    cmd_monitor                                 monitor;
    uvm_sequencer #(cmd_seq_item)               sequencer;
    cmd_agent_config                            cmd_config;
    uvm_analysis_port #(cmd_seq_item)           cmd_aport

    virtual udma_if                             v_cmd_if;
    
    function new(string name="cmd_agent",uvm_component parent);
        super.new(name, parent);
        `uvm_info("[cmd_agent]","constructor",UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info("[cmd_agent]","build_phase",UVM_HIGH)
        if(!uvm_config_db #(cmd_agent_config)::get(this,"","cmd_config",cmd_config)) begin
            `uvm_fatal("cmd_agent","Please set cmd_configs");
        end
        monitor     = cmd_monitor::type_id::create("monitor",this);
        sequencer   = uvm_sequencer #(cmd_seq_item)::type_id::create("sequencer",this);
        cmd_aport   = new("cmd_aport",this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        `uvm_info("cmd_agent","connect_phase",UVM_HIGH)
        cmd_aport   = monitor.a_port;
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask: run_phase
endclass : cmd_agent