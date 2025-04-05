module top (
    input wire ULPI_CLK,
    input wire ULPI_DIR,
    input wire ULPI_NXT,
    output wire ULPI_STP,
    output wire ULPI_RST,
    inout wire [7:0] ULPI_DATA
);

    logic [0:0] rst;
    wire [7:0] data_rx;
    wire [7:0] data_tx;

`ifdef SYNTHESIS
    vio_0 vio(
        .clk(ULPI_CLK),
        .probe_out0(rst)
    );
`endif

    ulpi_ctrl ulpi_controller(
        .i_rst(rst),
        .i_clk(ULPI_CLK),
        .i_dir(ULPI_DIR),
        .i_nxt(ULPI_NXT),
        .o_stp(ULPI_STP),
        .o_rst(ULPI_RST),
        .i_data(data_rx),
        .o_data(data_tx)
    );

    assign ULPI_DATA = (ULPI_DIR == 0) ? data_tx : 8'hzz;
    assign data_rx = ULPI_DATA;

endmodule
