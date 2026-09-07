`timescale 1ns/1ps

module tb_top;

reg clk;
reg nrst;
reg btn_up;
reg btn_down;
reg next_digit;

wire [3:0] out_digits [6:0]; // 7 BCD digits for frequency input

wire out_signal;
wire seg [6:0];
wire an [6:0];

wire [19:0] freq_value;

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
    .btn_up(btn_up),
    .btn_down(btn_down),
    .next_digit(next_digit),
    .out_signal(out_signal),
    .out_digits(out_digits),
    .out_freq_value(freq_value)
);

// 100 MHz clock, T = 10 ns
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin

    // VCD
    $dumpfile("sim/top_squaregenerator.vcd");
    $dumpvars(0, tb_top);

    // Initial values
    nrst = 1'b0;
    btn_up = 1'b0;
    btn_down = 1'b0;
    next_digit = 1'b0;

    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    // Reset
    #100;

    nrst = 1'b1;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    // =====================================
    // Test button presses
    // =====================================
    #11_000_000;


    // Move to the next digit (digits[1])
    next_digit = 1'b1;
    #11_000_000;
    next_digit = 1'b0;
    #11_000_000;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    // Increment the fourth digit (digits[3]) - 2001 Hz
    next_digit = 1'b1;
    #11_000_000;
    next_digit = 1'b0;
    #11_000_000;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    next_digit = 1'b1;
    #11_000_000;
    next_digit = 1'b0;
    #11_000_000;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    btn_up = 1'b1;
    #11_000_000;
    btn_up = 1'b0;
    #11_000_000;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];
    
    btn_up = 1'b1;
    #11_000_000;
    btn_up = 1'b0;
    #11_000_000;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    // Reset
    #100;
    nrst = 1'b0;
    #100;
    nrst = 1'b1;
    #100;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    // Decrement the fifth digit (digits[3]) - without Reset, with Reset decrement the second digit (digits[1]) - 2091 Hz 
    next_digit = 1'b1;
    #11_000_000;
    next_digit = 1'b0;
    #11_000_000;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    btn_down = 1'b1;
    #11_000_000;
    btn_down = 1'b0;
    #11_000_000;
    temp_freq_value = freq_value;
    square_wave_out = out_signal;

    dig0 = out_digits[0];
    dig1 = out_digits[1];
    dig2 = out_digits[2];
    dig3 = out_digits[3];
    dig4 = out_digits[4];
    dig5 = out_digits[5];
    dig6 = out_digits[6];

    #11_000_000;
    
    $finish;
end

initial begin 
    $monitor("Time: %0t | nrst: %b | btn_up: %b | btn_down: %b | next_digit: %b | digits: [%d, %d, %d, %d, %d, %d, %d] | freq_value: %d | out_signal: %b", 
        $time, nrst, btn_up, btn_down, next_digit, out_digits[0], out_digits[1], out_digits[2], out_digits[3], out_digits[4], out_digits[5], out_digits[6], freq_value, out_signal);
end

always @(posedge clk) begin
    if ($time < 200) begin
        $display(
            "t=%0t rst=%b encoder digits=%d %d %d %d %d %d %d",
            $time,
            nrst,
            uut.button_controller_inst.encoder.digits[0],
            uut.button_controller_inst.encoder.digits[1],
            uut.button_controller_inst.encoder.digits[2],
            uut.button_controller_inst.encoder.digits[3],
            uut.button_controller_inst.encoder.digits[4],
            uut.button_controller_inst.encoder.digits[5],
            uut.button_controller_inst.encoder.digits[6]
        );
    end
end

endmodule