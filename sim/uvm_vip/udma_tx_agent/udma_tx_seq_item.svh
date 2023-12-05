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
// FILE         :   udma_tx_seq_item.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for udma_tx uvm_tx_seq_item 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  4-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class udma_tx_seq_item extends uvm_sequence_item;
    `uvm_object_utils(udma_tx_seq_item)
    rand logic [7:0]            uart_char;
    logic     [31:0]            data;
    rand int                    backoff_time;

    constraint time_range{
        backoff_time < 20000;
        backoff_time > 100;
    }
//--------------------------------------------------------------------------------------------------
// Construct
//--------------------------------------------------------------------------------------------------
    function new(string name="udma_tx_seq_item");
        super.new();
        `uvm_info("[udma_tx_seq_item]","constructor",UVM_HIGH)
    endfunction: new

    //set data_value
    function void set_data(
        input logic [31:0]   data
    );
        this.data           = data;
    endfunction: set_data

    //set backoff time
    function void set_backoff_time(
        input int       backoff_time
    );
        this.backoff_time = backoff_time;
    endfunction: set_backoff_time

    //get uart_char
    function void get_uart_char(
        output logic [7:0]     uart_char
    );
        uart_char = data[7:0];
    endfunction
    
    //randomize data 
    function void _randomize();
        int         max_time    =  20000;
        int         min_time    =  100;
        this.uart_char      = $urandom();
        this.backoff_time   = $urandom_range(max_time, min_time);
        this.data           = {24'h0,this.uart_char[7:0]};
    endfunction: _randomize

    function void post_randomize();
        this.data = {24'h0,this.uart_char};
    endfunction: post_randomize

    function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction: do_print

    function string convert2string();
        string s;
        s = super.convert2string();
        $sformat(s,"%s %s data = %0d %s",s, BLUE, this.data, WHITE);
        return s;
    endfunction: convert2string
endclass : udma_tx_seq_item