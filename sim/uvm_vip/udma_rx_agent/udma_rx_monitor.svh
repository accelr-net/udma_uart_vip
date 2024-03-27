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
// FILE         :   uart_agent_config.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for configuration for uart_agent. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  20-Sep-2023      Kasun        creation
//
//**************************************************************************************************

class udma_rx_monitor extends uvm_monitor;
    `uvm_component_utils(udma_rx_monitor)

    virtual udma_spi_if                         vif;
    uvm_analysis_port #(udma_rx_seq_item)   udma_aport;

    function new(string name="udma_rx_monitor",uvm_component parent);
        super.new(name,parent);
        udma_aport  = new("udma_aport",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("MONITOR","build_phase",UVM_HIGH)
        if(!uvm_config_db #(virtual udma_spi_if)::get(this,"","cmd_vif",vif)) begin
            `uvm_fatal("[MONITOR]","No virtual interface specified for this monitor instance")
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        udma_rx_seq_item        udma_rx_transaction;
        super.run_phase(phase);
        `uvm_info("[MONITOR]","run_phase",UVM_HIGH)
        forever begin
            udma_rx_transaction  =  udma_rx_seq_item::type_id::create("udma_rx_transaction",this);
            @(this.vif.rx_data_cbm);
            if(this.vif.rx_data_cbm.data_rx_valid_o && this.vif.rx_data_cbm.data_rx_ready_i) begin
                udma_rx_transaction.set_data(this.vif.rx_data_cbm.data_rx_o);
                udma_aport.write(udma_rx_transaction);
                $display("udma_rx_transaction %p :",udma_rx_transaction);
            end
        end
    endtask: run_phase

endclass: udma_rx_monitor