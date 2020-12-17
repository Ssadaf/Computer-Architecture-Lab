module IF_stage (
  input clk, rst, freeze, branch_taken, 
  input [31:0] branch_addr,
  output [31:0] PC_out, instruction
);
  reg [31:0] PC;
  reg [31:0] inst_mem [0:46];
  
  initial begin
		PC = 32'b0;		
		    
    inst_mem[0] = 32'b11100011101000000000000000010100;
    inst_mem[1] = 32'b11100011101000000001101000000001;
    inst_mem[2] = 32'b11100011101000000010000100000011;
    inst_mem[3] = 32'b11100000100100100011000000000010;
    inst_mem[4] = 32'b11100000101000000100000000000000;
    inst_mem[5] = 32'b11100000010001000101000100000100;
    inst_mem[6] = 32'b11100000110000000110000010100000;
    inst_mem[7] = 32'b11100001100001010111000101000010;
    inst_mem[8] = 32'b11100000000001111000000000000011;
    inst_mem[9] = 32'b11100001111000001001000000000110;
    inst_mem[10] = 32'b11100000001001001010000000000101;
    inst_mem[11] = 32'b11100001010110000000000000000110;
    inst_mem[12] = 32'b00010000100000010001000000000001;
    inst_mem[13] = 32'b11100001000110010000000000001000;
    inst_mem[14] = 32'b00000000100000100010000000000010;
    inst_mem[15] = 32'b11100011101000000000101100000001;
    inst_mem[16] = 32'b11100100100000000001000000000000;
    inst_mem[17] = 32'b11100100100100001011000000000000; //18
    inst_mem[18] = 32'b11100100100000000010000000000100;
    inst_mem[19] = 32'b11100100100000000011000000001000;
    inst_mem[20] = 32'b11100100100000000100000000001101;
    inst_mem[21] = 32'b11100100100000000101000000010000; //22
    inst_mem[22] = 32'b11100100100000000110000000010100;
    inst_mem[23] = 32'b11100100100100001010000000000100;
    inst_mem[24] = 32'b11100100100000000111000000011000; 
    inst_mem[25] = 32'b11100011101000000001000000000100; //26 
    inst_mem[26] = 32'b11100011101000000010000000000000;
    inst_mem[27] = 32'b11100011101000000011000000000000;
    inst_mem[28] = 32'b11100000100000000100000100000011; //29
    inst_mem[29] = 32'b11100100100101000101000000000000;
    inst_mem[30] = 32'b11100100100101000110000000000100;
    inst_mem[31] = 32'b11100001010101010000000000000110;
    inst_mem[32] = 32'b11000100100001000110000000000000; //33
    inst_mem[33] = 32'b11000100100001000101000000000100;
    inst_mem[34] = 32'b11100010100000110011000000000001;
    inst_mem[35] = 32'b11100011010100110000000000000011; //36
    inst_mem[36] = 32'b10111010111111111111111111110111;
    inst_mem[37] = 32'b11100010100000100010000000000001;
    inst_mem[38] = 32'b11100001010100100000000000000001;
    inst_mem[39] = 32'b10111010111111111111111111110011; //40
    inst_mem[40] = 32'b11100100100100000001000000000000;
    inst_mem[41] = 32'b11100100100100000010000000000100;
    inst_mem[42] = 32'b11100100100100000011000000001000; //43
    inst_mem[43] = 32'b11100100100100000100000000001100; //44
    inst_mem[44] = 32'b11100100100100000101000000010000;
    inst_mem[45] = 32'b11100100100100000110000000010100; 
    inst_mem[46] = 32'b11101010111111111111111111111111; //47
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