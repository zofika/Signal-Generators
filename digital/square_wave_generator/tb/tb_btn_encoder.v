`timescale 1ns/1ps

module tb_btn_encoder;

reg clk;
reg nrst;
reg btn_up;
reg btn_down;
reg next_digit;

wire [3:0] digits [6:0];

reg [3:0] dig0;
reg [3:0] dig1;
reg [3:0] dig2;
reg [3:0] dig3;
reg [3:0] dig4;
reg [3:0] dig5;
reg [3:0] dig6;

button_encoder uut (
    .clk(clk),
    .nrst(nrst),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .next_digit(next_digit),
    .digits(digits)
);

// 100 MHz clock, T = 10 ns
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];
    
    // VCD
    $dumpfile("sim/btn_encoder.vcd");
    $dumpvars(0, tb_btn_encoder);

    // Initial values
    nrst = 1'b0;
    btn_up = 1'b0;
    btn_down = 1'b0;
    next_digit = 1'b0;

    // Reset
    #100;

    nrst = 1'b1;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    // =====================================
    // Test button presses
    // =====================================

    // Increment the first digit (digits[0])
    #10000;
    btn_up = 1'b1;
    #10;
    btn_up = 1'b0;
    #10000;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    // Move to the next digit (digits[1])
    #10000;
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    #10000;
    // Increment the fourth digit (digits[3])
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;
    #10000;
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;
    #10000;
    btn_up = 1'b1;
    #10;
    btn_up = 1'b0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    #10000;
    btn_up = 1'b1;
    #10;
    btn_up = 1'b0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    // Reset
    #100;
    nrst = 1'b0;
    #100;
    nrst = 1'b1;

    #10000;
    // Decrement the fifth digit (digits[3]) - without Reset, with Reset decrement the second digit (digits[1]) 
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;
    #10000;
    btn_down = 1'b1;
    #10;
    btn_down = 1'b0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];
    #10000;

    $finish;
end
endmodule