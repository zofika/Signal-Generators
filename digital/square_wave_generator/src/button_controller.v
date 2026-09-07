module button_controller (
    input clk,
    input nrst,
    input btn_up,
    input btn_down,
    input next_digit,
    output wire [3:0] digits [6:0] // 7 BCD digits for frequency input - poniewaz jest wyjsciem z innego modulu, to nie moze byc reg, tylko wire
);

wire btn_up_pulse, btn_down_pulse, next_digit_pulse;
wire btn_up_edge_pulse, btn_down_edge_pulse, next_digit_edge_pulse;

// Debounce and edge detection for btn_up
button_debouncer btn_up_deb (
    .clk(clk),
    .nrst(nrst),
    .noisy_btn_in(btn_up),
    .debounced_btn_out(btn_up_pulse)
);

edge_detector btn_up_edge (
    .clk(clk),
    .nrst(nrst),
    .btn_in(btn_up_pulse),
    .pulse_out(btn_up_edge_pulse)
);

// Debounce and edge detection for btn_down
button_debouncer btn_down_deb (
    .clk(clk),
    .nrst(nrst),
    .noisy_btn_in(btn_down),
    .debounced_btn_out(btn_down_pulse)
);

edge_detector btn_down_edge (
    .clk(clk),
    .nrst(nrst),
    .btn_in(btn_down_pulse),
    .pulse_out(btn_down_edge_pulse)
);

// Debounce and edge detection for next_digit button
button_debouncer next_digit_deb (
    .clk(clk),
    .nrst(nrst),
    .noisy_btn_in(next_digit),
    .debounced_btn_out(next_digit_pulse)
);

edge_detector next_digit_edge (
    .clk(clk),
    .nrst(nrst),
    .btn_in(next_digit_pulse),
    .pulse_out(next_digit_edge_pulse)
);

// Button encoder to update the BCD digits based on push-button inputs
button_encoder encoder (
    .clk(clk),
    .nrst(nrst),
    .btn_up(btn_up_edge_pulse),
    .btn_down(btn_down_edge_pulse),
    .next_digit(next_digit_edge_pulse),
    .digits(digits)
);

endmodule
