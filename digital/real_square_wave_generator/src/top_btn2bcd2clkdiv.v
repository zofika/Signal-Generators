module top_btn2bcd2clkdiv (
    input clk,
    input rstn,
    input btn_up,
    input btn_down,
    input next_digit,
    output square_out
);

wire [3:0] digits [6:0]; // 7 BCD digits for frequency input
wire [19:0] freq_value; // 20-bit frequency value

button_encoder button_enc_inst (
    .clk(clk),
    .nrst(rstn),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .next_digit(next_digit),
    .digits(digits)
);

bcd2dec_converter bcd2dec_inst (
    .digits(digits),
    .freq_value(freq_value)
);

clock_divider clock_divider_inst (
    .clk(clk),
    .rstn(rstn),
    .freq_value(freq_value),
    .signal_out(square_out)
);

endmodule