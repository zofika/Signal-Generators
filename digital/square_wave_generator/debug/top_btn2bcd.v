module top_btn2bcd (
    input clk,
    input rstn,
    input btn_up,
    input btn_down,
    input next_digit,
    output [19:0] freq_value
);

wire [3:0] digits [6:0]; // 7 BCD digits for frequency input

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

endmodule