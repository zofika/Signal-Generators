module bcd2dec_converter (
    input [3:0] digits [6:0], // 7 BCD digits (4 bits each)
    output reg [19:0] freq_value // 20-bit frequency value
);

// ============================================================
// BCD -> Binary conversion
// ============================================================ 

always @(*) begin
    freq_value =
          digits[0] * 20'd1
        + digits[1] * 20'd10
        + digits[2] * 20'd100
        + digits[3] * 20'd1000
        + digits[4] * 20'd10000
        + digits[5] * 20'd100000
        + digits[6] * 20'd1000000;
end

endmodule