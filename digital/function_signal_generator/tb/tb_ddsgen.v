`timescale 1ns/100ps

module tb_dssgen;
reg clk;
reg [3:0] bcd_digits [6:0]; // 7 BCD
wire square_out;

// Instantiate the DDS generator
dds_generator uut (
    .clk(clk),
    .bcd_digits(bcd_digits),
    .square_out(square_out)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz clock (10 ns period)
end

// Test sequence
initial begin
    $dumpfile("sim/dds_generator.vcd"); // Create a VCD file for waveform viewing
    $dumpvars(0, tb_dssgen); // Dump all variables in the testbench 

    // Wait for some time to observe the output
    // #10000000; // Wait for 1 us

    // Initialize BCD digits to represent 1234567 Hz
    bcd_digits[6] = 4'd1; // Millions
    bcd_digits[5] = 4'd2; // Hundred-thousands
    bcd_digits[4] = 4'd3; // Ten-thousands
    bcd_digits[3] = 4'd4; // Thousands
    bcd_digits[2] = 4'd5; // Hundreds
    bcd_digits[1] = 4'd6; // Tens
    bcd_digits[0] = 4'd7; // Units
    
    // Wait for some time to observe the output
    #10000000; // Wait for 1 us

    // Change frequency to 0654321 Hz
    bcd_digits[0] = 4'd1; // Units
    bcd_digits[1] = 4'd2; // Tens
    bcd_digits[2] = 4'd3; // Hundreds
    bcd_digits[3] = 4'd4; // Thousands
    bcd_digits[4] = 4'd5; // Ten-thousands
    bcd_digits[5] = 4'd6; // Hundred-thousands
    bcd_digits[6] = 4'd0; // Millions
    #10000000; // Wait for 1 us

    $finish; // End the simulation
end

endmodule