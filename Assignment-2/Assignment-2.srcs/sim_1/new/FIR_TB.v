`timescale 1ns / 1ps
module fir_sim;
reg clk, reset;
reg signed [15:0] x_in;
wire signed [31:0] y_out;
// DUT instantiation
fir_filter dut (
.clk(clk),
.reset(reset),
.x_in(x_in),
.y_out(y_out)
);
// Clock generation: 100 MHz (10 ns period)
always #5 clk = ~clk;
initial begin
// Initialize
clk = 0;
reset = 1;
x_in = 0;
// Reset pulse
#20 reset = 0;
// Apply impulse input
x_in = 16'sd1; #10; // impulse at t=20ns
x_in = 16'sd0; #500; // then zeros for 50 cycles
$stop; // End simulation
end
endmodule
