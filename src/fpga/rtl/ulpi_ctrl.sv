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
    inout wire [7:0] io_data
);

    ulpi_fsm_state state = ULPI_FSM_STATE_RESET;
    logic stp_drive = 1'b0;
    logic rst_drive = 1'b1;
    logic [7:0] data_recv = 8'h0;

    always @(posedge i_clk) begin
        if (i_rst == 1'b1) begin
            state = ULPI_FSM_STATE_RESET;
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
                    state = ULPI_FSM_STATE_RESET_FINISH;
                end
            end
            ULPI_FSM_STATE_RESET_FINISH: begin
            end
        endcase
    end

    assign o_stp = stp_drive;
    assign o_rst = rst_drive;
    assign io_data = (i_dir == 0) ? data_recv : 8'hzz;

endmodule
