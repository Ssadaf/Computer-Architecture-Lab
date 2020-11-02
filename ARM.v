module ARM (
  input clk, rst
);

reg hazard = 1'b0;
reg branch_taken = 1'b0;
reg [31:0] branch_addr = 32'b0;

wire [31:0] PC_IF_out, PC_ID_in, PC_ID_out, PC_exec_in, PC_exec_out, PC_mem_in, PC_mem_out, PC_WB_in, PC_WB_out;
wire [31:0] inst_IF, inst_ID;

IF_stage IF(clk, rst, hazard, branch_taken, branch_addr, PC_IF_out, inst_IF);
IF_stage_reg IF_reg(clk, rst, hazard, branch_taken, PC_IF_out, inst_IF, PC_ID_in, inst_ID);

ID_stage ID(clk, rst, PC_ID_in, PC_ID_out);
ID_stage_reg ID_reg(clk, rst, branch_taken, PC_ID_out, PC_exec_in);

exec_stage exec(clk, rst, PC_exec_in, PC_exec_out);
exec_stage_reg exec_reg(clk, rst, PC_exec_out, PC_mem_in);

mem_stage mem(clk, rst, PC_mem_in, PC_mem_out);
mem_stage_reg mem_reg(clk, rst, PC_mem_out, PC_WB_in);

WB_stage WB(clk, rst, PC_WB_in, PC_WB_out);

endmodule
