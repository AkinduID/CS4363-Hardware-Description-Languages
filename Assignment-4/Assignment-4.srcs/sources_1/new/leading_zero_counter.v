`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2025 08:42:57 PM
// Design Name: 
// Module Name: leading_one_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module leading_zero_counter ( 
  input [15:0] in, 
  output reg [4:0] out); 
  integer i; 
  always @(*) begin: count 
    out = 0; 
    i = 15; 
    while (i >= 0 && ~in[i]) begin 
      out = out + 1; 
      i = i - 1; 
    end 
  end 
endmodule
