
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { ULPI_STP }]; #IO_L22N_T3_A04_D20_14 Sch=jc_n[3]
set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { ULPI_NXT }]; #IO_L23P_T3_A03_D19_14 Sch=jc_p[4]
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { ULPI_DIR }]; #IO_L23N_T3_A02_D18_14 Sch=jc_n[4]
set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { ULPI_CLK }]; #IO_L14P_T2_SRCC_35 Sch=jd[7]
create_clock -add -name ulpi_clk_pin -period 16.66 -waveform {0 8.33} [get_ports { ULPI_CLK }];
set_property -dict { PACKAGE_PIN D2    IOSTANDARD LVCMOS33 } [get_ports { ULPI_RST }]; #IO_L14N_T2_SRCC_35 Sch=jd[8]

set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[0] }]; #IO_L13N_T2_MRCC_35 Sch=jd[4]
set_property -dict { PACKAGE_PIN F4    IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[1] }]; #IO_L13P_T2_MRCC_35 Sch=jd[3]
set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[2] }]; #IO_L12N_T1_MRCC_35 Sch=jd[2]
set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[3] }]; #IO_L11N_T1_SRCC_35 Sch=jd[1]
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[4] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jc_n[2]
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[5] }]; #IO_L21P_T3_DQS_14 Sch=jc_p[2]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[6] }]; #IO_L20N_T3_A07_D23_14 Sch=jc_n[1]
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { ULPI_DATA[7] }]; #IO_L20P_T3_A08_D24_14 Sch=jc_p[1]
