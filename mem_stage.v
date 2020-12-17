module mem_stage (
  input clk, rst,
  input [31:0] PC_in, ALU_result, val_Rm,
  input mem_read, mem_write,
  output [31:0] PC_out, mem_result,
  output reg [31:0] wb_result
);
  
  always @(*) begin
    if(mem_read)begin
      wb_result <= mem_result;
    end
    else begin
      wb_result <= ALU_result;
    end
  end
  
  assign PC_out = PC_in;
  memory mem(clk, mem_read, mem_write, ALU_result, val_Rm, mem_result);
  
endmodule
