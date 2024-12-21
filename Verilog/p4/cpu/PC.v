`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:30 10/31/2023 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input rst,
    input [31:0] NPC,
    output [31:0] PC
    );
reg [31:0] pc;

initial begin
    pc = 32'h3000; 
end

always @(posedge clk) begin
    if (rst) begin
        pc <= 32'h3000;
    end 
    else begin
        pc <= NPC;
    end
end

assign PC = pc;

endmodule
