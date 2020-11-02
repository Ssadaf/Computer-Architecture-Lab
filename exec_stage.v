module exec_stage (
  input clk, rst, 
  input [31:0] PC_in, 
  output [31:0] PC_out
);
  always@(PC_in) begin 
    PC_out = PC_in;
  end
endmodule
