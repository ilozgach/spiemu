module top (
    input wire ULPI_CLK,
    input wire ULPI_DIR,
    input wire ULPI_NXT,
    output wire ULPI_STP,
    output wire ULPI_RST,
    inout wire [7:0] ULPI_DATA
);

    logic [0:0] rst;
    logic [0:0] init;
    wire [7:0] data_rx;
    wire [7:0] data_tx;

    ulpi_ctrl ulpi_controller(
        .i_rst(rst),
        .i_init(init),
        .i_clk(ULPI_CLK),
        .i_dir(ULPI_DIR),
        .i_nxt(ULPI_NXT),
        .o_stp(ULPI_STP),
        .o_rst(ULPI_RST),
        .i_data(data_rx),
        .o_data(data_tx)
    );

`ifdef SYNTHESIS
    vio_0 vio(
        .clk(ULPI_CLK),
        .probe_in0(ulpi_controller.rx_data_buffer[0]),
        .probe_in1(ulpi_controller.rx_data_buffer[1]),
        .probe_in2(ulpi_controller.rx_data_buffer[2]),
        .probe_in3(ulpi_controller.rx_data_buffer[3]),
        .probe_in4(ulpi_controller.rx_data_buffer[4]),
        .probe_in5(ulpi_controller.rx_data_buffer[5]),
        .probe_in6(ulpi_controller.rx_data_buffer[6]),
        .probe_in7(ulpi_controller.rx_data_buffer[7]),
        .probe_in8(ulpi_controller.rx_data_buffer[8]),
        .probe_in9(ulpi_controller.rx_data_buffer[9]),
        .probe_in10(ulpi_controller.rx_data_buffer[10]),
        .probe_in11(ulpi_controller.rx_data_buffer[11]),
        .probe_in12(ulpi_controller.rx_data_buffer[12]),
        .probe_in13(ulpi_controller.rx_data_buffer[13]),
        .probe_in14(ulpi_controller.rx_data_buffer[14]),
        .probe_in15(ulpi_controller.rx_data_buffer[15]),
        .probe_in16(ulpi_controller.rx_data_buffer[16]),
        .probe_in17(ulpi_controller.rx_data_buffer[17]),
        .probe_in18(ulpi_controller.rx_data_buffer[18]),
        .probe_in19(ulpi_controller.rx_data_buffer[19]),
        .probe_in20(ulpi_controller.rx_data_buffer[20]),
        .probe_in21(ulpi_controller.rx_data_buffer[21]),
        .probe_in22(ulpi_controller.rx_data_buffer[22]),
        .probe_in23(ulpi_controller.rx_data_buffer[23]),
        .probe_in24(ulpi_controller.rx_data_buffer[24]),
        .probe_in25(ulpi_controller.rx_data_buffer[25]),
        .probe_in26(ulpi_controller.rx_data_buffer[26]),
        .probe_in27(ulpi_controller.rx_data_buffer[27]),
        .probe_in28(ulpi_controller.rx_data_buffer[28]),
        .probe_in29(ulpi_controller.rx_data_buffer[29]),
        .probe_in30(ulpi_controller.rx_data_buffer[30]),
        .probe_in31(ulpi_controller.rx_data_buffer[31]),
        .probe_in32(ulpi_controller.rx_data_buffer_size),
        .probe_out0(rst),
        .probe_out1(init)
    );
`endif

    assign ULPI_DATA = (ULPI_DIR == 0) ? data_tx : 8'hzz;
    assign data_rx = ULPI_DATA;

endmodule
