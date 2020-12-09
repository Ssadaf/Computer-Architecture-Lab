module exec_stage_reg(
  	input clk, rst,
  	input [31:0] PC_in,
	input wb_enable_in, mem_read_in, mem_write_in,
	input [31:0] ALU_res_in, val_Rm_in,
	input [3:0 ] Rd_in,
  
  	output reg [31:0] PC_out,
  	output reg wb_enable_out, mem_read_out, mem_write_out,
	output reg [31:0] ALU_res_out, val_Rm_out,
	output reg [3:0 ] Rd_out
);
  always@(posedge clk, posedge rst) begin
    if(rst)begin
    	PC_out <= 32'b0;
    	{wb_enable_out, mem_read_out, mem_write_out} <= 3'b0;
    	{ALU_res_out, val_Rm_out} <= 64'b0;
    	Rd_out <= 4'b0;
    end
    else
      PC_out <= PC_in;
      wb_enable_out <= wb_enable_in;
      mem_read_out <= mem_read_in;
      mem_write_out <= mem_write_in;
      ALU_res_out <= ALU_res_in;
      val_Rm_out <= val_Rm_in;
      Rd_out <= Rd_in;
  end
endmodule