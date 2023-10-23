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
// FILE         :   udma_rx_req_item.svh
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
class udma_rx_seq_item extends uvm_sequence_item;
    `uvm_object_utils(udma_rx_seq_item)
    rand    bit                     ready;
    logic [31:0]            data;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="udma_rx_seq_item");
        super.new();
        `uvm_info("[SEQ_ITEM]","constructor",UVM_HIGH)
    endfunction: new

    function string convert2string();
        return $psprintf("data = $b",data);
    endfunction: convert2string

endclass : udma_rx_seq_item