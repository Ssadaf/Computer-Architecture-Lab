module exec_stage (
  input clk, 
  input [31:0] PC_in,
  input [3:0] exec_cmd, 
  input mem_write, mem_read, imm,
  input [31:0] val_Rn, val_Rm,
  input [11:0] shift_operand,
  input [23:0] signed_imm_24,
  input C_in,

  output[31:0] PC_out,
  output [31:0] ALU_res, branch_addr,
  output C_out, V, Z, N
);

wire [31:0] val2;
wire load_store;
wire [31:0] extended_signed_im;

assign PC_out = PC_in;
assign load_store = mem_write || mem_read;
assign extended_signed_im = {{8{signed_imm_24[23]}}, signed_imm_24} << 2;

val2_generator val2_gen(
  val_Rm,
  shift_operand,
  imm, load_store,
  val2
);

ALU alu(
	val_Rn, val2,
	exec_cmd,
	C_in,
	ALU_res,
	C_out, V, Z, N
);

assign branch_addr = PC_in + extended_signed_im;

endmodule
