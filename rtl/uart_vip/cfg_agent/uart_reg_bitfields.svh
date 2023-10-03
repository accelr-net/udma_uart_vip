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
// FILE         :   uart_reg_bitfields.svh
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
typedef struct packed {
    logic [15:0]    clkdiv;         //clock divider configuration baud_rate = soc_frequence/clkdiv
    logic [5:0]     reserved_1;     
    logic           rx_ena;         //RX configuration 1'b0 - disable | 1'b1 - enable
    logic           tx_ena;         //TX configuration 1'b0 - disable | 1'b1 - enable
    logic [1:0]     reserved_2;
    logic           clean_fifo;     //for clean fifo set 1 then set 0 to realize a reset fifo, 1'b0 - Stop clean the RX_FIFO | 1'b1 - Clean the RX_FIFO
    logic           polling_en;     //1'b0 - Do not using polling methods to read data | 1'b1 - Using polling method to read data
    logic           stop_bits;      //Stop bits length, 1'b0 - 1 stop bit | 1'b1 - 2 stp bits
    logic [1:0]     bit_length      //Charactor length, 2'b00 - 5 bits | 2'b01 - 6 bits | 2'b10 - 7 bits | 2'b11 - 8 bits 
    logic           parity_en;      //Parity enable, 1'b0
} uart_setup_reg_t;