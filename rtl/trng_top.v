`timescale 1ns / 1ps
module trng_top (
    input  wire clk,
    input  wire rst,
    input  wire enable,
    output wire random_bit,
    output wire random_valid
);
    wire [7:0] ro_bits;
    wire combined_entropy;
    wire sampled_entropy;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : ro_gen
            // Pasăm un DELAY diferit pentru fiecare instanță (i+1)
            ring_oscillator #(.DELAY(i + 1)) ro_inst (
                .enable(enable),
                .ro_out(ro_bits[i])
            );
        end
    endgenerate

    // XOR Combiner - acum va funcționa pentru că RO-urile au viteze diferite!
    assign combined_entropy = ^ro_bits;

    entropy_sampler sampler (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .entropy_in(combined_entropy),
        .sampled_bit(sampled_entropy)
    );

    von_neumann vn (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .bit_in(sampled_entropy),
        .bit_out(random_bit),
        .valid(random_valid)
    );
endmodule