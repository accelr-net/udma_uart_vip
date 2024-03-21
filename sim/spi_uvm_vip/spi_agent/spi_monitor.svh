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
// FILE         :   spi_monitor.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is spi uvm monitor configs. 
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

class spi_monitor extends uvm_monitor;
    `uvm_component_utils(spi_monitor)

    virtual spi_if                      spi_vif;
    spi_agent_config                    configs;
    uvm_analysis_port #(spi_seq_item)   a_port;

    function new(string name="spi_monitor",uvm_component parent);
        super.new(name, parent);
        `uvm_info("spi_monitor","constructor",UVM_LOW);
        a_port  = new("spi_a_port",this);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual spi_if)::get(this,"*","spi_vif",spi_vif)) begin
            `uvm_fatal("spi_monitor","No virtual interface has found");
        end

        if(!uvm_config_db #(spi_agent_config)::get(this,"*","spi_config",configs)) begin
            `uvm_fatal("spi_monitor","No spi_agent_config has found");
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        spi_seq_item        spi_transaction;
        super.run_phase(phase);
        `uvm_info("spi_monitor","run_phase",UVM_LOW)
        wait (spi_vif.spi_csn1_o == 1'b0);
        forever begin
            spi_transaction = spi_seq_item::type_id::create("spi_transaction",this);
            repeat (configs.word_size+1) begin
                if((configs.cpol && configs.cpha) || (!configs.cpol && !configs.cpha)) begin
                    @(posedge spi_vif.spi_clk_o);
                end else begin
                    @(negedge spi_vif.spi_clk_o);
                end
                spi_transaction.data    = spi_transaction.data << 1;
                spi_transaction.data    |= {31'h0,this.spi_vif.spi_sdo0_o};
                $display("spi_sdo0 %p",spi_vif.spi_sdo0_o);
            end
            $display("spi_transaction %p",spi_transaction);
            a_port.write(spi_transaction);
        end
    endtask: run_phase 

endclass : spi_monitor