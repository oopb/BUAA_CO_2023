`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:23:38 10/31/2023 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm16,
    input [1:0] EXTOp,
    output [31:0] imm32
    );

assign imm32 = (EXTOp == 0) ? { {16{1'b0}}, {imm16} } : 
               (EXTOp == 1) ? { {16{imm16[15]}}, {imm16} } : 
               0;

endmodule
