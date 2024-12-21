`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:46:43 10/31/2023
// Design Name:   mips
// Module Name:   /home/co-eda/Verilog/cpu/mips_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_tb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

	always #1 clk = ~clk;

	initial begin
		$dumpfile("mips_tb.vcd");
		$dumpvars;
		// Initialize Inputs
		clk = 0;
		reset = 1;

		#10;
		reset = 0;
        #4096;
		//$finish;
		// Add stimulus here

	end
endmodule

