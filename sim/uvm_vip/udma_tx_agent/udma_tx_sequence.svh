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
// FILE         :   udma_tx_sequence.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for udma_tx_sequence 
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
class udma_tx_sequence extends uvm_sequence;
    `uvm_object_utils(udma_tx_sequence)

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="udma_tx_sequence");
        super.new(name);
        `uvm_info("[SEQUENCE]","constructor",UVM_HIGH);
    endfunction

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        udma_tx_seq_item    udma_tx_transaction;
        forever begin
            udma_tx_transaction = udma_tx_seq_item::type_id::create("udma_tx_transaction");
            start_item(udma_tx_transaction);
            udma_tx_transaction._randomize();
            $display("%s at udma_tx_sequence txn : %p %s ",GREEN, udma_tx_transaction,WHITE);
            finish_item(udma_tx_transaction);
        end
    endtask: body
endclass