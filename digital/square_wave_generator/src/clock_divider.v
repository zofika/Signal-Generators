module clock_divider (
    input clk,
    input rstn,
    input [19:0] freq_value, // Frequency value in Hz
    
    output reg signal_out
);
reg [25:0] counter; // Counter for clock division
reg [25:0] clock_divider_N; // Clock divider for generating the output signal

always @(posedge clk or negedge rstn) begin
    // Calculate the clock divider value based on the input frequency
    if (!rstn) begin
        clock_divider_N <= 26'd0;
        counter <= 26'd0;
        signal_out <= 1'b0;
        end 
        else begin
            // Assuming the input clock is 100 MHz, the divider value is calculated as:
            // clock_divider_N = (100,000,000 / (2 * freq_value)) - 1
            if (freq_value > 0) begin
                clock_divider_N <= (100_000_000 / (2 * freq_value)) - 1;
                
                // Clock division logic
                if (counter >= clock_divider_N) begin
                    counter <= 26'd0;
                    signal_out <= ~signal_out; // Toggle output signal
                end else begin
                    counter <= counter + 1;
                    end 
            end
            else begin
                clock_divider_N <= 26'd0;
                counter <= 26'd0;
                signal_out <= 1'b0; // If frequency is 0, output remains low
            end
        end
    end

endmodule
