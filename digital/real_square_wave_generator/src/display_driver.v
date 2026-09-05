module display_driver (
    input clk,
    input nrst,
    input [19:0] freq_value,

    output reg [6:0] seg,
    output reg [6:0] an
);

reg [2:0] current_digit; // Current digit index (0-6)
reg [3:0] digits [6:0]; // Data to be displayed on the 7-segment display

reg [19:0] temp_value; // Temporary variable for BCD conversion
reg [16:0] refresh_counter; // Counter for refreshing the display

// ============================================================
// Binary -> decimal digits
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
    end else begin
        // Convert freq_value to BCD and store in digits array 
        integer i; 
        temp_value = freq_value; 
        for (i = 0; i < 7; i = i + 1) begin 
            digits[i] <= temp_value % 10; // Get the least significant digit 
            temp_value = temp_value / 10; // Remove the least significant digit 
        end
    end
end


// ============================================================
// Display refresh
// ============================================================

always @(posedge clk or negedge nrst) begin
    if (!nrst) begin
        current_digit <= 0; // Reset current digit index on reset
        refresh_counter <= 0; // Reset refresh counter on reset
    end
    else begin
        if (refresh_counter == 17'd99_999) begin
            refresh_counter <= 17'd0;
            if (current_digit == 6)
                current_digit <= 3'd0;
            else
                current_digit <= current_digit + 1'b1;
        end
        else begin
            refresh_counter <= refresh_counter + 1'b1;
        end
    end
end

// ============================================================
// Anode digit selection
// ============================================================

always @(*) begin
    an = 7'b1111111;
    an[current_digit] = 1'b0; // Update the anode signals to select the current digit
end

// ============================================================
// 7-segment decoder
// ============================================================

always @(posedge clk) begin
    // Update the segment signals based on the current digit's value
    case (digits[current_digit])
        0: seg <= 7'b0111111; // 0
        1: seg <= 7'b0000110; // 1
        2: seg <= 7'b1011011; // 2
        3: seg <= 7'b1001111; // 3
        4: seg <= 7'b1100110; // 4
        5: seg <= 7'b1101101; // 5
        6: seg <= 7'b1111101; // 6
        7: seg <= 7'b0000111; // 7
        8: seg <= 7'b1111111; // 8
        9: seg <= 7'b1101111; // 9
        default: seg <= 7'b0000000; // Blank for invalid input
    endcase
end

endmodule