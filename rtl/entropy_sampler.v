`timescale 1ns / 1ps
module entropy_sampler (
    input  wire clk,
    input  wire rst,
    input  wire enable,
    input  wire entropy_in,
    output reg  sampled_bit
);
    always @(posedge clk) begin
        if (rst) sampled_bit <= 1'b0;
        else if (enable) sampled_bit <= entropy_in;
    end
endmodule