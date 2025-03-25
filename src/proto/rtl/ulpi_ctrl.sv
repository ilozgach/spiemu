module ulpi_ctrl
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

    ulpi_fsm_state state = ULPI_FSM_STATE_RESET;
    ulpi_fsm_state next_state = ULPI_FSM_STATE_RESET;
    logic stp_drive = 1'b0;
    logic rst_drive = 1'b1;
    logic [7:0] rx_data = 8'h0;
    logic [7:0] tx_data = 8'h0;

`ifdef VIVADO_DEBUG
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
                    state = ULPI_FSM_STATE_IDLE;
                end
            end

            // =========================================================================================================
            // RX CMD
            // =========================================================================================================

            ULPI_FSM_STATE_RX_CMD: begin
                if (i_dir == 0) begin
                    state <= next_state;
                    rx_data <= 8'h00;
                end else begin
                    rx_data <= i_data;
                end
            end

            // =========================================================================================================
            // Idle state
            // =========================================================================================================

            ULPI_FSM_STATE_IDLE: begin
                if (i_dir == 1) begin
                    state = ULPI_FSM_STATE_RX_CMD;
                    next_state = ULPI_FSM_STATE_IDLE;
                end
            end
        endcase
    end

    assign o_stp = stp_drive;
    assign o_rst = rst_drive;
    assign o_data = tx_data;

endmodule
