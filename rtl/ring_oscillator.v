// Ring Oscillator Entropy Source
// Simple free-running oscillator for TRNG entropy

module ring_oscillator (
    input  wire enable,
    output wire ro_out
);

    wire n1, n2, n3;

    assign n1 = enable ? ~n3 : 1'b0;
    assign n2 = ~n1;
    assign n3 = ~n2;

    assign ro_out = n3;

endmodule
