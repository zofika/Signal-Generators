// Direct Digital Synthesis

module dds_generator (
    input clk,
    input [3:0] bcd_digits [6:0], // 7 BCD digits (4 bits each)
    output reg square_out
);

BCD_to_freq_tuning_word converter(
    .bcd_digits(bcd_digits),
    .freq_tuning_word(freq_tuning_word)
);

phase_accumulator phase_acc(
    .clk(clk),
    .freq_tuning_word(freq_tuning_word),
    .square_out(square_out)
);

endmodule