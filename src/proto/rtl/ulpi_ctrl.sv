`include "defs.svh"

module ulpi_ctrl
# (
    parameter byte TX_BUFFER_SIZE = 2
)
(
    // Custom signals
    input wire i_rst,

    // ULPI related signals
    input wire i_clk,
    input wire i_dir,
    input wire i_nxt,
    output wire o_stp,
    output wire o_rst,
    input wire [7:0] i_data,
    output wire [7:0] o_data
);

    ulpi_fsm_state prev_state = ULPI_FSM_STATE_RESET;
    ulpi_fsm_state state = ULPI_FSM_STATE_RESET;
    ulpi_fsm_state next_state = ULPI_FSM_STATE_RESET;
    logic stp_drive = 1'b0;
    logic rst_drive = 1'b1;
    logic [7:0] rx_data = 8'h0;
    logic [7:0] tx_data = 8'h0;
    logic [7:0] tx_data_buffer [TX_BUFFER_SIZE - 1:0];
    logic [7:0] tx_data_buffer_size = 8'h0;
    logic [7:0] tx_data_buffer_index = 8'h0;

`ifdef SYNTHESIS
    ila_0 ila(
        .clk(i_clk),
        .probe0(i_rst),
        .probe1(i_dir),
        .probe2(i_nxt),
        .probe3(o_stp),
        .probe4(i_data),
        .probe5(o_data),
        .probe6(state),
        .probe7(o_rst)
    );
