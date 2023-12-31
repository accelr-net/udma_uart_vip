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
// FILE         :   udma_tx_agent.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for udma_rx agent
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  4-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class udma_tx_agent extends uvm_agent;
    `uvm_component_utils(udma_tx_agent)

    //driver, monitor & sequencer
    udma_tx_driver                          driver;
    udma_tx_monitor                         monitor;
    uvm_sequencer #(udma_tx_seq_item)       sequencer;

    uvm_analysis_port #(udma_tx_seq_item)   udma_tx_aport;

//-------------------------------------------------------------------------------------------------
// Constructor
//-------------------------------------------------------------------------------------------------
    function new(string name="udma_tx_agent",uvm_component parent);
        super.new(name,parent);
        `uvm_info("[udma_tx_agent]","constructor",UVM_HIGH);
    endfunction: new

//-------------------------------------------------------------------------------------------------
// Build phase
//-------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("[udma_tx_agent]","build_phase",UVM_HIGH);

        driver          = udma_tx_driver::type_id::create("udma_tx_driver",this);
        monitor         = udma_tx_monitor::type_id::create("udma_tx_monitor",this);
        sequencer       = uvm_sequencer #(udma_tx_seq_item)::type_id::create("udma_tx_sequencer",this);

        udma_tx_aport   = new("udma_tx_aport",this);
    endfunction : build_phase

//-------------------------------------------------------------------------------------------------
// Connect phase
//-------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        `uvm_info("[udma_tx_agent]","connect_phase",UVM_HIGH)
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        udma_tx_aport = monitor.udma_tx_aport;
    endfunction: connect_phase

//-------------------------------------------------------------------------------------------------
// Run phase
//-------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask: run_phase
endclass: udma_tx_agent