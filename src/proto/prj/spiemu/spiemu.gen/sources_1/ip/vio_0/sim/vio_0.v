// (c) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of AMD, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
// DO NOT MODIFY THIS FILE.
`timescale 1ns / 1ps
module vio_0 (
clk,
probe_in0,probe_in1,probe_in2,probe_in3,probe_in4,probe_in5,probe_in6,probe_in7,probe_in8,probe_in9,probe_in10,probe_in11,probe_in12,probe_in13,probe_in14,probe_in15,probe_in16,probe_in17,probe_in18,probe_in19,probe_in20,probe_in21,probe_in22,probe_in23,probe_in24,probe_in25,probe_in26,probe_in27,probe_in28,probe_in29,probe_in30,probe_in31,probe_in32,
probe_out0,
probe_out1
);

input clk;
input [7 : 0] probe_in0;
input [7 : 0] probe_in1;
input [7 : 0] probe_in2;
input [7 : 0] probe_in3;
input [7 : 0] probe_in4;
input [7 : 0] probe_in5;
input [7 : 0] probe_in6;
input [7 : 0] probe_in7;
input [7 : 0] probe_in8;
input [7 : 0] probe_in9;
input [7 : 0] probe_in10;
input [7 : 0] probe_in11;
input [7 : 0] probe_in12;
input [7 : 0] probe_in13;
input [7 : 0] probe_in14;
input [7 : 0] probe_in15;
input [7 : 0] probe_in16;
input [7 : 0] probe_in17;
input [7 : 0] probe_in18;
input [7 : 0] probe_in19;
input [7 : 0] probe_in20;
input [7 : 0] probe_in21;
input [7 : 0] probe_in22;
input [7 : 0] probe_in23;
input [7 : 0] probe_in24;
input [7 : 0] probe_in25;
input [7 : 0] probe_in26;
input [7 : 0] probe_in27;
input [7 : 0] probe_in28;
input [7 : 0] probe_in29;
input [7 : 0] probe_in30;
input [7 : 0] probe_in31;
input [7 : 0] probe_in32;

output reg [0 : 0] probe_out0 = 'h1 ;
output reg [0 : 0] probe_out1 = 'h0 ;


endmodule
