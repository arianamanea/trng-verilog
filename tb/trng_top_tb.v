`timescale 1ns / 1ps
module trng_top_tb;
    reg clk, rst, enable;
    wire random_bit, random_valid;

    trng_top dut (.clk(clk), .rst(rst), .enable(enable), .random_bit(random_bit), .random_valid(random_valid));

    always #5 clk = ~clk;

    initial begin
        clk = 0; enable = 0; rst = 1;
        #50 rst = 0;
        #20 enable = 1;
        #100000; 
        $finish;
    end

    initial begin
        $dumpfile("trng_wave.vcd");
        $dumpvars(0, trng_top_tb);
    end
endmodule