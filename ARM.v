module ARM (
  input clk, rst
);

wire hazard;


wire [31:0] PC_IF_out, PC_ID_in, PC_ID_out, PC_exec_in, PC_exec_out, PC_mem_in, PC_mem_out, PC_WB_in, PC_WB_out;
wire [31:0] inst_IF, inst_ID;

// WB outputs
wire [31:0] wb_result_WB_out;

wire wb_enable_ID_out, mem_read_ID_out, mem_write_ID_out, B_ID_out, S_ID_out, imm_ID_out;
wire [3:0] exec_cmd_ID_out, Rd_ID_out;
wire [31:0] val_Rn_ID_out, val_Rm_ID_out;
wire [11:0] shift_operand_ID_out;
wire [23:0] signed_imm_24_ID_out;
wire [3:0] src1_ID_out, src2_ID_out;
wire two_src_ID_out;

wire Z, N, C, V;

wire wb_enable_exec_in, mem_read_exec_in, mem_write_exec_in, B_exec_in, S_exec_in, imm_exec_in, C_exec_in;
wire [3:0] exec_cmd_exec_in, Rd_exec_in;
wire [31:0] val_Rn_exec_in, val_Rm_exec_in;
wire [11:0] shift_operand_exec_in;
wire [23:0] signed_imm_24_exec_in;

wire C_exec_out, V_exec_out, Z_exec_out, N_exec_out;
wire [31:0] ALU_res_exec_out, branch_addr_exec_out;

wire mem_read_wb_in, wb_enable_wb_in;
wire [3:0] wb_dest_wb_in;
wire [31:0] ALU_result_wb_in, mem_result_wb_in;

wire [3:0] Rd_mem_in;
wire wb_enable_mem_in;
wire [31:0] mem_result_mem_out;

IF_stage IF(clk, rst, hazard, B_exec_in, branch_addr_exec_out, PC_IF_out, inst_IF);
IF_stage_reg IF_reg(clk, rst, hazard, B_exec_in, PC_IF_out, inst_IF, PC_ID_in, inst_ID);

status_register sr(
clk, C_exec_out, V_exec_out, Z_exec_out, N_exec_out, 
S_exec_in,
C, V, Z, N);

ID_stage ID(clk, rst, PC_ID_in, inst_ID, wb_result_WB_out, wb_enable_wb_in, wb_dest_wb_in, hazard, Z, N, C, V,
PC_ID_out, wb_enable_ID_out, mem_read_ID_out, mem_write_ID_out, B_ID_out, S_ID_out, imm_ID_out,
exec_cmd_ID_out, val_Rn_ID_out, val_Rm_ID_out, Rd_ID_out, shift_operand_ID_out, signed_imm_24_ID_out,
src1_ID_out, src2_ID_out, two_src_ID_out);

ID_stage_reg ID_reg(clk, rst, B_exec_in, PC_ID_out, wb_enable_ID_out, mem_read_ID_out,
mem_write_ID_out, B_ID_out, S_ID_out, imm_ID_out, exec_cmd_ID_out, val_Rn_ID_out,val_Rm_ID_out,
Rd_ID_out, shift_operand_ID_out, signed_imm_24_ID_out, C,
PC_exec_in, wb_enable_exec_in, mem_read_exec_in, mem_write_exec_in, B_exec_in, S_exec_in,
imm_exec_in, exec_cmd_exec_in, Rd_exec_in, val_Rn_exec_in, val_Rm_exec_in,
shift_operand_exec_in, signed_imm_24_exec_in, C_exec_in);


exec_stage exec(
clk, PC_exec_in, exec_cmd_exec_in, 
mem_write_exec_in, mem_read_exec_in, imm_exec_in,
val_Rn_exec_in, val_Rm_exec_in,
shift_operand_exec_in,
signed_imm_24_exec_in,
C_exec_in,
PC_exec_out, 
ALU_res_exec_out, branch_addr_exec_out, 
C_exec_out, V_exec_out, Z_exec_out, N_exec_out);

exec_stage_reg exec_reg(clk, rst, PC_exec_out, 
wb_enable_exec_in, mem_read_exec_in, mem_write_exec_in,
ALU_res_exec_out, val_Rm_exec_in, Rd_exec_in,
PC_mem_in,
wb_enable_mem_in, mem_read_mem_in, mem_write_mem_in,
ALU_res_mem_in, val_Rm_mem_in, Rd_mem_in);

mem_stage mem(clk, rst, PC_mem_in, ALU_res_mem_in, val_Rm_mem_in, mem_read_mem_in, mem_write_mem_in,
PC_mem_out, mem_result_mem_out);

mem_stage_reg mem_reg(clk, rst, PC_mem_out, mem_read_mem_in, wb_enable_mem_in, Rd_mem_in, 
ALU_res_mem_in, mem_result_mem_out,
PC_WB_in, mem_read_wb_in, wb_enable_wb_in, wb_dest_wb_in, ALU_result_wb_in, mem_result_wb_in);

WB_stage WB(clk, rst, PC_WB_in, mem_read_wb_in, mem_result_wb_in, ALU_result_wb_in, PC_WB_out, wb_result_WB_out);

hazard_detection_unit hazard_detect(src1_ID_out, src2_ID_out, Rd_exec_in, Rd_mem_in, 
wb_enable_exec_in, wb_enable_mem_in, two_src_ID_out, hazard);

endmodule
