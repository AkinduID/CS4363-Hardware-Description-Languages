/**
Author: Ramesh Fernando
Date: 2024/09/23
**/
module ALU_tb();
  // input and output signals for the DUT
  reg [7:0] A, M;   // 8-bit input A and M
  reg [2:0] ALU_OP; // 3-bit input ALU_OP to select the operation
  wire [7:0] X; // 8-bit output result
  // instantiate the DUT
  ALU DUT (A, M, ALU_OP, X);
  // initial block for generating input stimuli and output checking
  initial begin
    // Apply input stimuli
    A = 8'b11110000;
    M = 8'b00001111;
    #10 ALU_OP = 3'b001;
    // check the output for A+M operation
    if(X == 8'b11111111)
      $display("Test Passed for A+M");
    else
      $display("Test Failed for A+M");
    #10 ALU_OP = 3'b010;
    // check the output for A-M operation
    if(X == 8'b11111111)
      $display("Test Passed for A-M");
    else
      $display("Test Failed for A-M");
    #10 ALU_OP = 3'b011;
    // check the output for M-A operation
    if(X == 8'b00000000)
      $display("Test Passed for M-A");
    else
      $display("Test Failed for M-A");
    #10 ALU_OP = 3'b100;
    // check the output for -(A+M) operation
    if(X == 8'b00000000)
      $display("Test Passed for -(A+M)");
    else
      $display("Test Failed for -(A+M)");
    #10 ALU_OP = 3'b101;
    // check the output for A and M operation
    if(X == 8'b00001111)
      $display("Test Passed for A and M");
    else
      $display("Test Failed for A and M");
    #10 ALU_OP = 3'b110;
    // check the output for A or M operation
    if(X == 8'b11111111)
      $display("Test Passed for A or M");
    else
      $display("Test Failed for A or M");
    #10 ALU_OP = 3'b111;
    // check the output for A xor M operation
    if(X == 8'b11110000)
      $display("Test Passed for A xor M");
    else
      $display("Test Failed for A xor M");
   #10
      $finish;
  end
endmodule
