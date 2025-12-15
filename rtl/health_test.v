// Health Test: Repetition Count Test (simplified NIST SP 800-90B)

module health_test (
    input  wire clk,
    input  wire bit_in,
    output reg  alarm
);

    reg last_bit;
    reg [5:0] count;

    always @(posedge clk) begin
        if (bit_in == last_bit)
            count <= count + 1;
        else
            count <= 0;

        last_bit <= bit_in;

        if (count > 32)
            alarm <= 1'b1;
        else
            alarm <= 1'b0;
    end

endmodule
