module button_debouncer (
    input clk,
    input nrst,
    input noisy_btn_in,
    output reg debounced_btn_out
);

// przycisk musi być stabilny przez ~10 ms, przy zegarze 100 MHz, 10 ms = 1 000 000 taktów zegara
reg [19:0] counter; // 20-bit counter for debouncing for 10 ms at 100 MHz
reg btn_state; // Current state of the button

always @(posedge clk or negedge nrst) begin
    if (!nrst) begin
        counter <= 0; // Reset counter on reset
        btn_state <= 0; // Reset button state on reset
        debounced_btn_out <= 0; // Reset debounced output on reset
    end else begin
        if (noisy_btn_in == btn_state) begin
            counter <= 0;
        end else begin
            // If the button state is different, start incrementing the counter
            counter <= counter + 1;
            if (counter == 1000000) begin // If the button has been in the new state for 10 ms
                btn_state <= noisy_btn_in; // Update the stable button state
                debounced_btn_out <= noisy_btn_in; // Update the debounced output
                counter <= 0; // After all, reset the counter
            end
        end
    end
end
    
endmodule
