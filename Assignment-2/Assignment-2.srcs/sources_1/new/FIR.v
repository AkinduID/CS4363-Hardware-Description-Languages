`timescale 1ns / 1ps
module fir_filter #(
parameter N = 25
)(
input clk,
input reset,
input signed [15:0] x_in,
output reg signed [31:0] y_out
);
reg signed [15:0] coeffs [0:N-1];
initial begin
coeffs[0] = 621; coeffs[1] = 1252; coeffs[2] = 955; coeffs[3] = -464;
coeffs[4] = -1427;
coeffs[5] = -442; coeffs[6] = 1279; coeffs[7] = 815; coeffs[8] =
-2028; coeffs[9] = -2978;
coeffs[10] = 1849; coeffs[11] = 9985; coeffs[12] = 14052; coeffs[13]
= 9985; coeffs[14] = 1849;
coeffs[15] = -2978; coeffs[16] = -2028; coeffs[17] = 815; coeffs[18]
= 1279; coeffs[19] = -442;
coeffs[20] = -1427; coeffs[21] = -464; coeffs[22] = 955; coeffs[23] =
1252; coeffs[24] = 621;
end
reg signed [15:0] shift_reg [0:N-1];
reg signed [31:0] sum;
integer i;
always @(posedge clk) begin
if (reset) begin
for (i = 0; i < N; i = i+1)
shift_reg[i] <= 0;
y_out <= 0;
end else begin
shift_reg[0] <= x_in;
for (i = 1; i < N; i = i+1)
shift_reg[i] <= shift_reg[i-1];
sum = 0;
for (i = 0; i < N; i = i+1)
sum = sum + coeffs[i] * shift_reg[i];
y_out <= sum;
end
end
endmodule
