`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:47:39 10/31/2023 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input rst,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input WE,
    input [31:0] PC,
    output [31:0] RD1,
    output [31:0] RD2
    );

reg [31:0] Reg [31:0];

integer i;

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        Reg[i] = 0;
    end
end

always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < 32; i = i + 1)
        Reg[i] <= 0;
    end
    else begin
        if (WE && A3 != 0) begin
            Reg[A3] <= WD;
            $display("@%h: $%d <= %h", PC, A3, WD);
        end
    end
end

assign RD1 = Reg[A1];
assign RD2 = Reg[A2];

endmodule
