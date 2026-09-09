`timescale 1ns/1ps

module tb_top_btn2bcd;

reg clk;
reg nrst;
reg btn_up;
reg btn_down;
reg next_digit;

wire [19:0] freq_value;

reg [19:0] temp_freq_value;

// 100 MHz clock, T = 10 ns
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin

    // VCD
    $dumpfile("sim/top_btn2bcd.vcd");
    $dumpvars(0, tb_top_btn2bcd);

    // Initial values
    nrst = 1'b0;
    btn_up = 1'b0;
    btn_down = 1'b0;
    next_digit = 1'b0;

    temp_freq_value = freq_value;

    // Reset
    #100;

    nrst = 1'b1;
    temp_freq_value = freq_value;

    // =====================================
    // Test button presses
    // =====================================

    // Increment the first digit (digits[0]) - 1 Hz
    #10000;
    btn_up = 1'b1;
    #10;
    btn_up = 1'b0;
    #10000;
    temp_freq_value = freq_value;

    // Move to the next digit (digits[1])
    #10000;
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;
    #10000;
    temp_freq_value = freq_value;

    // Increment the fourth digit (digits[3]) - 2001 Hz
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;
    #10000;
    temp_freq_value = freq_value;
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;
    #10000;
    temp_freq_value = freq_value;
    btn_up = 1'b1;
    #10;
    btn_up = 1'b0;
    #10000;
    temp_freq_value = freq_value;
    
    btn_up = 1'b1;
    #10;
    btn_up = 1'b0;
    temp_freq_value = freq_value;

    // Reset
    #100;
    nrst = 1'b0;
    #100;
    nrst = 1'b1;
    #10000;
    temp_freq_value = freq_value;

    // Decrement the fifth digit (digits[3]) - without Reset, with Reset decrement the second digit (digits[1]) - 2091 Hz 
    next_digit = 1'b1;
    #10;
    next_digit = 1'b0;
    #10000;
    temp_freq_value = freq_value;
    btn_down = 1'b1;
    #10;
    btn_down = 1'b0;
    temp_freq_value = freq_value;
    #10000;


    $finish;
end

endmodule