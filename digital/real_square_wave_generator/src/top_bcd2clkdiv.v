module top_bcd2clkdiv (
    input clk,
    input rstn,
    input [3:0] digits [6:0], // 7 BCD digits for frequency input
    output out_signal,
    output [19:0] out_freq_value
);

wire [19:0] freq_value; // 20-bit frequency value

bcd2dec_converter bcd2dec_inst (
    .digits(digits),
    .freq_value(freq_value)
);

clock_divider clk_div_inst (
    .clk(clk),
    .rstn(rstn),
    .freq_value(freq_value),
    .signal_out(out_signal)
);

assign out_freq_value = freq_value;

endmodule