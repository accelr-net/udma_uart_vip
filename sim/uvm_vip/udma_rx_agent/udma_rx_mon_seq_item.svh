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
// FILE         :   udma_rx_mon_seq_item.svh
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
class udma_rx_mon_seq_item extends uvm_sequence_item;
    `uvm_object_utils(udma_rx_mon_seq_item)
    local    logic [31:0]            data;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="udma_rx_mon_seq_item");
        super.new();
        `uvm_info("[udma_rx_mon_seq_item]","constructor",UVM_HIGH)
    endfunction: new

    //set data_value
    function set_data(
        input  logic [31:0]  data
    );
        this.data = data;
    endfunction

    //get data value
    function get_data(
        output  logic [31:0]       data_out 
    );
        data_out = this.data;
    endfunction: get_data

    function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction: do_print

    function string convert2string();
        string s;
        s = super.convert2string();
        $sformat(s,"%s %s data = %b %s",s,BLUE,this.data,WHITE);
        return s;
    endfunction: convert2string

endclass : udma_rx_seq_item