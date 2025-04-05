`include "defs.svh"
`include "ulpi_ctrl.sv"

module tb_ulpi_ctrl_reset ();

    logic i_rst;
    logic i_clk;
    logic i_dir;
    logic i_nxt;
    logic o_stp;
    logic o_rst;
    wire [7:0] data_rx;
    wire [7:0] data_tx;

    ulpi_ctrl ulpi_controller(.i_rst(i_rst),
                              .i_clk(i_clk),
                              .i_dir(i_dir),
                              .i_nxt(i_nxt),
                              .o_stp(o_stp),
                              .i_data(data_rx),
                              .o_data(data_tx));

    initial begin
        i_clk = 0;
        #1 i_rst = 1;
        #1 i_clk = 1;
        #1 if (ulpi_controller.state != ULPI_FSM_STATE_RESET) begin
            $fatal(1, "Wrong state at the beginning: actual = %s, expected = ULPI_FSM_STATE_RESET",
                   ulpi_controller.state.name());
        end
        if (o_rst != 1) begin
            $fatal(1, "Wrong o_rst signal at the beginning: actual = %d, expected = 1", o_rst);
        end

        #1 i_rst = 0;
        #1 i_clk = 0;
        #1 i_clk = 1;
        #1 if (ulpi_controller.state != ULPI_FSM_STATE_RESET_SET_STP_HIGH) begin
            $fatal(1, "Wrong state after reset deassertion: actual = %s, expected = ULPI_FSM_STATE_BEGIN",
                   ulpi_controller.state.name());
        end
        if (o_rst != 1) begin
            $fatal(1, "Wrong o_rst signal after reset deassertion: actual = %d, expected = 1", o_rst);
        end

        #1 i_rst = 1;
        #1 i_clk = 0;
        #1 i_clk = 1;
        #1 if (ulpi_controller.state != ULPI_FSM_STATE_RESET) begin
            $fatal(1, "Wrong state after reset assertion: actual = %s, expected = ULPI_FSM_STATE_RESET",
                   ulpi_controller.state.name());
        end
        if (o_rst != 1) begin
            $fatal(1, "Wrong o_rst signal after reset deassertion: actual = %d, expected = 1", o_rst);
        end
    end

endmodule
