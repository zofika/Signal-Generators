module edge_detector (
    input clk,
    input btn_in,
    output reg pulse_out
);

reg btn_prev; // Previous state of the button

initial begin
    btn_prev = 0; // Initialize previous button state to 0
    pulse_out = 0; // Initialize pulse output to 0
end

always @(posedge clk) begin
    pulse_out <= btn_in && !btn_prev; // Generate a pulse when the button goes from 0 to 1
    btn_prev <= btn_in; // Update the previous state of the button
end

endmodule
