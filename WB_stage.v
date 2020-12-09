module WB_stage (
  input clk, rst, 
  input [31:0] PC_in, 
  input mem_read,
  input [31:0] mem_res, alu_res,

  output [31:0] PC_out,
  output reg [31:0] wb_val
);

  assign PC_out = PC_in;

  always @(*)begin
	  if(mem_read)
	  	wb_val <= mem_res;
	  else
	  	wb_val <= alu_res;
  end

endmodule
