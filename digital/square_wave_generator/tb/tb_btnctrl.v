`timescale 1ns/100ps

module tb_btnctrl;
reg clk;
reg btn_up;
reg btn_down;
reg next_digit;
wire [3:0] bcd_digits [6:0];

// Instantiate the button controller
btn_controller uut (
    .clk(clk),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .next_digit(next_digit),
    .bcd_digits(bcd_digits)
);

// Clock generation
initial begin
    clk = 0;
    forever #10 clk = ~clk; // 100 MHz clock (10 ns period)
end

// Test sequence
initial begin
    $dumpfile("sim/btn_controller.vcd"); // Create a VCD file for
    $dumpvars(0, tb_btnctrl); // Dump all variables in the testbench
    // Initialize inputs
    btn_up = 0;
    btn_down = 0;
    next_digit = 0;
    #100; // Wait for 100 ns
    // Simulate button presses to set frequency to 1234567 Hz
    // Set digit 0 to 7
    next_digit = 0; btn_up = 1; #20000000; btn_up = 1; btn_down = 1; #20000000; btn_down = 0; btn_up = 0; #20000000; // Increment digit 0 to 7
    // Set digit 1 to 6
    next_digit = 1; #20000000; // Move to digit 1
    next_digit = 0; btn_up = 1; #20000000; btn_up = 0; #20000000; // Increment digit 1 to 1
    // Set digit 2 to 5
    next_digit = 1; #20000000; // Move to digit 2
    next_digit = 0; btn_up = 1; #20000000; btn_up = 0; #20000000; btn_up = 1; #20000000; btn_up = 0; #20000000; // Increment digit 2 to 5
    // Set digit 3 to 4
    next_digit = 1; #20000000; // Move to digit 3
    next_digit = 0; btn_up = 1; #20000000; btn_up = 0; #20000000; // Increment digit 3 to 4
    // Set digit 4 to 3
    next_digit = 1; #20000000; // Move to digit 4
    next_digit = 0; btn_up = 1; #20000000; btn_up = 0; #20000000; btn_up = 1; #20000000; btn_up = 0; #20000000; // Increment digit 4 to 3
    // Set digit 5 to 2
    next_digit = 1; #20000000; // Move to digit 5     
    next_digit = 0; btn_up = 1; #20000000; btn_up = 0; #20000000; // Increment digit 5 to 2
    // Set digit 6 to 1
    next_digit = 1; #20000000; // Move to digit 6  
    next_digit = 0; btn_up = 1; #20000000; btn_up = 0; #20000000; // Increment digit 6 to 1
    next_digit = 0; btn_up = 1; #20000000; btn_up = 0; #20000000; // Increment digit 6 to 1
    // Wait for some time to observe the output
    #100; // Wait for 1 us
    $finish; // End the simulation
end
endmodule