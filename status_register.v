module status_register(
	input clk, rst, C_in, V_in, Z_in, N_in, S,

	output C_out, V_out, Z_out, N_out
);

	reg C, V, Z, N;

	always @(negedge clk, posedge rst) begin
		if(rst) begin
		 {C,V,Z,N} <= 4'b0;
		end
		else if(S) begin //TEST
			C <= C_in;	
			V <= V_in;	
			Z <= Z_in;	
			N <= N_in;	
		end
	end

	assign C_out = C;	
	assign V_out = V;	
	assign Z_out = Z;	
	assign N_out = N;
endmodule