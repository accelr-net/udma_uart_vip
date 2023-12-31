<div align="center">
  <a href="https://accelr.lk/">
    <img src="https://avatars.githubusercontent.com/u/55974019?s=200&v=4" alt="Logo" width="80" height="80">
  </a>

<h1 align="center">UVM-based µDMA UART VIP</h1>

<p align="center">
   Accelr VIP project based on uDMA and UART protocol
    <br />
  </p>
</div>
</p>



## Introduction

The RISC-V domain is experiencing significant interest within the electronic community. In response, our focus has been on the PULP platform which is a leading implementation on RISC-V domain. Specifically, we're concentrating on enhancing the PULP uDMA core, designed for connecting low-speed peripherals. Integrating a new peripheral to this uDMA core might be a challenge. To address this, we're developing a new UVM verification IP to simulate the behavior of the uDMA core. Our initial step in this endeavor is the introduction of the uDMA UART VIP.

## Getting started
### Prerequisites
To be able to run UVM-based UDMA UART VIP, you need to have Siemens Questa simulator which supports SystemVerilog and UVM 1.2. Please make sure the EDA tool environment is properly setup before running the VIP

Getting the source
```bash
git clone git@github.com:accelr-net/udma_uart_vip.git
```
### Running individual test cases 
1. go to udma_uart_sim directory
```bash
cd udma_uart_sim 
```

2. clean the project
```bash
make clean
```
3. checkout submodules
```bash
make checkout
```
4. cd to sim directory
```bash
cd sim
```
4. build the project
```bash
make build
```

5. run specific test
```bash
make run TEST_NAME=<test_name>
```
ex: make run TEST_NAME=char_length_5_test

To find TEST_NAME list run
```bash
make show_test_list
```
### Running regression tests 
This for running all tests.
1. cd to cloned directory and checkout the submodules
```bash
make checkout
```
2. go to the sim directory

```bash
cd sim
```
3. install dependencies
```bash
pip3 install -r requirements.txt # install (only once)
```
4. run regression Test

```bash
python3 run.py
```


## Directory stucture of this repo

```
  ../udma_uart_sim/
      └── sim                             [contains all verification sources]
           ├── top                        [contains top testbench]
           └── uvm_vip                    [contains all uvm components]
                 ├── analysis_component   [contains all checkers, predictors and scoreboards]
                 ├── env                  [contains all uvm environments]
                 ├── if                   [contains all interfaces]
                 ├── test                 [contains all uvm tests]
                 ├── uart_agent           [contains uvm components and objects related to uart rx and uart tx agent]
                 ├── udma_cfg_agent       [contains uvm components and objects related to udma configuration agent]
                 ├── udma_rx_agent        [contains uvm components and objects related to udma rx]
                 └── udma_tx_agent        [contains uvm components and objects related to udma tx]
```