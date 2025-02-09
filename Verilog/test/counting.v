`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    21:37:07 09/13/2023
// Design Name:
// Module Name:    counting
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

`define s0 2'b00
`define s1 2'b01
`define s2 2'b10
`define s3 2'b11

module counting (
    input  [1:0] num,
    input        clk,
    output       ans
);

    reg [1:0] status;

    initial begin
        status <= `s0;
    end

    always @(posedge clk) begin
        case (status)
            `s0: begin
                if (num == `s1) begin
                    status <= `s1;
                end
                else begin
                    status <= `s0;
                end
            end
            `s1: begin
                if (num == `s1) begin
                    status <= `s1;
                end
                else if (num == `s2) begin
                    status <= `s2;
                end
                else if (num == `s3) begin
                    status <= `s0;
                end
                else begin
                    status <= `s0;
                end
            end
            `s2: begin
                if (num == `s1) begin
                    status <= `s1;
                end
                else if (num == `s2) begin
                    status <= `s2;
                end
                else if (num == `s3) begin
                    status <= `s3;
                end
                else begin
                    status <= `s0;
                end
            end
            `s3: begin
                if (num == `s1) begin
                    status <= `s1;
                end
                else if (num == `s2) begin
                    status <= `s0;
                end
                else if (num == `s3) begin
                    status <= `s3;
                end
                else begin
                    status <= `s0;
                end
            end
        endcase
    end

    assign ans = (status == `s3) ? `s1 : `s0;

endmodule
