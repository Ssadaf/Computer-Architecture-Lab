module exec_stage (
  input clk, 
  input [31:0] PC_in,
  input [3:0] exec_cmd, 
  input mem_write, mem_read, imm,
  input [31:0] val_Rn, val_Rm,
  input [11:0] shift_operand,
  input [23:0] signed_imm_24,
  input [3:0] status_in,

  output[31:0] PC_out,
  output [31:0] ALU_res, branch_addr,
  output [3:0] ALU_status
);

assign   PC_out = PC_in;

endmodule
