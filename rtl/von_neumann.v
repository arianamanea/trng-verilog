 `timescale 1ns / 1ps

module von_neumann (
    input  wire clk,
    input  wire rst,
    input  wire enable,
    input  wire bit_in,
    output reg  bit_out,
    output reg  valid
);

    reg [1:0] buffer;
    reg state; // 0: asteptam primul bit, 1: asteptam al doilea bit

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 1'b0;
            buffer <= 2'b00;
            bit_out <= 1'b0;
            valid <= 1'b0;
        end else if (enable) begin
            valid <= 1'b0; // Resetam valid in fiecare ciclu implicit
            if (state == 1'b0) begin
                buffer[1] <= bit_in;
                state <= 1'b1;
            end else begin
                buffer[0] <= bit_in;
                state <= 1'b0;
                
                // Logica Von Neumann:
                // 01 -> Iesire 0, Valid 1
                // 10 -> Iesire 1, Valid 1
                // 00 sau 11 -> Ignoram (Valid ramane 0)
                if (buffer[1] != bit_in) begin
                    bit_out <= buffer[1];
                    valid <= 1'b1;
                end
            end
        end
    end

endmodule