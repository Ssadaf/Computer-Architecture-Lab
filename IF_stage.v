module IF_stage (
  input clk, rst, freeze, branch_taken, 
  input [31:0] branch_addr,
  output [31:0] PC_out, instruction
);
  reg [31:0] PC;
  reg [31:0] inst_mem [0:6];
  
  initial begin
		PC = 32'b0;
		inst_mem[0] = 32'b00000000001000100000000000000000;
		inst_mem[1] = 32'b00000000011001000000000000000000;
		inst_mem[2] = 32'b00000000101001100000000000000000;
		inst_mem[3] = 32'b00000000111010000001000000000000;
		inst_mem[4] = 32'b00000001001010100001100000000000;
		inst_mem[5] = 32'b00000001011011000000000000000000;
		inst_mem[6] = 32'b00000001101011100000000000000000;		
	end
  
  always@(posedge clk, posedge rst)begin
    if(rst)
      PC <= 32'b0;
    else if(!freeze)begin
      if(branch_taken)
        PC <= branch_addr;
      else
        PC <= PC+4;
    end
  end
  
 	assign instruction = inst_mem[PC>>2];
  assign PC_out = PC+4;
  
endmodule