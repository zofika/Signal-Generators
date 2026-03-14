module BCD_to_freq_tuning_word (
    input [3:0] bcd_digits [6:0], // 7 BCD digits (4 bits each)
    output reg freq_tuning_word // 32-bit frequency tuning word
);

initial begin
    freq_tuning_word = 0; // Initialize frequency tuning word to 0
end

always @(*) begin
    // Convert BCD digits to a single frequency value in Hz
    integer i;
    reg [19:0] digits_freq; // Maximum frequency is 1000000 Hz, which fits in 20 bits
    digits_freq = 0;
    for (i = 0; i < 7; i = i + 1) begin
        digits_freq = digits_freq * 10 + bcd_digits[i]; // Shift left and add the next digit
    end

    // Calculate the frequency tuning word for the 32-bit accumulator DDS generator with 100 MHz clock (100,000,000 Hz)
    // freq_tuning_word = (bcd_digits_freq * 2^32) / clk_freq
    freq_tuning_word = (digits_freq * 4294967296) / 100000000; // 2^32 = 4294967296
end

endmodule
