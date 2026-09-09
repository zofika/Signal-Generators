`timescale 1ns/1ps

module tb_display_decoder;

reg clk;
reg nrst;
reg [3:0] digits [6:0]; // 7 BCD digits (4 bits each)

wire [6:0] seg;
wire [6:0] an;

display_decoder uut (
    .clk(clk),
    .nrst(nrst),
    .digits(digits),
    .seg(seg),
    .an(an)
);

// 100 MHz clock, T = 10 ns
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin

    // VCD
    $dumpfile("sim/display_decoder.vcd");
    $dumpvars(0, tb_display_decoder);

    // Initial values
    nrst = 1'b0;

    // Reset
    #100;

    nrst = 1'b1;

    // =====================================
    // Test different frequency values
    // =====================================

    // 1 MHz
    digits[0] = 4'd0;
    digits[1] = 4'd0;
    digits[2] = 4'd0;
    digits[3] = 4'd0;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd1;

    #10_000_000

    // 100 kHz
    digits[0] = 4'd0;
    digits[1] = 4'd0;
    digits[2] = 4'd0;
    digits[3] = 4'd0;
    digits[4] = 4'd0;
    digits[5] = 4'd1;
    digits[6] = 4'd0;

    #10_000_000

    // 10 kHz
    digits[0] = 4'd0;
    digits[1] = 4'd0;
    digits[2] = 4'd0;
    digits[3] = 4'd0;
    digits[4] = 4'd1;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    #10_000_000

    // 1 kHz
    digits[0] = 4'd0;
    digits[1] = 4'd0;
    digits[2] = 4'd0;
    digits[3] = 4'd1;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    #10_000_000

    // 100 Hz
    digits[0] = 4'd0;
    digits[1] = 4'd0;           
    digits[2] = 4'd1;
    digits[3] = 4'd0;
    digits[4] = 4'd0;
    digits[5] = 4'd0;
    digits[6] = 4'd0;

    #10_000_000

    $finish;

end

endmodule