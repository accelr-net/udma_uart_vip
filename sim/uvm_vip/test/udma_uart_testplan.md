# UDMA UART Testplan `<!-- omit in toc -->`

- [IDENTIFICATION INFORMATION SECTION](#identification-information-section)

  - [TEST PARAMETERS](#test-parameters)
  - [TEST DESCRIPTION](#test-description)
- [UNIT TEST SECTION](#unit-test-section)

  - [UNIT TEST STRATEGY / EXTENT OF UNIT TESTING:](#unit-test-strategy--extent-of-unit-testing)
  - [UNIT TEST CASES](#test-cases)
- [REGRESSION TEST SECTION](#regression-test-section)

  - [REGRESSION TEST STRATEGY](#regression-test-strategy)
  - [REGRESSION TEST CASES](#regression-test-cases)

## IDENTIFICATION INFORMATION SECTION

### TEST PARAMETERS

| # | Parameters       | values                     |
| - | ---------------- | -------------------------- |
| 1 | baud rate        | 9600, 19200, 38400, 115200 |
| 2 | parity enable    | Enable, Disable            |
| 3 | stop bits        | 1, 2                       |
| 4 | character length | 5, 6, 7, 8                 |
| 5 | TX enable        | Enable, Disable            |
| 6 | RX enable        | Enable, Disable            |

### TEST DESCRIPTION

We have to make individual test with hardcoded. Every test will be change with default position (only change single parameter others are constants). I take default position as {baud_rate : 115200, parity_en : Disable, stop_bits: 1, character_length : 8, TX enable : Enable, RX enable : Enable \}
 test classes has naming convention
format is \<parameter\>\_test\_\<value\>.svh (ex: baud_rate_test_9600.svh).

## UNIT TEST SECTION

### UNIT TEST STRATEGY / EXTENT OF UNIT TESTING:

Evaluate new features and bug fixes introduced in this release

### TEST CASES

| \# | OBJECTIVE              | INPUT TRNSACTION | EXPECTED RESULTS |
| -- | ---------------------- | ---------------- | ---------------- |
| 0  | uart_base_test         | 10000            | 10000            |
| 1  | baud_rate_9600_test    | 1000             | 1000             |
| 2  | baud_rate_19200_test   | 1000             | 1000             |
| 3  | parity_en_enable_test  | 1000             | 1000             |
| 4  | stop_bits_2_test       | 1000             | 1000             |
| 5  | char_length_5_test     | 1000             | 1000             |
| 6  | char_length_7_test     | 1000             | 1000             |
| 7  | TX_enable_disable_test | 1000             | 1000             |
| 8  | RX_enable_disable_test | 1000             | 1000             |

## REGRESSION TEST SECTION

Ensure that previously developed and tested software still performs after change.

### REGRESSION TEST STRATEGY

Evaluate all reports introduced in previous releases

### REGRESSION TEST CASES

| # | OBJECTIVE | INPUT | EXPECTED RESULTS | OBSERVED |
| - | --------- | ----- | ---------------- | -------- |
| 1 |           |       |                  |          |
