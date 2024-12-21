`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:11:21 10/31/2023 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

wire [31:0] PC, NPC, Instr, PC_4, RD1, RD2, ALUOutput, DmRD, imm32;
wire [25:0] imm26;
wire [15:0] imm16;
wire [5:0] opcode, func;
wire [4:0] rs, rt, rd;
wire [3:0] ALUOp;
wire [2:0] CMPOp, NPCOp, DMOp;
wire [1:0] RegA3Sel, RegWDSel, EXTOp;
wire ALUBSel, jump, RegWE, DmWE;

PC _PC(
    .clk(clk),
    .rst(reset),
    .NPC(NPC),
    .PC (PC)
    );
NPC _NPC(
    .PC   (PC),
    .imm26(imm26),
    .imm16(imm16),
    .A    (RD1),
    .NPCOp(NPCOp),
    .jump (jump),
    .NPC  (NPC),
    .PC_4 (PC_4)
    );
IM _IM(
    .PC   (PC),
    .Instr(Instr)
    );
GRF1 _GRF1(
    .clk      (clk),
    .rst      (reset),
    .rs       (rs),
    .rt       (rt),
    .rd       (rd),
    .RegA3Sel (RegA3Sel),
    .ALUOutput(ALUOutput),
    .DmRD     (DmRD),
    .PC_4     (PC_4),
    .RegWDSel (RegWDSel),
    .RegWE    (RegWE),
    .PC       (PC),
    .RD1      (RD1),
    .RD2      (RD2)
    );
ALU1 _ALU1(
    .RD1      (RD1),
    .RD2      (RD2),
    .imm32    (imm32),
    .ALUBSel  (ALUBSel),
    .ALUOp    (ALUOp),
    .ALUOutput(ALUOutput)
    );
CMP _CMP(
    .rs   (RD1),
    .rt   (RD2),
    .CMPOp(CMPOp),
    .jump (jump)
    );
DM _DM(
    .clk (clk),
    .rst (reset),
    .A   (ALUOutput),
    .WD  (RD2),
    .WE  (DmWE),
    .DMOp(DMOp),
    .PC  (PC),
    .RD  (DmRD)
    );
EXT _EXT(
    .imm16(imm16),
    .EXTOp(EXTOp),
    .imm32(imm32)
    );
splitter _splitter(
    .Instr (Instr),
    .opcode(opcode),
    .func  (func),
    .rs    (rs),
    .rt    (rt),
    .rd    (rd),
    .imm16 (imm16),
    .imm26 (imm26)
    );
Controller _Controller(
    .opcode  (opcode),
    .func    (func),
    .NPCOp   (NPCOp),
    .RegWE   (RegWE),
    .ALUOp   (ALUOp),
    .CMPOp   (CMPOp),
    .DmWE    (DmWE),
    .DMOp    (DMOp),
    .EXTOp   (EXTOp),
    .RegA3Sel(RegA3Sel),
    .ALUBSel (ALUBSel),
    .RegWDSel(RegWDSel)
    );

endmodule
