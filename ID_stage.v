module ID_stage (
  input clk, rst, 
  input [31:0] PC_in,
  input [31:0] instruction, 
  input [31:0] result_wb, 
  input write_back,
  input [3:0] dest_wb,
  input hazard, 
  input Z, N, C,V,	

  output [31:0] PC_out,
  output wb_enable,
  output reg mem_read, mem_write, B, S, imm,
  output reg [3:0] exec_cmd,
  output [31:0] val_Rn, val_Rm,
  output [3:0] Rd,
  output [11:0] shift_operand,
  output [23:0] signed_imm_24,
  output [3:0] src1, src2,
  output two_src 
);
	wire [3:0] cu_exec_cmd;
	reg [3:0] src2_mux_out;
	wire cu_mem_read, cu_mem_write, cu_wb_enable, cu_imm, cu_B, cu_S, cond_matched; 
	reg wb_enable_mux_out;

	assign PC_out = PC_in;
	
	assign src1 = instruction[19:16];
	assign src2 = src2_mux_out;
	assign two_src = cu_mem_write || !cu_imm;
	
	control_unit cu(instruction[27:26], instruction[24:21], instruction[20], instruction[25],
	cu_exec_cmd, cu_mem_read, cu_mem_write, cu_wb_enable, cu_imm, cu_B, cu_S);
	
	condition_check cc(Z, N, C,V, instruction[31:28], cond_matched);

	// MUX
	always @(*) begin
		if(hazard || !cond_matched) begin
			{wb_enable_mux_out, mem_read, mem_write, exec_cmd, B, S, imm} <= 10'b0;
		end

		else begin
			{wb_enable_mux_out, mem_read, mem_write, exec_cmd, B, S, imm} <= {cu_wb_enable, cu_mem_read, cu_mem_write, cu_exec_cmd, cu_B, cu_S, cu_imm};
		end
	end

	// MUX
	always @(*) begin
		if(wb_enable_mux_out) begin //TEST
			src2_mux_out <= instruction[15:12];
		end

		else begin
			src2_mux_out <= instruction[19:16];
		end
	end

	register_file rf(clk, rst, instruction[19:16], src2_mux_out, dest_wb, result_wb, write_back, val_Rn, val_Rm);

	assign signed_imm_24 = instruction[23:0];
	assign Rd = instruction[15:12];
	assign shift_operand = instruction[11:0];
	assign wb_enable = wb_enable_mux_out;

endmodule