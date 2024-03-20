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
// FILE         :   spi_driver.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is spi uvm driver. 
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

class spi_driver extends uvm_driver #(spi_seq_item);
    `uvm_component_utils(spi_driver)

    virtual spi_if          spi_vif;

    function new(string name="spi_driver",uvm_component parent);
        super.new(name,parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual spi_if)::get(this,"*","spi_vif",spi_vif)) begin
            `uvm_fatal("spi_monitor","No virtual interace has found");
        end        
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        spi_seq_item        spi_transaction;
        super.run_phase(phase);
        `uvm_info("spi_driver","run_phase",UVM_LOW);
        forever begin
            spi_transaction = spi_seq_item::type_id::create("spi_transaction");
            seq_item_port.get_next_item(spi_transaction);
            do_spi_tx(spi_transaction);
            seq_item_port.item_done();
        end
    endtask : run_phase

    task do_spi_tx(spi_seq_item txn);
        for(int data_index = 8; data_index >= 0; data_index--) begin
            @(this.spi_vif.spi_clk_o);
            this.spi_vif.spi_csn1_o = 1'b0;
        end
    endtask: do_spi_tx

endclass: spi_driver