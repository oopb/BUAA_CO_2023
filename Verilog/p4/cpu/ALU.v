`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:59:53 10/31/2023 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
    output [31:0] C
    );

parameter ADD = 0, SUB = 1, ORI = 2, LUI = 3;

wire [31:0] add;
wire [31:0] sub;
wire [31:0] ori;
wire [31:0] lui;

assign add = A + B;
assign sub = A - B;
assign ori = A | B;
assign lui = { {B[15:0]}, {16{1'b0}} };

assign C = (ALUOp == ADD) ? add : 
           (ALUOp == SUB) ? sub : 
           (ALUOp == ORI) ? ori : 
           (ALUOp == LUI) ? lui : 
           0;

endmodule
