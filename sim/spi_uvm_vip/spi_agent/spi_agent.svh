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
// FILE         :   spi_agent.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is spi uvm agent. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  15-Mar-2024     Kasun         creation
//
//**************************************************************************************************

class spi_agent extends uvm_agent;
    `uvm_component_utils(spi_agent)

    spi_driver                          driver;
    spi_monitor                         monitor;
    uvm_sequencer #(spi_seq_item)       sequencer;
    spi_agent_config                    spi_config;
    uvm_analysis_port #(spi_seq_item)   spi_aport;
    
    virtual spi_if                      spi_vif;

    function new(string name="spi_agent", uvm_component parent);
        super.new(name,parent);
        `uvm_info("spi_agent","constructor",UVM_LOW)
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info("spi_agent","build_phase",UVM_LOW)

        monitor     = spi_monitor::type_id::create("monitor",this);
        driver      = spi_driver::type_id::create("driver",this);
        sequencer   = uvm_sequencer #(spi_seq_item)::type_id::create("sequencer",this);
        spi_aport   = new("spi_a_port",this);

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        `uvm_info("spi_agent","connect_phase",UVM_LOW)
        driver.seq_item_port.connect(sequencer.seq_item_export);
        spi_aport = monitor.a_port;
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        `uvm_info("[cmd_agent_config]","constructor",UVM_LOW);
        super.run_phase(phase);
    endtask: run_phase

endclass : spi_agent