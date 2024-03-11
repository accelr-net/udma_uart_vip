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
// FILE         :   cmd_seq_base.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence base class containing send_cmd task for spi command. 
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
class cmd_seq_base extends uvm_sequence;
    `uvm_object_utils(cmd_seq_base)

    logic               cpol;
    logic               cpha;
    logic   [1:0]       chip_select;
    logic               is_lsb;
    logic   [3:0]       word_size;
    logic   [15:0]      word_count;
    logic   [7:0]       clkdiv;

    static int      sequence_step = 0;
    bit [31:0]      cmd_mem [0:3] = {
        {4'h0,18'h0,1'b1,1'b1,8'd100},      // SPI_CMD_CFG
        {4'h1,26'h0,2'b01},                 // SPI_CMD_SOT
        {4'h2,1'b0,1'b0,6'h0,4'h8,16'h1},   // SPI_CMD_SEND_CMD
        {4'h7,1'b0,1'b0,6'h0,4'h8,16'h1}    // SPI_CMD_RX_DATA
    };

    function new(string name="cmd_seq_base");
        super.new(name);
        `uvm_info("cmd_seq_base","constructor",UVM_LOW)

        if(!uvm_config_db #(logic)::get(null,"*","cpol",cpol)) begin
            `uvm_fatal("[cmd_seq_base]","cannot find cpol");
        end
        if(!uvm_config_db #(logic)::get(null,"*","cpha",cpha)) begin
            `uvm_fatal("[cmd_seq_base]","cannot find cpha");
        end
        if(!uvm_config_db #(logic [1:0])::get(null,"*","chip_select",chip_select)) begin
            `uvm_fatal("[cmd_seq_base]","cannot find chip_slect");
        end
        if(!uvm_config_db #(logic)::get(null,"*","is_lsb",is_lsb)) begin
            `uvm_fatal("[cmd_seq_base]","cannot find is_lsb");
        end
        if(!uvm_config_db #(logic [3:0])::get(null,"*","word_size",word_size)) begin
            `uvm_fatal("[cmd_seq_base]","cannot find word_size");
        end
        if(!uvm_config_db #(logic [15:0])::get(null,"*","word_count",word_count)) begin
            `uvm_fatal("[cmd_seq_base]","cannot find word_count");
        end
        if(!uvm_config_db #(logic [7:0])::get(null,"*","clkdiv",clkdiv)) begin
            `uvm_fatal("[cmd_seq_base]","cannot find clkdiv");
        end

    endfunction: new

    task send_cmd(
        input   logic [31:0]     register_offset,
        input   logic [31:0]     data
    );
        // send command
    endtask: send_cmd

    task body();
        cmd_seq_item       cmd_txn;
        
        cmd_txn = cmd_seq_item::type_id::create("cmd_txn");
        repeat (4) begin
            start_item(cmd_txn);
            cmd_txn.data    = cmd_mem[sequence_step];
            $display("cmd_txn %p",cmd_txn);
            finish_item(cmd_txn);
            sequence_step += 1;
        end
    endtask: body

endclass: cmd_seq_base