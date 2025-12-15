// Entropy Sampler
// Synchronizes asynchronous entropy to system clock

module entropy_sampler (
    input  wire clk,
    input  wire enable,
    input  wire entropy_in,
    output reg  sampled_bit
);

    reg sync1, sync2;

    always @(posedge clk) begin
        if (enable) begin
            sync1       <= entropy_in;
            sync2       <= sync1;
            sampled_bit <= sync2;
        end
    end

endmodule
