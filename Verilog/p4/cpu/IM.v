`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:37 10/31/2023 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] PC,
    output [31:0] Instr
    );

reg [31:0] ROM [0:4095];

wire [11:0] Addr;

integer i;

initial begin
	for (i = 0; i < 4096; i = i + 1)
		ROM[i] = 0;
    $readmemh("code.txt", ROM);
end

assign Addr = PC[13:2] - 12'hc00;
assign Instr = ROM[Addr];

endmodule
