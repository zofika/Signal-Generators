module display_driver (
    input clk,
    input [3:0] digits [6:0],
    output reg [6:0] seg,
    output reg [6:0] an
);

reg [2:0] current_digit = 0; // Current digit index (0-6)

always @(posedge clk) begin
    // Update the anode signals to select the current digit
    an <= ~(1 << current_digit); // Active low, so we invert the bit

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

    // Move to the next digit for the next clock cycle
    current_digit <= (current_digit + 1) % 7;
end

endmodule