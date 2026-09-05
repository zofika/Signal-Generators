`timescale 1ns/1ps

module tb_display_driver;

reg clk;
reg nrst;
reg [19:0] freq_value;

wire [6:0] seg;
wire [6:0] an;

display_driver uut (
    .clk(clk),
    .nrst(nrst),
    .freq_value(freq_value),
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
    $dumpfile("sim/display_driver.vcd");
    $dumpvars(0, tb_display_driver);

    // Initial values
    nrst = 1'b0;
    freq_value = 20'd0;

    // Reset
    #100;

    nrst = 1'b1;

    // =====================================
    // Test different frequency values
    // =====================================

    freq_value = 20'd1_000_000; // 1 MHz
    #10_000_000

    freq_value = 20'd100_000; // 100 kHz
    #10_000_000

    freq_value = 20'd10_000; // 10 kHz
    #10_000_000

    freq_value = 20'd1_000; // 1 kHz
    #10_000_000

    freq_value = 20'd100; // 100 Hz
    #10_000_000

    $finish;

end

endmodule