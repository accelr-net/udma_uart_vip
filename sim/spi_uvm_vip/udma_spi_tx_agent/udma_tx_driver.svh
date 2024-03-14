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
// FILE         :   udma_tx_driver.svh
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
class udma_tx_driver extends uvm_driver #(udma_tx_seq_item);
    `uvm_component_utils(udma_tx_driver)

    virtual udma_if         vif;

//--------------------------------------------------------------------------------------------------
// Constructor 
//--------------------------------------------------------------------------------------------------
    function new(string name="udma_tx_driver",uvm_component parent);
        super.new(name,parent);
    endfunction: new

//--------------------------------------------------------------------------------------------------
// Build Phase 
//--------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual udma_if)::get(this,"","udma_vif",vif)) begin
            `uvm_fatal("[udma_tx_driver]","No virtual interface found!")
        end
    endfunction: build_phase

//--------------------------------------------------------------------------------------------------
// Run Phase 
//--------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        udma_tx_seq_item        udma_tx_transaction;
        super.run_phase(phase);
        `uvm_info("[udma_tx_driver]","run_phase",UVM_HIGH)
        forever begin
            udma_tx_transaction = udma_tx_seq_item::type_id::create("udma_tx_txn");
            seq_item_port.get_next_item(udma_tx_transaction);
            do_udma_tx(udma_tx_transaction);
            seq_item_port.item_done();
        end
    endtask

    task do_udma_tx(udma_tx_seq_item txn);
        @(vif.tx_data_cbd);
        this.vif.tx_data_cbd.data_tx_i          <= txn.data;
        this.vif.tx_data_cbd.data_tx_valid_i    <= 1'b1;
        this.vif.tx_data_cbd.data_tx_gnt_i      <= 1'b1;
        @(vif.tx_data_cbd);
        this.vif.tx_data_cbd.data_tx_valid_i    <= 1'b0;
        this.vif.tx_data_cbd.data_tx_gnt_i      <= 1'b0;
        #(txn.backoff_time);
    endtask: do_udma_tx
endclass 