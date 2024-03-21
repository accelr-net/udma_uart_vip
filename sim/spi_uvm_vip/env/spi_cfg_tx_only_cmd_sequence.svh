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
// FILE         :   spi_cfg_tx_only_cmd_sequence.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence for spi tx command. 
//
// ************************************************************************************************
//
// REVISIONS
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  11-Mar-2024     Kasun         creation
//
//**************************************************************************************************

class spi_cfg_tx_only_cmd_sequence extends cmd_seq_base;
    `uvm_object_utils(spi_cfg_tx_only_cmd_sequence)

    static int      sequence_step = 0;
    bit [31:0]      tx_cmd_arr [0:3];

    function new(string name="spi_cfg_tx_only_cmd_sequence ");
        super.new(name);
        `uvm_info("spi_cfg_tx_only_cmd_sequence","constructor",UVM_LOW)
        
        tx_cmd_arr[0] = {4'h0,18'h0,super.cpol,super.cpha,super.clkdiv};                    // SPI_CMD_CFG
        tx_cmd_arr[1] = {4'h1,26'h0,super.chip_select};                                     // SPI_CMD_SOT
        tx_cmd_arr[2] = {4'h2,1'b0,super.is_lsb,6'h0,super.word_size,super.word_count};     // SPI_CMD_SEND_CMD
        tx_cmd_arr[3] = {4'h6,1'b0,super.is_lsb,6'h0,super.word_size,super.word_count};     // SPI_CMD_RX_DATA
    endfunction: new

    task body();
        cmd_seq_item       cmd_txn;
        
        cmd_txn = cmd_seq_item::type_id::create("cmd_txn");
        repeat (4) begin
            start_item(cmd_txn);
            cmd_txn.data    = tx_cmd_arr[sequence_step];
            finish_item(cmd_txn);
            sequence_step += 1;
        end
    endtask : body

endclass: spi_cfg_tx_only_cmd_sequence