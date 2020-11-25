module condition_check (
  input Z, N, C, V,
  input [3:0] cond,
  output reg matched
);
	always @* begin
		case(cond)
			4'b0000: matched <= Z;
			4'b0001: matched <= !Z;
			4'b0010: matched <= C;
			4'b0011: matched <= !C;
			4'b0100: matched <= N;
			4'b0101: matched <= !N;
			4'b0110: matched <= V;
			4'b0111: matched <= !V;
			4'b1000: matched <= C && (!Z);
			4'b1001: matched <= (!C) && Z;
			4'b1010: matched <= (N == V);
			4'b1011: matched <= (N != V);
			4'b1100: matched <= (!Z) && (N == V);
			4'b1101: matched <= Z || (N != V);
			4'b1110: matched <= 1;
			default: matched <= 0;
		endcase
	end


endmodule

