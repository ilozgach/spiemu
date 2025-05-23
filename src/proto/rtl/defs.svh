`ifndef DEFS_SVH
`define DEFS_SVH

`define ULPI_FUNCTION_CONTROL_REGISTER_ADDRESS 6'h04
`define ULPI_OTG_CONTROL_REGISTER_ADDRESS 6'h0a
`define ULPI_STRAP_REGISTER_ADDRESS 6'h16

`define ULPI__FUNCTION_CONTROL__XCVR_SELECT__OFFSET 8'h00
`define ULPI__FUNCTION_CONTROL__TERM_SELECT__OFFSET 8'h02
`define ULPI__FUNCTION_CONTROL__OP_MODE__OFFSET 8'h03
`define ULPI__FUNCTION_CONTROL__RESET__OFFSET 8'h05
`define ULPI__FUNCTION_CONTROL__SUSPENDM__OFFSET 8'h06

`define ULPI_TX_CMD_CODE_REG_WRITE_OFFSET 8'h06
`define ULPI_TX_CMD_CODE_REG_WRITE_VALUE 2

typedef enum byte {
    ULPI_FSM_STATE_RESET,                                  // 0
    ULPI_FSM_STATE_RESET_SET_STP_HIGH,                     // 1
    ULPI_FSM_STATE_RESET_WAIT_FOR_DIR_HIGH_AFTER_STP_HIGH, // 2
    ULPI_FSM_STATE_RESET_WAIT_FOR_DIR_LOW_AFTER_RST_LOW,   // 3

    ULPI_FSM_STATE_WRITE_STRAP, // 4
    ULPI_FSM_STATE_READ_STRAP,  // 5
    ULPI_FSM_STATE_CLEAR_FUNCTION_CONTROL,
    ULPI_FSM_STATE_CLEAR_OTG_CONTROL,

    ULPI_FSM_STATE_WRITE_FUNCTION_CONTROL, // 6
    ULPI_FSM_STATE_WRITE_OTG_CONTROL, // 7

    ULPI_FSM_STATE_RX_CMD, // 8

    ULPI_FSM_STATE_REG_READ_WAIT_FOR_DIR_HIGH,   // 9
    ULPI_FSM_STATE_REG_READ_DIR_HIGH_TURNAROUND, // a
    ULPI_FSM_STATE_REG_READ_WAIT_FOR_DIR_LOW,    // b
    ULPI_FSM_STATE_REG_READ_DIR_LOW_TURNAROUND,  // c

    ULPI_FSM_STATE_TX_CMD_BEGIN, // d
    ULPI_FSM_STATE_TX_CMD_WAIT_NXT_HIGH, // e
    ULPI_FSM_STATE_TX_CMD_WAIT_NXT_HIGH_LAST,   // f
    ULPI_FSM_STATE_TX_CMD_END, // 10

    ULPI_FSM_STATE_IDLE,               // 11
    ULPI_FSM_STATE_DIR_HIGH_TURNAROUND // 12
} ulpi_fsm_state;

`endif