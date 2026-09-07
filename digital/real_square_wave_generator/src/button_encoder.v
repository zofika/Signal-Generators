module button_encoder (
    input clk,
    input nrst,
    input btn_up,
    input btn_down,
    input next_digit,

    output reg [3:0] digits [6:0]
);
reg [2:0] current_digit; // Current digit index (0-6)

// ============================================================
// Button encoder logic
// ============================================================

always @(posedge clk or negedge nrst) begin
    if (!nrst) begin
        // Reset the digits to 0 on reset
        digits[0] <= 4'd0;
        digits[1] <= 4'd0;
        digits[2] <= 4'd0;
        digits[3] <= 4'd0;
        digits[4] <= 4'd0;
        digits[5] <= 4'd0;
        digits[6] <= 4'd0;
        current_digit <= 3'd0; // Reset current digit index on reset
    end else begin
        // Handle button presses
        if (btn_up) begin
            if (digits[current_digit] < 4'd9)
                digits[current_digit] <= digits[current_digit] + 1'b1; // Increment the current digit
            else
                digits[current_digit] <= 4'd0; // Wrap around to 0 if it exceeds 9
        end

        else if (btn_down) begin
            if (digits[current_digit] > 4'd0)
                digits[current_digit] <= digits[current_digit] - 1'b1; // Decrement the current digit
            else
                digits[current_digit] <= 4'd9; // Wrap around to 9 if it goes below 0
        end

        else if (next_digit) begin
            if (current_digit == 3'd6)
                current_digit <= 3'd0; // Wrap around to the first digit if it exceeds the last digit
            else
                current_digit <= current_digit + 1'b1; // Move to the next digit
        end
    end
end

endmodule
