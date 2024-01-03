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
// FILE         :   cfg_monitor.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm monitor for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  25-Aug-2023      Kasun        creation
//
//**************************************************************************************************

class cfg_monitor extends uvm_monitor;
    `uvm_component_utils(cfg_monitor)

    virtual udma_if vif;
    
    uvm_analysis_port #(cfg_seq_item) a_port;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="cfg_monitor", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[MONITOR]","constructor", UVM_HIGH)
        a_port = new("a_port",this);
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    virtual function void build_phase(uvm_phase phase);
        `uvm_info("[MONITOR]","build_phase", UVM_HIGH)
        if(!uvm_config_db #(virtual udma_if)::get(this,"*","udma_vif",vif)) begin
            `uvm_fatal("cfg_monitor/build_phase","No virtual interface specified for this monitor instance");
        end
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        cfg_seq_item cfg_transaction;
        super.run_phase(phase);
        `uvm_info("[MONITOR]","run_phase", UVM_HIGH)
        forever begin
            @(this.vif.cfg_cbm);
            //create a transaction object
            cfg_transaction = cfg_seq_item::type_id::create("cfg_transaction",this);
            `uvm_info("[MONITOR]","after create transaction",UVM_HIGH)
            // check this is a valid signal
            if(this.vif.cfg_cbm.cfg_valid_i == 1'b1) begin
                cfg_transaction.addr    = this.vif.cfg_cbm.cfg_addr_i;
                cfg_transaction.data    = this.vif.cfg_cbm.cfg_data_i;
                a_port.write(cfg_transaction);
            end
        end
    endtask: run_phase
endclass : cfg_monitor