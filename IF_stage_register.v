module IF_stage_register(
  input clk, rst, freeze, flush, 
  input [31:0] PC_in, Instruction_in, 
  output reg [31:0] PC_out, Instruction_out
);
  always@(posedge clk, posedge rst) begin
    if(rst) begin 
      PC_out <= 32'b0;
      Instruction_out <= 32'b0;
    end
    else if(flush) begin 
      PC_out <= 32'b0;
      Instruction_out <= 32'b0;
    end
    else if(!freeze) begin 
      PC_out <= PC_in;
      Instruction_out <= Instruction_in;  
    end 
  end
endmodule  
