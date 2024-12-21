`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:08:37 10/31/2023 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] rs,
    input [31:0] rt,
    input [2:0] CMPOp,
    output jump
    );

parameter BEQ = 0;

wire beq;

assign beq = (rs == rt) ? 1 : 0;

assign jump = (CMPOp == BEQ) ? beq : 
              0;

endmodule
