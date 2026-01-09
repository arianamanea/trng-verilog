`timescale 1ns / 1ps
module ring_oscillator #(
    parameter DELAY = 1  // Valoare implicită
)(
    input  wire enable,
    output wire ro_out
);
    wire n1, n2, n3;

    // Folosim parametrul DELAY pentru a varia viteza
    assign #DELAY n1 = ~(n3 & enable); 
    assign #(DELAY) n2 = ~n1;
    assign #(DELAY) n3 = ~n2;

    assign ro_out = n3;
endmodule