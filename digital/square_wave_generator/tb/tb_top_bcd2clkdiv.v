`timescale 1ns/1ps

module tb_top_bcd2clkdiv;

reg clk;
reg nrst;
reg [3:0] digits [6:0]; // 7 BCD digits for frequency input
wire [19:0] freq_value;

wire out_signal;

reg square_wave_out;
reg [19:0] temp_freq_value;

reg [3:0] dig0;
reg [3:0] dig1;
reg [3:0] dig2;
reg [3:0] dig3;
reg [3:0] dig4;
reg [3:0] dig5;
reg [3:0] dig6;

top_squaregenerator uut (
    .clk(clk),
    .rstn(nrst),
    .digits(digits),
    .out_signal(out_signal),
    .out_freq_value(freq_value)
);

// reg [19:0] temp_freq_value;

// 100 MHz clock, T = 10 ns
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin

    // VCD
    $dumpfile("sim/top_bcd2clkdiv.vcd");
    $dumpvars(0, tb_top_bcd2clkdiv);

    // Initial values
    nrst = 1'b0;
    digits[0] = 4'd0;
    digits[1] = 4'd0;
    digits[2] = 4'd0;
    digits[3] = 4'd0;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    square_wave_out = out_signal;

    // Reset
    #100;

    nrst = 1'b1;

    // =====================================
    // Test button presses
    // =====================================

    // Increment the first digit (digits[0])
    #10000;

    digits[0] = 4'd1;
    digits[1] = 4'd0;
    digits[2] = 4'd0;
    digits[3] = 4'd0;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    square_wave_out = out_signal;
    temp_freq_value = freq_value;

    // Move to the next digit (digits[1])
    #10000;

    digits[0] = 4'd0;
    digits[1] = 4'd1;
    digits[2] = 4'd0;
    digits[3] = 4'd0;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    square_wave_out = out_signal;
    temp_freq_value = freq_value;

    #10000;
    // Increment the fourth digit (digits[3])

    digits[0] = 4'd0;
    digits[1] = 4'd0;
    digits[2] = 4'd0;
    digits[3] = 4'd1;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    square_wave_out = out_signal;
    temp_freq_value = freq_value;

    #10000;

    // Reset
    #100;
    nrst = 1'b0;
    #100;
    nrst = 1'b1;

    square_wave_out = out_signal;
    temp_freq_value = freq_value;

    #10000;
    // Decrement the fifth digit (digits[3]) - without Reset, with Reset decrement the second digit (digits[1]) 

    digits[0] = 4'd0;
    digits[1] = 4'd9;
    digits[2] = 4'd0;
    digits[3] = 4'd0;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    dig0 = digits[0];
    dig1 = digits[1];
    dig2 = digits[2];
    dig3 = digits[3];
    dig4 = digits[4];
    dig5 = digits[5];
    dig6 = digits[6];

    square_wave_out = out_signal;
    temp_freq_value = freq_value;
    #100000;

    $finish;
end
endmodule