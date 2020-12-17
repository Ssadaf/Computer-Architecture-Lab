module exec_stage (
  input clk, 
  input [31:0] PC_in,
  input [3:0] exec_cmd, 
  input mem_write, mem_read, imm,
  input [31:0] val_Rn, val_Rm,
  input [11:0] shift_operand,
  input [23:0] signed_imm_24,
  input C_in,
  input [1:0] sel_src1, sel_src2,
  input [31:0] MEM_wb_val, WB_wb_val,

  output[31:0] PC_out,
  output [31:0] ALU_res, branch_addr,
  output C_out, V, Z, N,
  output [31:0] val_Rm_out

);

wire [31:0] val2;
wire load_store;
wire [31:0] extended_signed_im;
reg [31:0] src1_mux_out, src2_mux_out;

assign PC_out = PC_in;
assign load_store = mem_write || mem_read;
assign extended_signed_im = {{8{signed_imm_24[23]}}, signed_imm_24} << 2;
assign val_Rm_out = src2_mux_out;

always @(*) begin
  case(sel_src1)
    2'b00: src1_mux_out <= val_Rn;
    2'b01: src1_mux_out <= MEM_wb_val;
    2'b10: src1_mux_out <= WB_wb_val;
    default: src1_mux_out <= val_Rn;
  endcase
end

always @(*) begin
  case(sel_src2)
    2'b00: src2_mux_out <= val_Rm;
    2'b01: src2_mux_out <= MEM_wb_val;
    2'b10: src2_mux_out <= WB_wb_val;
    default: src2_mux_out <= val_Rm;
  endcase
end

val2_generator val2_gen(
  src2_mux_out,
  shift_operand,
  imm, load_store,
  val2
);

ALU alu( 
	src1_mux_out, val2,
	exec_cmd,
	C_in,
	ALU_res,
	C_out, V, Z, N
);

assign branch_addr = PC_in + extended_signed_im;

endmodule
