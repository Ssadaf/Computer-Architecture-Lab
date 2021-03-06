module ID_stage_reg(
  input clk, rst, flush, 
  input [31:0] PC_in,
  input wb_enable_in, mem_read_in, mem_write_in, B_in, S_in, imm_in,
  input [3:0] exec_cmd_in,
  input [31:0] val_Rn_in, val_Rm_in,
  input [3:0] Rd_in,
  input [11:0] shift_operand_in,
  input [23:0] signed_imm_24_in,
  input C_in,
  input [3:0] src1_in, src2_in,
  
  output reg [31:0] PC_out,
  output reg wb_enable_out, mem_read_out, mem_write_out, B_out, S_out, imm_out,
  output reg [3:0] exec_cmd_out,
  output reg [31:0] val_Rn_out, val_Rm_out,
  output reg [3:0] Rd_out,
  output reg [11:0] shift_operand_out,
  output reg [23:0] signed_imm_24_out,
  output reg C_out,
  output reg [3:0] src1_out, src2_out
);
  always@(posedge clk, posedge rst) begin
    if(rst)begin
      PC_out <= 32'b0;
      {wb_enable_out, mem_read_out, mem_write_out, B_out, S_out, imm_out} <= 6'b0;
      {val_Rn_out, val_Rm_out, Rd_out} <= 68'b0;
      {exec_cmd_out, shift_operand_out, signed_imm_24_out, C_out} <= 42'b0;
      {src1_out, src2_out} <= 8'b0;
    end
    
    else if(flush) begin
      PC_out <= 32'b0;
      {wb_enable_out, mem_read_out, mem_write_out, B_out, S_out, imm_out} <= 6'b0;
      {val_Rn_out, val_Rm_out, Rd_out} <= 68'b0;
      {exec_cmd_out, shift_operand_out, signed_imm_24_out, C_out} <= 42'b0;
      {src1_out, src2_out} <= 8'b0;
    end
    
    else begin
      PC_out <= PC_in;
      wb_enable_out <= wb_enable_in;
      mem_read_out <= mem_read_in;
      mem_write_out <= mem_write_in;
      B_out <= B_in;
      S_out <= S_in;
      imm_out <= imm_in;
      exec_cmd_out <= exec_cmd_in;
      val_Rn_out <= val_Rn_in;
      val_Rm_out <= val_Rm_in;
      Rd_out <= Rd_in;
      shift_operand_out <= shift_operand_in;
      signed_imm_24_out <= signed_imm_24_in;
      C_out <= C_in;
      src1_out <= src1_in;
      src2_out <= src2_in;
    end
  end
endmodule  


