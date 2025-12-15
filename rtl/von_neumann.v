// Von Neumann Corrector
// Removes bias from raw entropy stream

module von_neumann (
    input  wire clk,
    input  wire enable,
    input  wire bit_in,
    output reg  bit_out,
    output reg  valid
);

    reg prev_bit;

    always @(posedge clk) begin
        if (enable) begin
            valid <= 1'b0;

            if (prev_bit != bit_in) begin
                bit_out <= prev_bit;
                valid   <= 1'b1;
            end

            prev_bit <= bit_in;
        end
    end

endmodule
