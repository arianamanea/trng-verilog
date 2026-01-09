 `timescale 1ns / 1ps

module trng_top_tb;

    reg clk;
    reg rst;
    reg enable;
    wire random_bit;
    wire random_valid;

    trng_top dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .random_bit(random_bit),
        .random_valid(random_valid)
    );

    // Ceas 10ns (100MHz)
    always #5 clk = ~clk;

    integer f;

    initial begin
        clk = 0;
        enable = 0;
        rst = 1;        // Reset pornit

        f = $fopen("bits_hardware.txt", "w");
        
        #50 rst = 0;    // Eliberam Reset-ul dupa 50ns
        #20 enable = 1; // Pornim generarea
        
        $display("--- Simulare cu Reset Activat ---");
        
        #1000000;       // Rulam simularea
        
        $fclose(f);
        $display("--- Gata! ---");
        $finish;
    end

    // Salvare date in fisier
    always @(posedge clk) begin
        if (random_valid) begin
            $fwrite(f, "%b", random_bit);
        end
    end

    initial begin
        $dumpfile("trng_wave.vcd");
        $dumpvars(0, trng_top_tb);
    end

endmodule