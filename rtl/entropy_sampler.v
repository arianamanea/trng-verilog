 `timescale 1ns / 1ps

module entropy_sampler (
    input  wire clk,
    input  wire rst,
    input  wire enable,
    input  wire entropy_in,
    output reg  sampled_bit
);

    reg q1; // Registru intern pentru sincronizare

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q1 <= 1'b0;
            sampled_bit <= 1'b0;
        end else if (enable) begin
            q1 <= entropy_in;
            sampled_bit <= q1;
        end
    end

endmodule