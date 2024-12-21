`timescale 1ns / 1ps
`include "counting.v"

module counting_tb;
    reg  [1:0] num;
    reg        clk;
    wire       ans;
    counting counting_inst (
        .num(num),
        .clk(clk),
        .ans(ans)
    );

    always #5 clk = !clk;

    initial begin
        //$dumpfile("counting.vcd");
        //$dumpvars;
        #5 num = 2'd1;
        #5 num = 2'd3;
        #5 num = 2'd1;
        #5 num = 2'd2;
        #5 num = 2'd2;
        #5 num = 2'd3;
        #5 num = 2'd2;
    end


endmodule
