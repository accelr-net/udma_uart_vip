// ************************************************************************************************
//
// Copyright(C) 2023 ACCELR
// All rights reserved.
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
// ACCELER LOGIC (PVT) LTD, SRI LANKA.
//
// This copy of the Source Code is intended for ACCELR's internal use only and is
// intended for view by persons duly authorized by the management of ACCELR. No
// part of this file may be reproduced or distributed in any form or by any
// means without the written approval of the Management of ACCELR.
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
    cfg_agent_config    config_obj;
    int                 frequency;
    int                 baud_rate;
    int                 char_length;
    bit                 parity;
    int                 stop_bits_count;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_sequence");
        super.new(name);
        if(!uvm_config_db #(int)::get(null,"*","baud_rate",baud_rate)) begin
            `uvm_fatal("Cannot find baud_rate","give sutable baud_rate");
        end
        if(!uvm_config_db #(int)::get(null, "*","frequency",frequency)) begin
            `uvm_fatal("Cannot find frequency","set frequency to config_db");
        end
        if(!uvm_config_db #(int)::get(null, "*","char_length",char_length)) begin
            `uvm_fatal("Cannot find char_length","set frequency to config_db");
        end
        if(!uvm_config_db #(bit)::get(null, "*","parity_en",parity)) begin
            `uvm_fatal("Cannot find parity_en","set parity_en to config_db");
        end
        if(!uvm_config_db #(int)::get(null, "*","stop_bits",stop_bits_count)) begin
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
        logic [15:0]        clkdiv;         //clock divider configuration baud_rate = soc_frequence/clkdiv
        logic [5:0]         reserved_1;     
        logic               rx_ena;         //RX configuration 1'b0 - disable | 1'b1 - enable
        logic               tx_ena;         //TX configuration 1'b0 - disable | 1'b1 - enable
        logic [1:0]         reserved_2;
        logic               clean_fifo;     //for clean fifo set 1 then set 0 to realize a reset fifo, 1'b0 - Stop clean the RX_FIFO | 1'b1 - Clean the RX_FIFO
        logic               polling_en;     //1'b0 - Do not using polling methods to read data | 1'b1 - Using polling method to read data
        logic               stop_bits;      //Stop bits length, 1'b0 - 1 stop bit | 1'b1 - 2 stp bits
        logic [1:0]         bit_length;      //Character length, 2'b00 - 5 bits | 2'b01 - 6 bits | 2'b10 - 7 bits | 2'b11 - 8 bits 
        logic               parity_en;      //Parity enable, 1'b0

        logic [31:0]        setup_value;
        uart_reg_offsets    reg_offsets;

        //set setup values
        clkdiv      = frequency/baud_rate; 
        reserved_1  = 'h0;
        rx_ena      = 1'b1;
        tx_ena      = 1'b1;
        reserved_2  = 2'b00;
        clean_fifo  = 1'b0;
        polling_en  = 1'b0;
        case(stop_bits_count)
            1       : stop_bits   = 1'b0;
            2       : stop_bits   = 1'b1;
            default : `uvm_fatal("Incorrect number of Stop bits","stop bits should be 1 or 2")
        endcase
        case (char_length)
            8       : bit_length  = 2'b11;
            7       : bit_length  = 2'b10;
            6       : bit_length  = 2'b01;
            5       : bit_length  = 2'b00;
            default : `uvm_fatal("Incorrect character length","character length should be between 5-8")
        endcase
        parity_en   = parity;

        reg_offsets = new();

        //contatinate setup values 
        setup_value = {
            clkdiv,
            reserved_1,
            rx_ena,
            tx_ena,
            reserved_2,
            clean_fifo,
            polling_en,
            stop_bits,
            bit_length,
            parity_en
        };
        `uvm_info("[SEQUENCE]","body",UVM_LOW); 
        cfg_item = cfg_seq_item::type_id::create("cfg_item");

        //This is for uart setup register value
        start_item(cfg_item);
        cfg_item.addr           <= reg_offsets.setup_addr;
        cfg_item.data           <= setup_value;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);
        
        //ToDo: add other register values later with other agents 
    endtask: body
endclass: cfg_sequence