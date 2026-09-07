module top_squaregenerator (
    input clk,
    input rstn,
    input btn_up,
    input btn_down,
    input next_digit,
    
    output out_signal,
    output [6:0] seg,
    output [6:0] an,

    output [3:0] out_digits [6:0], // 7 BCD digits for frequency input  
    output [19:0] out_freq_value
);

wire [3:0] digits [6:0]; // 7 BCD digits for frequency input
wire [19:0] freq_value; // 20-bit frequency value

button_controller button_controller_inst (
    .clk(clk),
    .nrst(rstn),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .next_digit(next_digit),
    .digits(digits)
);

bcd2dec_converter bcd2dec_inst (
    .nrst(rstn),
    .digits(digits),
    .freq_value(freq_value)
);

clock_divider clk_div_inst (
    .clk(clk),
    .rstn(rstn),
    .freq_value(freq_value),
    .signal_out(out_signal)
);

display_decoder display_decoder_inst (
    .clk(clk),
    .nrst(rstn),
    .digits(digits),
    .seg(seg),
    .an(an)
);

assign out_freq_value = freq_value;

assign out_digits[0] = digits[0];
assign out_digits[1] = digits[1];
assign out_digits[2] = digits[2];       
assign out_digits[3] = digits[3];
assign out_digits[4] = digits[4];
assign out_digits[5] = digits[5];
assign out_digits[6] = digits[6];

endmodule