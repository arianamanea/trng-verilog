`timescale 1ns / 1ps

module trng_top_tb;

    reg clk;
    reg enable;
    wire random_bit;
    wire random_valid;

    trng_top dut (
        .clk(clk),
        .enable(enable),
        .random_bit(random_bit),
        .random_valid(random_valid)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        enable = 0;
        #20 enable = 1;
        #1000 $finish;
    end

    initial begin
        $dumpfile("trng_wave.vcd");
        $dumpvars(1, dut);
    end

endmodule
