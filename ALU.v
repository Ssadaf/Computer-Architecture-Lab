module ALU(
	input [31:0] val1, val2,
	input [3:0] exec_cmd,
	input C_in,

	output reg [31:0] ALU_res,
	output reg C_out, V,
	output Z, N
);

	always@(*)begin
    	case (exec_cmd)
	      	4'b0001  : begin //MOV
	      	ALU_res <= val2;
	      	{V, C_out} <= 0;
	      	end

	      	4'b1001  : begin //MVN
	      	ALU_res <= ~val2;
	      	{V, C_out} <= 0; 
	      	end

	      	4'b0010  : begin //ADD
	      	{C_out, ALU_res} <= val1 + val2;
	      	V <= (val1[31] & val2[31] & !ALU_res[31]) || (!val1[31] & !val2[31] & ALU_res[31]);
	      	end

	      	4'b0011  : begin //ADC
	      	{C_out, ALU_res} <= val1 + val2 + C_in;
	      	V <= (val1[31] & val2[31] & !ALU_res[31]) || (!val1[31] & !val2[31] & ALU_res[31]);
	      	end

	      	4'b0100  : begin //SUB
	      	{C_out, ALU_res} <= val1 - val2;
	      	V <= (!val1[31] & val2[31] & ALU_res[31]) || (val1[31] & !val2[31] & !ALU_res[31]);
	      	end

	      	4'b0101  : begin //SBC
	      	{C_out, ALU_res} <= val1 - val2 - 1;
			V <= (!val1[31] & val2[31] & ALU_res[31]) || (val1[31] & !val2[31] & !ALU_res[31]);
	      	end

	      	4'b0110  : begin //AND
	      	ALU_res <= val1 & val2;
	      	{V, C_out} <= 0;
	      	end

	      	4'b0111  : begin //ORR
	      	ALU_res <= val1 | val2;
	      	{V, C_out} <= 0;
	      	end

	     	4'b1000  : begin //EOR
	     	ALU_res <= val1 ^ val2;
	     	{V, C_out} <= 0;
	     	end

	      	4'b0100  : begin //CMP
	      	ALU_res <= val1 - val2;
	      	{V, C_out} <= 0;
	      	end

	      	4'b0110  : begin //TST
	      	ALU_res <= val1 & val2;
	      	{V, C_out} <= 0;
	      	end

	      	4'b0010  : begin //LDR,STR
	      	ALU_res <= val1 + val2;
	      	{V, C_out} <= 0;
	      	end

	     	default  : begin //B
			ALU_res <= 32'b0;
	     	{V, C_out} <= 0;
	     	end

    	endcase
	end

    assign N = ALU_res[31];
	assign Z = ~(|ALU_res);

endmodule  