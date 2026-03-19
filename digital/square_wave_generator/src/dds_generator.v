// Direct Digital Synthesis

module dds_generator (
    input clk,
    input [3:0] bcd_digits [6:0], // 7 BCD digits for frequency input
    output reg square_out
);

reg [19:0] digits_freq; // 19-bit frequency in Hz for the DDS generator
reg [31:0] freq_tuning_word; // 32-bit frequency tuning word
reg [31:0] phase_acc; // Phase accumulator


initial begin
    freq_tuning_word = 0; // Initialize frequency tuning word to 0
    phase_acc = 0; // Initialize phase accumulator to 0
    square_out = 0; // Initialize square wave output to 0
end

// Convert BCD digits to a single frequency value in Hz
always @(*) begin
    integer i;
    digits_freq = 0;
    for (i = 0; i < 7; i = i + 1) begin
        digits_freq = digits_freq * 10 + bcd_digits[i]; // Shift left and add the next digit
    end
end

// Calculate the frequency tuning word for the 32-bit accumulator DDS generator with 100 MHz clock (100,000,000 Hz)
always @(digits_freq) begin
    freq_tuning_word = (digits_freq * 4294967296) / 100000000; // 2^32 = 4294967296
end

// Phase accumulator for DDS
always @(posedge clk) begin
    phase_acc <= phase_acc + freq_tuning_word; // Increment the phase accumulator by the tuning word
    square_out <= phase_acc[31]; // Output the MSB of the phase accumulator as the square wave approximation of sine wave (1-bit resolution)
end

endmodule