<div align="center">
  <a href="https://accelr.lk/">
    <img src="https://avatars.githubusercontent.com/u/55974019?s=200&v=4" alt="Logo" width="80" height="80">
  </a>

<h1 align="center">UVM-based UDMA UART VIP</h1>

<p align="center">
   Accelr VIP project based on UDMA and UART protocol
    <br />
  </p>
</div>
</p>



## Introduction
The UVM-based Functional verification UDMA UART verification IP is a crucial contribution to the open-source community. specially tailored for the PULPissimo platform. This innovative project serves as a pivotal tools for verifying and validating UART and other peripheral functionalities within the context of Universal Verification Methodology. 
## Getting started
### Prerequisites
To be able to run UVM-based UDMA UART VIP, you need to have Questasim RTL simulator which supports SystemVerilog and UVM 1.2. Please make sure the EDA tool environment is properly setup before running the VIP

Getting the source
```bash
git clone git@github.com:accelr-net/udma_uart_sim.git
```
### Regression test 
This for running all tests.

1. cd to cloned directory(udma_uart_sim) and go to the /sim folder

```bash
cd sim
```
2. install dependencies
```bash
pip3 install -r requirements.txt # install (only once)
```
3. Run regression Test

```bash
python3 run.py
```
### Individual Test cases 
1. go to sim directory
```bash
cd sim
```

2. clean the project
```bash
make clean
```
3. build the project
```bash
make build
```

4. run specific test
```bash
make run TEST_NAME=<test_name>
```
ex: make run TEST_NAME=char_length_5_test

## Directory stucture of this repo
#### __sim__
sim folder contains all verification sources

#### __top__

#### __uvm_vip__
This folder contains all uvm components

#### __analysis_component__

#### __env__

#### __if__

#### __test__

#### __uart_agent__

#### __udma_cfg_agent__

#### __udma_rx_agent__

#### __udma_tx_agent__