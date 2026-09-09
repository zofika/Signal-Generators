`timescale 1ns/1ps

module tb_top;

reg clk;
reg rstn;
reg [19:0] freq_value;

wire square_out;


// DUT
top_squaregenerator uut (
    .clk(clk),
    .rstn(rstn),
    .freq_value(freq_value),
    .square_out(square_out)
);

// 100 MHz clock, T = 10 ns
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end


initial begin

    // VCD
    $dumpfile("sim/top_clk_div.vcd");
    $dumpvars(0, tb_top);

    // Initial values
    rstn = 1'b0;
    freq_value = 20'd0;

    // Reset
    #100;

    rstn = 1'b1;

    // =====================================
    // 1 MHz
    // =====================================

    freq_value = 20'd1_000_000;

    #10_000;


    // =====================================
    // 100 kHz
    // =====================================

    freq_value = 20'd100_000;

    #10_000;


    // =====================================
    // 10 kHz
    // =====================================

    freq_value = 20'd10_000;

    #100_000;


    // =====================================
    // 0 Hz
    // =====================================

    freq_value = 20'd0;

    #1_000;


    $finish;

end

endmodule