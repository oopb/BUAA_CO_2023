`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:39 10/31/2023 
// Design Name: 
// Module Name:    ALU1 
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
module ALU1(
    input [31:0] RD1,
    input [31:0] RD2,
    input [31:0] imm32,
    input ALUBSel,
    input [3:0] ALUOp,
    output [31:0] ALUOutput
    );

wire [31:0] B;

ALU _ALU(
    .A    (RD1),
    .B    (B),
    .ALUOp(ALUOp),
    .C    (ALUOutput)
    );

assign B = (ALUBSel == 0) ? RD2 : 
           (ALUBSel == 1) ? imm32 : 
           0;

endmodule
