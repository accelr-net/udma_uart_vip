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
// FILE         :   cfg_sequence.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence object for cfg. 
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
class cfg_sequence extends uvm_sequence; 
    `uvm_object_utils(cfg_sequence)
    bit                 parity_en;
    bit                 rx_ena;
    bit                 tx_ena;
    int                 clock_freq;
    int                 baud_rate;
    int                 char_length;
    int                 stop_bits;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_sequence");
        super.new(name);
        if(!uvm_config_db #(int)::get(null,"*","baud_rate",baud_rate)) begin
            `uvm_fatal("Cannot find baud_rate","give sutable baud_rate");
        end
        if(!uvm_config_db #(int)::get(null, "*","clock_freq",clock_freq)) begin
            `uvm_fatal("Cannot find clock_freq","set clock_freq to config_db");
        end
        if(!uvm_config_db #(int)::get(null, "*","char_length",char_length)) begin
            `uvm_fatal("Cannot find char_length","set char_length to config_db");
        end
        if(!uvm_config_db #(bit)::get(null, "*","parity_en",parity_en)) begin
            `uvm_fatal("Cannot find parity_en","set parity_en to config_db");
        end
        if(!uvm_config_db #(bit)::get(null, "*","rx_ena",rx_ena)) begin
            `uvm_fatal("Cannot find rx_ena","set rx_ena values to config_db");
        end
        if(!uvm_config_db #(bit)::get(null, "*","tx_ena",tx_ena)) begin
            `uvm_fatal("Cannot find tx_ena","set tx_ena values to config_db");
        end
        if(!uvm_config_db #(int)::get(null, "*","stop_bits",stop_bits)) begin
            `uvm_fatal("Cannot find stop_bits","set stop_bits values to config_db");
        end
        if(baud_rate == 0) begin
            `uvm_fatal("Zero divition erro","please give value to baud_rate")
        end
        `uvm_info("[SEQUENCE]","constructor", UVM_LOW)
    endfunction : new

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        cfg_seq_item        cfg_item;
        //setup bitields
        logic [15:0]        r_clkdiv;         //clock divider configuration baud_rate = soc_frequence/clkdiv
        logic [5:0]         r_reserved_1;     
        logic               r_rx_en;          //RX configuration 1'b0 - disable | 1'b1 - enable
        logic               r_tx_en;          //TX configuration 1'b0 - disable | 1'b1 - enable
        logic [1:0]         r_reserved_2;
        logic               r_clean_fifo;     //for clean fifo set 1 then set 0 to realize a reset fifo, 1'b0 - Stop clean the RX_FIFO | 1'b1 - Clean the RX_FIFO
        logic               r_polling_en;     //1'b0 - Do not using polling methods to read data | 1'b1 - Using polling method to read data
        logic               r_stop_bits;      //Stop bits length, 1'b0 - 1 stop bit | 1'b1 - 2 stp bits
        logic [1:0]         r_bit_length;     //Character length, 2'b00 - 5 bits | 2'b01 - 6 bits | 2'b10 - 7 bits | 2'b11 - 8 bits 
        logic               r_parity_en;      //Parity enable, 1'b0

        logic [31:0]        setup_value;
        uart_reg_offsets    reg_offsets;

        //set setup values
        r_clkdiv      = clock_freq/baud_rate; 
        r_reserved_1  = 'h0;
        r_rx_en       = rx_ena;
        r_tx_en       = tx_ena;
        r_reserved_2  = 2'b00;
        r_clean_fifo  = 1'b0;
        r_polling_en  = 1'b0;
        case(stop_bits)
            1       : r_stop_bits   = 1'b0;
            2       : r_stop_bits   = 1'b1;
            default : `uvm_fatal("Incorrect number of Stop bits","stop bits should be 1 or 2")
        endcase
        case (char_length)
            8       : r_bit_length  = 2'b11;
            7       : r_bit_length  = 2'b10;
            6       : r_bit_length  = 2'b01;
            5       : r_bit_length  = 2'b00;
            default : `uvm_fatal("Incorrect character length","character length should be between 5-8")
        endcase
        r_parity_en   = parity_en;

        reg_offsets = new();

        //contatinate setup values 
        setup_value = {
            r_clkdiv,
            r_reserved_1,
            r_rx_en,
            r_tx_en,
            r_reserved_2,
            r_clean_fifo,
            r_polling_en,
            r_stop_bits,
            r_bit_length,
            r_parity_en
        };
        `uvm_info("[SEQUENCE]","body",UVM_LOW); 
        cfg_item = cfg_seq_item::type_id::create("cfg_item");

        //This is for uart setup register value
        start_item(cfg_item);
        cfg_item.addr           <= reg_offsets.setup_addr;
        cfg_item.data           <= setup_value;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);
        
    endtask: body
endclass: cfg_sequence