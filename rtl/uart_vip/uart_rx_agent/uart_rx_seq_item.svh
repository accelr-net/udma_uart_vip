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
// FILE         :   uart_rx_seq_item.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence item for uart RX. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  11-Seq-2023      Kasun        creation
//
//**************************************************************************************************
class uart_rx_seq_item #(parameter CHARACTOR_LENGTH = 8) extends uvm_sequence_item;
    `uvm_object_utils(uart_rx_seq_item)

    rand logic [CHARACTOR_LENGTH-1:0]    charactor;
    rand logic                           parity;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_rx_seq_item");
        super.new(name);
        `uvm_info("[SEQ_ITEM]","constructor",UVM_LOW)
    endfunction: new

endclass : uart_rx_seq_item