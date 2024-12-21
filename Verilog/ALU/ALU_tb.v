`timescale 1ns / 1ps
`include "ALU.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:41:32 09/14/2023
// Design Name:   alu
// Module Name:   C:/Users/LENOVO/Documents/.FILES/Code/Verilog/ALU/ALU_tb.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs 
	reg [31:0] input_a;
	reg [31:0] input_b;
	reg [1:0] op;
	reg clk;
	reg en;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.input_a(input_a), 
		.input_b(input_b), 
		.op(op), 
		.clk(clk), 
		.en(en), 
		.result(result)
	);

	    initial begin
        // Initialize Inputs
        input_a = 0;
        input_b = 0;
        op = 0;
        clk = 0;
        en = 0;

        // Wait for 10 ns ans set en to 1
        #10;
        en = 1'b1;

        // Test Add amd Sequential Logic
        input_a = 32'd19260817;
        input_b = 32'd99999999;

        // Test Sub and Whether Will Change within Clock High Level
        #8;
        op = 2'd1;

        // Test when en is 0, Whether Result Will Change
        #12;
        en = 1'b0;
        input_a = 32'd100;

    end

    always #5 clk = ~clk;
endmodule


