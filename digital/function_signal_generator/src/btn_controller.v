module btn_controller (
    input clk,
    input btn_up,
    input btn_down,
    input next_digit,
    output reg [3:0] bcd_digits [6:0]
);

wire btn_up_pulse, btn_down_pulse, next_digit_pulse;
wire btn_up_edge_pulse, btn_down_edge_pulse, next_digit_edge_pulse;

// Debounce and edge detection for btn_up
btn_debouncer btn_up_deb (
    .clk(clk),
    .noisy_btn_in(btn_up),
    .debounced_btn_out(btn_up_pulse)
);

edge_detector btn_up_edge (
    .clk(clk),
    .btn_in(btn_up_pulse),
    .pulse_out(btn_up_edge_pulse)
);

// Debounce and edge detection for btn_down
btn_debouncer btn_down_deb (
    .clk(clk),
    .noisy_btn_in(btn_down),
    .debounced_btn_out(btn_down_pulse)
);

edge_detector btn_down_edge (
    .clk(clk),
    .btn_in(btn_down_pulse),
    .pulse_out(btn_down_edge_pulse)
);

// Debounce and edge detection for next_digit button
btn_debouncer next_digit_deb (
    .clk(clk),
    .noisy_btn_in(next_digit),
    .debounced_btn_out(next_digit_pulse)
);

edge_detector next_digit_edge (
    .clk(clk),
    .btn_in(next_digit_pulse),
    .pulse_out(next_digit_edge_pulse)
);

// Button encoder to update the BCD digits based on push-button inputs
btn_encoder encoder (
    .clk(clk),
    .btn_up(btn_up_edge_pulse),
    .btn_down(btn_down_edge_pulse),
    .next_digit(next_digit_edge_pulse),
    .digits(bcd_digits)
);

endmodule