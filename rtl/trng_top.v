 `timescale 1ns / 1ps

module trng_top (
    input  wire clk,
    input  wire rst,     // Reset activ pe 1
    input  wire enable,
    output wire random_bit,
    output wire random_valid
);

    wire [7:0] ro_bits;
    wire combined_entropy;
    wire sampled_entropy;

    // Instantiere 8 Oscilatoare cu DELAY-uri diferite pentru entropie
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : ro_gen
            ring_oscillator #(
                .DELAY(i * 2 + 3) 
            ) ro_inst (
                .enable(enable),
                .ro_out(ro_bits[i])
            );
        end
    endgenerate

    entropy_combiner combiner (
        .entropy_inputs(ro_bits),
        .entropy_out(combined_entropy)
    );

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