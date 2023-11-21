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
// FILE         :   uart_reg_offsets.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This file contain all offset address of uart.
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  27-Sep-2023      Kasun        creation
//
//**************************************************************************************************
class uart_reg_offsets; // offsets 
    const logic [4:0]        rx_saddr         = 5'h00;
    const logic [4:0]        rx_size_addr     = 5'h01;
    const logic [4:0]        rx_cfg_addr      = 5'h02;
    const logic [4:0]        rx_intcfg_addr   = 5'h03;

    const logic [4:0]        tx_saddr         = 5'h04;
    const logic [4:0]        tx_size_addr     = 5'h05;
    const logic [4:0]        tx_cfg_addr      = 5'h06;
    const logic [4:0]        tx_intcfg_addr   = 5'h07;
    
    const logic [4:0]        status_addr      = 5'h08;
    const logic [4:0]        setup_addr       = 5'h09;
    const logic [4:0]        error_addr       = 5'h10;
    const logic [4:0]        irq_en_addr      = 5'h11;
    const logic [4:0]        valid_addr       = 5'h12;
    const logic [4:0]        data_addr        = 5'h13;
endclass: uart_reg_offsets