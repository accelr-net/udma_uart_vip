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
// FILE         :   test_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all uvm_test files
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  11-oct-2023      Kasun        creation
//
//**************************************************************************************************
package test_pkg;
    import       uvm_pkg::*;
    `include     "uvm_macros.svh"

    import       uart_agent_pkg::*;
    import       udma_cfg_agent_pkg::*;
    import       udma_rx_agent_pkg::*;
    import       udma_tx_agent_pkg::*;
    import       env_pkg::*;

    `include     "uart_test.svh"
    `include     "baud_rate_test_9600.svh"
    `include     "baud_rate_test_19200.svh"
    `include     "baud_rate_test_38400.svh"
    `include     "char_length_test_5.svh"
    `include     "char_length_test_6.svh"
    `include     "char_length_test_7.svh"
    `include     "parity_en_test_enable.svh"
    `include     "RX_enable_test_disable.svh"
    `include     "TX_enable_test_disable.svh"
    `include     "stop_bits_test_2.svh"
endpackage: test_pkg