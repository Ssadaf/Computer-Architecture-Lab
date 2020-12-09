module mem_stage_reg(
  input clk, rst,
  input [31:0] PC_in,
  input mem_read_in, wb_enable_in,
  input [3:0] wb_dest_in,
  input [31:0] ALU_result_in, mem_result_in,
  
  output reg [31:0] PC_out,
  output reg mem_read_out, wb_enable_out,
  output reg [3:0] wb_dest_out,
  output reg [31:0] ALU_result_out, mem_result_out
);

  always@(posedge clk, posedge rst) begin
    if(rst) begin
      PC_out <= 32'b0;
      {mem_read_out, wb_enable_out, wb_dest_out, ALU_result_out, mem_result_out} <= 0;
    end
    else begin
      PC_out <= PC_in;
      {mem_read_out, wb_enable_out, wb_dest_out, ALU_result_out, mem_result_out} <= 
          {mem_read_in, wb_enable_in, wb_dest_in, ALU_result_in, mem_result_in};
    end
  end
  
endmodule