`endif

    always @(posedge i_clk) begin
        if (i_rst == 1'b1) begin
            prev_state = ULPI_FSM_STATE_RESET;
            state = ULPI_FSM_STATE_RESET;
            next_state = ULPI_FSM_STATE_RESET;
            rst_drive = 1'b1;
        end

        case (state)
            // =========================================================================================================
            // ULPI reset sequence
            // =========================================================================================================

            ULPI_FSM_STATE_RESET: begin
                if (i_rst == 1'b0) begin
                    state = ULPI_FSM_STATE_RESET_SET_STP_HIGH;
                end
            end
            ULPI_FSM_STATE_RESET_SET_STP_HIGH: begin
                stp_drive = 1'b1;
                state = ULPI_FSM_STATE_RESET_WAIT_FOR_DIR_HIGH_AFTER_STP_HIGH;
            end
            ULPI_FSM_STATE_RESET_WAIT_FOR_DIR_HIGH_AFTER_STP_HIGH: begin
                if (i_dir == 1) begin
                    rst_drive = 1'b0;
                    state = ULPI_FSM_STATE_RESET_WAIT_FOR_DIR_LOW_AFTER_RST_LOW;
                end
            end
            ULPI_FSM_STATE_RESET_WAIT_FOR_DIR_LOW_AFTER_RST_LOW: begin
                if (i_dir == 0) begin
                    stp_drive = 1'b0;
                    state = ULPI_FSM_STATE_WRITE_STRAP;
                end
            end

            // =========================================================================================================
            // Write and read back strap register after reset (self-check)
            // =========================================================================================================

            ULPI_FSM_STATE_WRITE_STRAP: begin
                if (i_dir == 0) begin
                    prev_state = ULPI_FSM_STATE_WRITE_STRAP;
                    state = ULPI_FSM_STATE_TX_CMD_BEGIN;
                    next_state = ULPI_FSM_STATE_READ_STRAP;

                    // tx_data[7:6] = 2'b10;
                    // tx_data[5:0] = 6'h16;

                    // tx_data = 8'b10010110;

                    tx_data_buffer[0] = `ULPI_TX_CMD_CODE_REG_WRITE_VALUE << `ULPI_TX_CMD_CODE_REG_WRITE_OFFSET | `ULPI_STRAP_REGISTER_ADDRESS;
                    tx_data_buffer[1] = 8'b11111111;
                    tx_data_buffer_size = 8'h02;
                    tx_data_buffer_index = 8'h00;
                end else begin
                    state = ULPI_FSM_STATE_RX_CMD;
                    next_state = ULPI_FSM_STATE_WRITE_STRAP;
                end
            end

            ULPI_FSM_STATE_READ_STRAP: begin
                if (i_dir == 0) begin
                    state = ULPI_FSM_STATE_REG_READ_WAIT_FOR_DIR_HIGH;
                    next_state = ULPI_FSM_STATE_IDLE;
                    tx_data[7:6] = 2'b11;
                    tx_data[5:0] = 6'h16;
                end else begin
                    state = ULPI_FSM_STATE_DIR_HIGH_TURNAROUND;
                    next_state = ULPI_FSM_STATE_READ_STRAP;
                end
            end

            // =========================================================================================================
            // Write register
            // =========================================================================================================

            // =========================================================================================================
            // Read register
            // =========================================================================================================

            ULPI_FSM_STATE_REG_READ_WAIT_FOR_DIR_HIGH: begin
                if (i_dir == 1) begin
                    tx_data = 8'h0;
                    state = ULPI_FSM_STATE_REG_READ_DIR_HIGH_TURNAROUND;
                end
            end

            ULPI_FSM_STATE_REG_READ_DIR_HIGH_TURNAROUND: begin
                if (i_dir == 1) begin
                    rx_data = i_data;
                    state = ULPI_FSM_STATE_REG_READ_WAIT_FOR_DIR_LOW;
                end
            end

            ULPI_FSM_STATE_REG_READ_WAIT_FOR_DIR_LOW: begin
                if (i_dir == 0) begin
                    state = ULPI_FSM_STATE_REG_READ_DIR_LOW_TURNAROUND;
                end else begin
                    rx_data = i_data;
                end
            end

            ULPI_FSM_STATE_REG_READ_DIR_LOW_TURNAROUND: begin
                if (i_dir == 0) begin
                    state = next_state;
                end
            end

            // =========================================================================================================
            // RX CMD
            // =========================================================================================================

            ULPI_FSM_STATE_RX_CMD: begin
                if (i_dir == 0) begin
                    state = next_state;
                    rx_data = 8'h00;
                end else begin
                    rx_data = i_data;
                end
            end

            // =========================================================================================================
            // TX CMD
            // =========================================================================================================

            ULPI_FSM_STATE_TX_CMD_BEGIN: begin
                if (i_dir == 1) begin
                    state = ULPI_FSM_STATE_RX_CMD;
                    next_state = prev_state;
                    tx_data = 8'h00;
                    tx_data_buffer_index = 8'h0;
                end else begin
                    state = ULPI_FSM_STATE_TX_CMD_WAIT_NXT_HIGH;
                    tx_data = tx_data_buffer[tx_data_buffer_index];
                    tx_data_buffer_index = tx_data_buffer_index + 1;
                end
            end

            ULPI_FSM_STATE_TX_CMD_WAIT_NXT_HIGH: begin
                if (i_dir == 1) begin
                    state = ULPI_FSM_STATE_RX_CMD;
                    next_state = prev_state;
                    tx_data = 8'h00;
                    tx_data_buffer_index = 8'h0;
                end else if (i_nxt == 1) begin
                    tx_data = tx_data_buffer[tx_data_buffer_index];
                    tx_data_buffer_index = tx_data_buffer_index + 1;
                    if (tx_data_buffer_index == tx_data_buffer_size) state = ULPI_FSM_STATE_TX_CMD_WAIT_NXT_HIGH_LAST;
                    else state = ULPI_FSM_STATE_TX_CMD_WAIT_NXT_HIGH;
                end
            end

            ULPI_FSM_STATE_TX_CMD_WAIT_NXT_HIGH_LAST: begin
                if (i_dir == 1) begin
                    state = ULPI_FSM_STATE_RX_CMD;
                    next_state = prev_state;
                    tx_data = 8'h00;
                    tx_data_buffer_index = 8'h0;
                end else if (i_nxt == 1) begin
                    tx_data_buffer_index = 8'h0;
                    tx_data_buffer_size = 8'h0;
                    state = ULPI_FSM_STATE_TX_CMD_END;
                    tx_data = 8'h00;
                    stp_drive = 1'b1;
                end
            end

            ULPI_FSM_STATE_TX_CMD_END: begin
                state = next_state;
                stp_drive = 1'b0;
            end

            // =========================================================================================================
            // Idle state
            // =========================================================================================================

            ULPI_FSM_STATE_IDLE: begin
                if (i_dir == 1) begin
                    state = ULPI_FSM_STATE_DIR_HIGH_TURNAROUND;
                    next_state = ULPI_FSM_STATE_IDLE;
                end
            end

            ULPI_FSM_STATE_DIR_HIGH_TURNAROUND: begin
                state = ULPI_FSM_STATE_RX_CMD;
            end
        endcase
    end

    assign o_stp = stp_drive;
    assign o_rst = rst_drive;
    assign o_data = tx_data;

endmodule
