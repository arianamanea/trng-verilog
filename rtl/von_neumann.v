`timescale 1ns / 1ps
module von_neumann (
    input  wire clk,
    input  wire rst,
    input  wire enable,
    input  wire bit_in,
    output reg  bit_out,
    output reg  valid
);
    reg state;
    reg buffer;

    always @(posedge clk) begin
        if (rst) begin
            bit_out <= 1'b0;
            valid   <= 1'b0;
            state   <= 1'b0;
            buffer  <= 1'b0;
        end else if (enable) begin
            if (state == 0) begin
                buffer <= bit_in;
                state  <= 1'b1;
                valid  <= 1'b0;
            end else begin
                state <= 1'b0;
                if (buffer != bit_in) begin
                    bit_out <= buffer;
                    valid   <= 1'b1;
                end else begin
                    valid   <= 1'b0;
                end
            end
        end
    end
endmodule