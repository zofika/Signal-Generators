module phase_accumulator (
    input clk,
    input freq_tuning_word,
    output reg square_out
);

reg [31:0] phase_acc = 0; // Phase accumulator

initial begin
    phase_acc = 0; // Initialize phase accumulator to 0
    square_out = 0; // Initialize square wave output to 0
end

always @(posedge clk) begin

    phase_acc <= phase_acc + freq_tuning_word; // Increment the phase accumulator by the tuning word
    square_out <= phase_acc[31]; // Output the MSB of the phase accumulator as the square wave approximation of sine wave (1-bit resolution)
end

endmodule