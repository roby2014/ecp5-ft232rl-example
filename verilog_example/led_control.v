module led_control (
  input clk,
  input enable,
  output led
);
  always @(posedge clk) begin
    if (enable) begin
      led <= 1'b1;
    end else begin
      led <= 1'b0;
    end
  end
endmodule