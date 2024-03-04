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
// FILE         :   cmd_seq_item.svh
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

class cmd_driver extends uvm_driver #(cmd_seq_item);
    `uvm_component_utils(cmd_driver)

    virtual cmd_if    v_cmd_if;

    function new(string name="cmd_driver",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual cmd_if)::get(this,"*","cmd_vif",v_cmd_if)) begin
            `uvm_fatal("cmd_driver","No virtual cmd_if found!");
        end
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        cmd_seq_item        cmd_transaction;
        super.run_phase(phase);
        `uvm_info("[cmd_driver]","run_phase",UVM_LOW)
        forever begin
            @(v_cmd_if.sys_clk_i);
            cmd_transaction = cmd_seq_item::type_id::create("cmd_transaction");
            seq_item_port.try_next_item(cmd_transaction);
            if(cmd_transaction) begin
                do_spi(cmd_transaction);
            end
            seq_item_port.item_done();
        end
    endtask: run_phase

    task do_spi(
        cmd_seq_item    cmd_transaction
    );
        @(this.v_cmd_if);
        this.v_cmd_if.cmd_i         <= cmd_transaction.data;
        this.v_cmd_if.cmd_valid_i   <= 1'b1;
        this.v_cmd_if.data_tx_gnt_i <= 1'b1;
    endtask: do_spi
endclass: cmd_driver