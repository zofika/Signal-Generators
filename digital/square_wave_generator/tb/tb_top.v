`timescale 100us/1us

module tb_top;

reg clk;
reg btn_up;
reg btn_down;
reg next_digit;
wire square_out;    

// Instantiate the top module
top_squaregenerator uut (
    .clk(clk),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .next_digit(next_digit),
    .square_out(square_out)
);

// Clock generation
initial begin
    clk = 0;
    forever #10000000 clk = ~clk; // 100 MHz clock (10 ns period)
end

// Test sequence
initial begin
    $dumpfile("sim/top_squaregenerator.vcd"); // Create a VCD file for waveform viewing
    $dumpvars(0, tb_top); // Dump all variables in the testbench

    // Initialize inputs
    btn_up = 0;
    btn_down = 0;
    next_digit = 0;
    #100; // Wait for 100 ns
    // Simulate button presses to set frequency to 1234567 Hz
    // Set digit 0 to 7
    next_digit = 1; #20; // Move to digit 0 
    next_digit = 0; btn_up = 1; #10; btn_up = 0; #10; // Increment digit 0 to 7
    // Set digit 1 to 6
    next_digit = 1; #10; // Move to digit 1
    next_digit = 0; btn_up = 1; #10; btn_up = 0; #10; // Increment digit 1 to 6
    // Set digit 2 to 5
    next_digit = 1; #10; // Move to digit 2
    next_digit = 0; btn_up = 1; #10; btn_up = 0; #10; // Increment digit 2 to 5
    // Set digit 3 to 4
    next_digit = 1; #10; // Move to digit 3
    next_digit = 0; btn_up = 1; #10; btn_up = 0; #10; // Increment digit 3 to 4
    // Set digit 4 to 3
    next_digit = 1; #10; // Move to digit 4
    next_digit = 0; btn_up = 1; #10; btn_up = 0; #10; // Increment digit 4 to 3
    // Set digit 5 to 2
    next_digit = 1; #10; // Move to digit 5     
    next_digit = 0; btn_up = 1; #10; btn_up = 0; #10; // Increment digit 5 to 2
    // Set digit 6 to 1
    next_digit = 1; #10; // Move to digit 6
    next_digit = 0; btn_up = 1; #10; btn_up = 0; #10; // Increment digit 6 to 1
    // Wait for some time to observe the output
    #1000; // Wait for 1 us
    $finish; // End the simulation      

    $monitor("Time: %0t, square_out: %b", $time, square_out); // Monitor the output signal
end
    
endmodule