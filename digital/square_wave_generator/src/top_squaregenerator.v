module top_squaregenerator (
    input clk,
    input btn_up,
    input btn_down,
    input next_digit,
    output square_out
);

reg [3:0] digits [6:0]; // 7 BCD digits for frequency input

btn_controller button_controller(
    .clk(clk),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .next_digit(next_digit),
    .bcd_digits(digits)
);

dds_generator dds_square_wave_generator(
    .clk(clk),
    .bcd_digits(digits),
    .square_out(square_out)
);

endmodule