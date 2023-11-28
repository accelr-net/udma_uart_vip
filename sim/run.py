#************************************************************************************************
#
#Copyright(C) 2023 ACCELR
#All rights reserved.
#
#THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
#ACCELER LOGIC (PVT) LTD, SRI LANKA.
#
#This copy of the Source Code is intended for ACCELR's internal use only and is
#intended for view by persons duly authorized by the management of ACCELR. No
#part of this file may be reproduced or distributed in any form or by any
#means without the written approval of the Management of ACCELR.
#
#ACCELR, Sri Lanka            https://accelr.lk
#No 175/95, John Rodrigo Mw,  info@accelr.net
#Katubedda, Sri Lanka         +94 77 3166850
#
#************************************************************************************************
#
#PROJECT      :   UART Verification Env
#PRODUCT      :   N/A
#FILE         :   uart_env.svh
#AUTHOR       :   Kasun Buddhi
#DESCRIPTION  :   This is contain all svh file for uart RX agent
#
#************************************************************************************************
#
#REVISIONS:
#
# Date            Developer     Descriptio
# -----------     ---------     -----------
# 23-Nov-2023      Kasun        creation
#
#*************************************************************************************************
import subprocess


#Test list
test_list = [
    "uart_base_test",
    "baud_rate_9600_test",
    "baud_rate_19200_test",
    "char_length_5_test",
    "char_length_6_test",
    "char_length_7_test",
    "parity_en_enable_test",
    "rx_enable_disable_test",
    "stop_bits_2_test",
    "tx_enable_disable_test"
]

def check_error(file_name,error_code):
    file = open(file_name,"r")
    content = file.readlines()
    if(error_code in content):
        print("This is some error")
        return True
    else :
        return False
for test in test_list:
    subprocess.run(["make","TEST_NAME="+test,"all"])
    if (check_error("sim/error_detect.txt","# ** Fatal: found mismaches!!\n")):
        print("There is error")
        break