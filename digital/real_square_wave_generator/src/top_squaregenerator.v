module top_squaregenerator (
    input clk,
    input rstn,
    //input btn_up,
    //input btn_down,
    //input next_digit,
    input [19:0] freq_value, // Frequency value in Hz
    output square_out
);

clock_divider clock_divider_inst (
    .clk(clk),
    .rstn(rstn),
    .freq_value(freq_value),
    .signal_out(square_out)
);

endmodule