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
// FILE         :   udma_tx_monitor.svh
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
class udma_tx_monitor extends uvm_monitor;
    `uvm_component_utils(udma_tx_monitor)

    virtual udma_if                         vif;
    uvm_analysis_port #(udma_tx_seq_item)   udma_tx_aport;

//-------------------------------------------------------------------------------------------------
// Constructor
//-------------------------------------------------------------------------------------------------
    function new(string name="udma_tx_monitor",uvm_component parent);
        super.new(name,parent);
        udma_tx_aport   = new("udma_tx_aport",this);
    endfunction: new

//-------------------------------------------------------------------------------------------------
// Build phase
//-------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("[udma_tx_monitor]","build_phase",UVM_HIGH)
        if(!uvm_config_db #(virtual udma_if)::get(this,"","udma_vif",vif)) begin
            `uvm_fatal("[udma_tx_monitor]","No virtual interface specified for this monitor")
        end
    endfunction: build_phase

//-------------------------------------------------------------------------------------------------
// Run phase
//-------------------------------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        udma_tx_seq_item        udma_tx_transaction;
        super.run_phase(phase);
        `uvm_info("[udma_tx_monitor]","run_phase",UVM_HIGH)
        forever begin
            udma_tx_transaction  = udma_tx_seq_item::type_id::create("udma_tx_txn",this);
            @(this.vif.tx_data_cbm);
            if(this.vif.tx_data_cbm.data_tx_valid_i && this.vif.tx_data_cbm.data_tx_ready_o) begin
                udma_tx_transaction.set_data(this.vif.tx_data_cbm.data_tx_i);
                udma_tx_aport.write(udma_tx_transaction);
            end
        end
    endtask: run_phase
endclass: udma_tx_monitor