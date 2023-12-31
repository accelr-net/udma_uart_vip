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
// FILE         :   uart_agent.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm agent for uart RX. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  11-Sep-2023      Kasun        creation
//
//**************************************************************************************************

class uart_agent extends uvm_agent;
    `uvm_component_utils(uart_agent)

    //Agent have driver, monitor and sequencer
    uart_driver                                      driver;
    uart_monitor                                     monitor; 
    uvm_sequencer  #(uart_seq_item)                  sequencer;

    uart_agent_config                                rx_config;

    uvm_analysis_port #(uart_seq_item)               uart_rx_agent_aport;
    
    //virtual interface
    virtual uart_if                                  uart_vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_agent",uvm_component parent);
        super.new(name, parent);
        `uvm_info("[UVM agent / uart_rx]","constructor", UVM_HIGH)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        `uvm_info("[UVM agent / uart_rx]", "build_phase", UVM_HIGH)
        if(!uvm_config_db #(uart_agent_config)::get(this,"","uart_config",rx_config)) begin
            `uvm_fatal("uart_agent/build_phase","Please set uart_rx_configs connot find uart_config from uvm_config_db");
        end
        if(rx_config.is_rx_agent) begin
            driver                      = uart_driver::type_id::create("driver", this);
        end
        monitor               = uart_monitor::type_id::create("monitor",this);
        sequencer             = uvm_sequencer #(uart_seq_item)::type_id::create("sequencer",this);
        uart_rx_agent_aport   = new("uart_rx_agent_aport",this);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        `uvm_info("AGENT","connect_phase",UVM_HIGH)
        if(rx_config.is_rx_agent) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
        uart_rx_agent_aport = monitor.uart_rx_aport;
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask: run_phase
endclass : uart_agent