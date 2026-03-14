module btn_encoder (
    input clk,
    input btn_up,
    input btn_down,
    input next_digit,
    output reg [3:0] digits [6:0]
);
reg [2:0] current_digit = 0; // Current digit index (0-6)

always @(posedge clk) begin
    if (next_digit) begin
        current_digit <= (current_digit + 1) % 7; // Move to the next digit
    end else if (btn_up) begin
        digits[current_digit] <= (digits[current_digit] + 1) % 10; // Increment the current digit
    end else if (btn_down) begin
        digits[current_digit] <= (digits[current_digit] + 9) % 10; // Decrement the current digit (adding 9 is equivalent to subtracting 1 modulo 10)
    end
end
    
endmodule