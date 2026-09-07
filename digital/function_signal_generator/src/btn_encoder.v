module btn_encoder (
    input clk,
    input btn_up,
    input btn_down,
    input next_digit,
    output reg [3:0] digits [6:0]
);
reg [2:0] current_digit = 0; // Current digit index (0-6)
reg [19:0] freq_value; // Frequency value in Hz for limit checking

integer i;
initial begin
    for (i = 0; i < 7; i = i + 1)
        digits[i] = 0; // Initialize all digits to 0
    freq_value = 0; // Initialize frequency value to 0
end

// Procedura BCD -> integer
task bcd_to_int;
    output [19:0] value;
    integer j;
    begin
        value = 0;
        for (j=6; j>=0; j=j-1) // MSB->LSB
            value = value*10 + digits[j];
    end
endtask

always @(posedge clk) begin
    if (next_digit) begin
        if (current_digit == 6) begin
            current_digit <= 0; // Wrap around to the first digit
        end else begin
            current_digit <= current_digit + 1; // Move to the next digit
            $display("Current digit selected: %0d", current_digit);
        end
    end else if (btn_up) begin
        if (current_digit == 6) begin
            bcd_to_int(freq_value); // sprawdź limit
            if (freq_value > 20'd1000000) begin
                digits[0] <= 0;
                digits[1] <= 0;
                digits[2] <= 0;
                digits[3] <= 0;
                digits[4] <= 0;
                digits[5] <= 0;
                digits[6] <= 1; // Ustaw 1 MHz - maksymalną wartość
                $display("Value exceeded 1 MHz, resetting to 1 MHz");
            end 
        end else if (digits[current_digit] == 9) begin
            digits[current_digit] <= 0; // Wrap around to 0
        end else begin
            digits[current_digit] <= digits[current_digit] + 1; // Increment the current digit
            $display("Digit %0d incremented to: %0d", current_digit, digits[current_digit]);
        end
    end else if (btn_down) begin
        if (digits[current_digit] == 0) begin
            digits[current_digit] <= 9; // Wrap around to 9
        end else begin
            digits[current_digit] <= digits[current_digit] - 1; // Decrement the current digit
            $display("Digit %0d decremented to: %0d", current_digit, digits[current_digit]);
        end
    end
end  
endmodule
