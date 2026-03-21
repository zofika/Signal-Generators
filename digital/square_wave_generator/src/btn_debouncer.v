module btn_debouncer (
    input clk,
    input noisy_btn_in,
    output reg debounced_btn_out
);

// przycisk musi być stabilny przez ~10 ms, przy zegarze 100 MHz, 10 ms = 1 000 000 taktów zegara
reg [19:0] counter; // 20-bit counter for debouncing for 10 ms at 100 MHz
reg btn_state; // Current state of the button

initial begin
    counter = 0; // Initialize counter to 0
    btn_state = 0; // Initialize button state to 0
    debounced_btn_out = 0; // Initialize debounced output to 0
end

always @(posedge clk) begin
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
    
endmodule
