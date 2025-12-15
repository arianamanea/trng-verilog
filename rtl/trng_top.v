// TRNG Top Module
// Metastability-based TRNG with whitening and bias removal

module trng_top (
    input  wire clk,
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
            ring_oscillator ro_inst (
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
        .enable(enable),
        .entropy_in(combined_entropy),
        .sampled_bit(sampled_entropy)
    );

    von_neumann vn (
        .clk(clk),
        .enable(enable),
        .bit_in(sampled_entropy),
        .bit_out(random_bit),
        .valid(random_valid)
    );

endmodule
