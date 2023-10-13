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
// FILE         :   uvm_colors.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence object for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  12-oct-2023      Kasun        creation
//
//**************************************************************************************************
package uvm_colors;
    const string      RED              = "\033[0;31m";
    const string      GREEN            = "\033[0;32m";
    const string      YELLOW           = "\033[0;33m";
    const string      BLUE             = "\033[0;34m";
    const string      PURPLE           = "\033[0;35m";
    const string      WHITE            = "\033[0;37m";
    const string      LIGHTRED         = "\033[1;31m";
    const string      LIGHTGREEN       = "\033[1;32m";
    const string      LIGHTYELLOW      = "\033[1;33m";
    const string      LIGHTBLUE        = "\033[1;34m";
    const string      LIGHTPURPLE      = "\033[1;35m";
endpackage: uvm_colors