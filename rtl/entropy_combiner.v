// Entropy Combiner
// XOR whitening for entropy sources

module entropy_combiner (
    input  wire [7:0] entropy_inputs,
    output wire       entropy_out
);

    assign entropy_out = ^entropy_inputs;

endmodule
