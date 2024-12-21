`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:03 10/31/2023 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC,
    input [25:0] imm26,
    input [15:0] imm16,
    input [31:0] A,
    input [2:0] NPCOp,
    input jump,
    output [31:0] NPC,
    output [31:0] PC_4
    );

parameter NORMAL = 0, BEQ = 1, JR = 2, JAL = 3;

wire [31:0] normal, beq, jr, jal;

assign normal = PC + 32'd4;
assign beq = (jump) ? { {14{imm16[15]}}, {imm16[15:0]}, {2{1'b0}} } + normal : normal;
assign jr = A;
assign jal = { {PC[31:28]}, {imm26[25:0]}, {2{1'b0}} };

assign PC_4 = normal;
assign NPC = (NPCOp == NORMAL) ? normal : 
             (NPCOp == BEQ) ? beq : 
             (NPCOp == JR) ? jr : 
             (NPCOp == JAL) ? jal : 
             32'h3000;

endmodule
