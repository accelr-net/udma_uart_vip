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
// FILE         :   cfg_agent_config.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all configuration for  cfg_agent
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
class cfg_agent_config extends uvm_object;
    `uvm_object_utils(cfg_agent_config)
    int     baud_rate   = 115200;
    int     frequency   = 50000000;
    int     char_length = 8;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="cfg_agent_config");
        super.new(name);
        `uvm_info("[cfg_agent_config]","constructor",UVM_HIGH)
    endfunction: new

endclass : cfg_agent_config