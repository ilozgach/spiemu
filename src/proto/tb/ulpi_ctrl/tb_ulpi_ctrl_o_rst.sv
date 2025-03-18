module tb_ulpi_ctrl_reset ();

    logic i_rst = 1;
    logic i_clk;
    logic i_dir = 0;
    logic i_nxt = 0;
    logic o_stp;
    logic o_rst;
    wire [7:0] io_data;

    ulpi_ctrl ulpi_controller(.i_rst(i_rst), .i_clk(i_clk), .i_dir(i_dir), .i_nxt(i_nxt), .o_stp(o_stp), .o_rst(o_rst),
                              .io_data(io_data));

    initial begin
        i_clk = 0;
        #1 i_rst = 1;
        #1 i_clk = 1;
        #1 if (ulpi_controller.state != ULPI_FSM_STATE_RESET) begin
            $error("Wrong state at the beginning: actual = %s, expected = ULPI_FSM_STATE_RESET",
                   ulpi_controller.state.name());
            $fatal();
        end
        if (o_rst != 1) begin
            $error("Wrong o_rst signal at the beginning: actual = %d, expected = 1", o_rst);
            $fatal();
        end

        #1 i_clk = 0;
        i_rst = 0;
        #1 i_clk = 1;
        #1 if (ulpi_controller.state != ULPI_FSM_STATE_RESET_SET_STP_HIGH) begin
            $error("Wrong state after reset deassertion: actual = %s, expected = ULPI_FSM_STATE_BEGIN",
                   ulpi_controller.state.name());
            $fatal();
        end
        if (o_rst != 1) begin
            $error("Wrong o_rst signal after reset deassertion: actual = %d, expected = 1", o_rst);
            $fatal();
        end

        #1 i_clk = 0;
        #1 i_clk = 1;
        #1 if (o_stp != 1) begin
            $error("Wrong o_stp signal after reset deassertion: actual = %d, expected = 1", o_stp);
            $fatal();
        end
        if (o_rst != 1) begin
            $error("Wrong o_rst signal after o_stp is high: actual = %d, expected = 1", o_rst);
            $fatal();
        end

        #1 i_clk = 0;
        i_dir = 1;
        #1 i_clk = 1;
        #1 if (o_rst != 0) begin
            $error("Wrong o_rst signal after i_dir is high: actual = %d, expected = 1", o_stp);
            $fatal();
        end
    end

endmodule
