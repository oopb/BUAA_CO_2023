`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:13 10/31/2023 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input rst,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    input [2:0] DMOp,
    input [31:0] PC,
    output [31:0] RD
    );

reg [31:0] Dm [0:4000];
wire [11:0] Addr;
wire [31:0] InData;
integer i;
wire [7:0] WD0, WD1, WD2, WD3, RD0, RD1, RD2, RD3;
wire [1:0] offset;

initial begin
    for (i = 0; i < 3072; i = i + 1) begin
        Dm[i] <= 0;
    end
end

assign Addr = A[13:2];
assign offset = A[1:0];

always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < 3072; i = i + 1)
            Dm[i] <= 0;
    end
    else begin
        if (WE) begin
            Dm[Addr] <= InData;
            $display("@%h: *%h <= %h", PC, { A[31:2], 2'b00 }, InData);
        end
    end
end

assign WD0 = WD[7:0];
assign WD1 = WD[15:8];
assign WD2 = WD[23:16];
assign WD3 = WD[31:24];
assign RD0 = Dm[Addr][7:0];
assign RD1 = Dm[Addr][15:8];
assign RD2 = Dm[Addr][23:16];
assign RD3 = Dm[Addr][31:24];

assign InData = (DMOp == 0) ? WD : 
                (DMOp == 1) ? 
                            (offset == 0) ? { RD3, RD2, RD1, WD0 } : 
                            (offset == 1) ? { RD3, RD2, WD0, RD0 } : 
                            (offset == 2) ? { RD3, WD0, RD1, RD0 } : 
                            (offset == 3) ? { WD0, RD2, RD1, RD0 } : 
							WD
							:
                (DMOp == 2) ? 
                            (offset[1] == 0) ? { RD3, RD2, WD1, WD0 } : 
                            (offset[1] == 1) ? { WD1, WD0, RD1, RD0 } : 
							WD
							:
                WD;

assign RD = (DMOp == 0) ? Dm[Addr] : 
            (DMOp == 1) ? 
                        (offset == 0) ? { {24{RD0[7]}}, RD0 } : 
                        (offset == 1) ? { {24{RD1[7]}}, RD1 } : 
                        (offset == 2) ? { {24{RD2[7]}}, RD2 } : 
                        (offset == 3) ? { {24{RD3[7]}}, RD3 } : 
						Dm[Addr]
						:
            (DMOp == 2) ? 
                        (offset[1] == 0) ? { {16{RD1[7]}}, RD1, RD0 } : 
                        (offset[1] == 1) ? { {16{RD3[7]}}, RD3, RD2 } : 
						Dm[Addr]
						:
            Dm[Addr];

endmodule
