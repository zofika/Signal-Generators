module edge_detector (
    input clk,
    input nrst,
    input btn_in,
    output reg pulse_out
);

reg btn_prev; // Previous state of the button

always @(posedge clk or negedge nrst) begin
    if (!nrst) begin
        pulse_out <= 0; // Reset pulse output on reset
        btn_prev <= 0; // Reset previous button state on reset
    end else begin
        pulse_out <= btn_in && !btn_prev; // Generate a pulse when the button goes from 0 to 1
        btn_prev <= btn_in; // Update the previous state of the button
    end
end

endmodule
