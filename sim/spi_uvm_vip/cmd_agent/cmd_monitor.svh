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
// FILE         :   cmd_monitor.svh
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

class cmd_monitor extends uvm_monitor;
    `uvm_component_utils(cfg_monitor)

    virtual udma_spi_if                     v_cmd_if;
    uvm_analysis_port   #(cmd_seq_item)     a_port;

    function new(string name="cmd_monitor", uvm_component parent);
        super.new(name,parent);
        a_port = new("a_port",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        cmd_seq_item    cmd_transaction;
        if(!uvm_config_db #(virtual udma_spi_if)::get(this,"*","udma_spi_if",v_cmd_if)) begin
            `uvm_fatal("[cmd_monitor]","No virtual interace has found");
        end
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        cmd_seq_item    cmd_transaction;
        super.run_phase(phase);
        `uvm_info("[cmd_monitor]","run_phase",UVM_HIGH);
        forever begin
            @(this.v_cmd_if.sys_clk_i);
            cmd_transaction = cmd_seq_item::type_id::create("cmd_transaction",this);

            if(this.v_cmd_if.cmd_valid_i == 1'b1) begin
                this.cmd_transaction.data = this.v_cmd_if.cmd_i;
                a_port.write(cmd_transaction);
            end
        end
    endtask: run_phase
endclass : cmd_monitor