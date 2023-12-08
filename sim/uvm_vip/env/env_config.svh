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
// FILE         :   env_confi.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all svh file for uart RX agent
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  18-Sep-2023      Kasun        creation
//
//**************************************************************************************************
class env_config extends uvm_object;
    `uvm_object_utils(env_config)
    int                                 baud_rate           = 115200;
    int                                 clock_freq          = 50000000;
    int                                 char_length         = 8;
    bit                                 parity_en           = 1'b1;
    int                                 stop_bits           = 1;
    int                                 clock_period              = 10;
    bit                                 rx_ena              = 1'b1;
    bit                                 tx_ena              = 1'b1;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="env_config");
        super.new(name);
        `uvm_info("[env_config]","working",UVM_LOW);
    endfunction: new
endclass : env_config
