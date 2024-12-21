`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:12 10/31/2023 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input [5:0] opcode,
    input [5:0] func,
    output [2:0] NPCOp,
    output RegWE,
    output [3:0] ALUOp,
    output [2:0] CMPOp,
    output DmWE,
    output [2:0] DMOp,
    output [1:0] EXTOp,
    output [1:0] RegA3Sel,
    output ALUBSel,
    output [1:0] RegWDSel
    );

// AND logic
parameter special = 6'd0;
parameter fcADD = 6'b100000,
          fcSUB = 6'b100010,
          fcJR = 6'b001000,
          fcJALR = 6'b001001;
parameter opORI = 6'b001101,
          opLW = 6'b100011,
          opSW = 6'b101011,
          opLUI = 6'b001111,
          opBEQ = 6'b000100,
          opJAL = 6'b000011,
          opJ = 6'b000010,
          opSB = 6'b101000,
          opLB = 6'b100000,
          opSH = 6'b101001,
          opLH = 6'b100001;


wire add = (opcode == special && func == fcADD);
wire sub = (opcode == special && func == fcSUB);
wire ori = (opcode == opORI);
wire lui = (opcode == opLUI);
wire lw = (opcode == opLW);
wire sw = (opcode == opSW);
wire beq = (opcode == opBEQ);
wire jr = (opcode == special && func == fcJR);
wire jal = (opcode == opJAL);
wire j = (opcode == opJ);
wire lb = (opcode == opLB);
wire sb = (opcode == opSB);
wire lh = (opcode == opLH);
wire sh = (opcode == opSH);
wire jalr = (opcode == special && func == fcJALR);

// OR logic

assign NPCOp = (beq) ? 1 : 
               (jr || jalr) ? 2 : 
               (jal || j) ? 3 : 
               0;
assign RegWE = (add || sub || ori || lw || lui || jal || jalr || lb || lh) ? 1 : 0;
assign ALUOp = (add || lw || sw) ? 0 : 
               (sub) ? 1 : 
               (ori) ? 2 : 
               (lui) ? 3 : 
               0;
assign CMPOp = (beq) ? 0 : 0;
assign DmWE = (sw || sb || sh) ? 1 : 0;
assign DMOp = (lb || sb) ? 1 : 
              (lh || sh) ? 2 : 
              0; 
assign EXTOp = (ori || lui) ? 0 : 
               (lw || sw || lb || sb || lh || sh) ? 1 : 
               0;
assign RegA3Sel = (add || sub || beq || jr) ? 0 : 
                  (ori || lw || lui || lb || lh) ? 1 : 
                  (jal) ? 2 : 
                  0;
assign ALUBSel = (add || sub || beq) ? 0 : 
                 (ori || lw || sw || lui || lb || sb || lh || sh) ? 1 : 
                 0;
assign RegWDSel = (add || sub || ori || lui || jr) ? 0 : 
                  (lw || lb || lh) ? 1 : 
                  (jal || jalr) ? 2 : 
                  0;

endmodule
