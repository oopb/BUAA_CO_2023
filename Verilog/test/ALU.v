`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    21:40:05 09/12/2023
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
module ALU(input [3:0] inA,
           input [3:0] inB,
           input [1:0] inC,
           input [1:0] op,
           output [3:0] ans);

assign ans = 
(op == 2'b00) ? $signed($signed(inA) >>> inC) : //00
(op == 2'b01) ? inA >> inC :                    //01
(op == 2'b10) ? inA - inB :                     //10
(op == 2'b11) ? inA + inB :                     //11
4'b000;                                         // error

endmodule
