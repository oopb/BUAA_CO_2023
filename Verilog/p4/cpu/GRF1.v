`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:01:28 10/31/2023 
// Design Name: 
// Module Name:    GRF1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module GRF1(
    input clk,
    input rst,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [1:0] RegA3Sel,
    input [31:0] ALUOutput,
    input [31:0] DmRD,
    input [31:0] PC_4,
    input [1:0] RegWDSel,
    input RegWE,
    input [31:0] PC,
    output [31:0] RD1,
    output [31:0] RD2
    );

wire [4:0] A3;
wire [31:0] WD;

GRF _GRF(
    .clk(clk),
    .rst(rst),
    .A1(rs),
    .A2(rt),
    .A3(A3),
    .WD(WD),
    .WE(RegWE),
    .PC(PC),
    .RD1(RD1),
    .RD2(RD2)
    );

assign A3 = (RegA3Sel == 0) ? rd : 
            (RegA3Sel == 1) ? rt : 
            (RegA3Sel == 2) ? 5'd31 : 
            0;
assign WD = (RegWDSel == 0) ? ALUOutput : 
            (RegWDSel == 1) ? DmRD : 
            (RegWDSel == 2) ? PC_4 : 
            0;

endmodule
