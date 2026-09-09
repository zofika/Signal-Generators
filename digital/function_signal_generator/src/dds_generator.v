// Direct Digital Synthesis

module dds_generator (
    input clk,
    input [3:0] bcd_digits [6:0], // 7 BCD digits for frequency input
    output reg square_out
);

reg [63:0] temp;
reg [19:0] digits_freq; // 19-bit frequency in Hz for the DDS generator
reg [19:0] digits_freq_reg; // Register to hold the frequency value for use in the tuning word calculation
reg [31:0] freq_tuning_word; // 32-bit frequency tuning word
reg [31:0] phase_acc; // Phase accumulator


initial begin
    digits_freq_reg = 0;
    digits_freq = 0; // Initialize frequency to 0 Hz
    freq_tuning_word = 0; // Initialize frequency tuning word to 0
    phase_acc = 0; // Initialize phase accumulator to 0
    square_out = 0; // Initialize square wave output to 0
end

// Convert BCD digits to a single frequency value in Hz
always @(*) begin
    integer i;
    digits_freq = 0;
    for (i = 6; i >= 0; i = i - 1) begin
        digits_freq = digits_freq * 10 + bcd_digits[i]; // Shift left and add the next digit
        //$display("Digit %0d: %0d, Frequency so far: %0d", i, bcd_digits[i], digits_freq);
    end
end

always @(posedge clk) begin
    digits_freq_reg <= digits_freq;
end

// Calculate the frequency tuning word for the 32-bit accumulator DDS generator with 100 MHz clock (100,000,000 Hz)
always @(posedge clk) begin
    temp = digits_freq_reg * 64'd4294967296; // 2^32 = 4294967296
    freq_tuning_word = temp / 100000000;
end

// Phase accumulator for DDS
always @(posedge clk) begin
    phase_acc <= phase_acc + freq_tuning_word; // Increment the phase accumulator by the tuning word
    square_out <= phase_acc[31]; // Output the MSB of the phase accumulator as the square wave approximation of sine wave (1-bit resolution)
end

endmodule