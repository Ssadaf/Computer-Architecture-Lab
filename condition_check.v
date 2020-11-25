module condition_check (
  input Z, N, C, V,
  input [3:0] cond,
  output reg matched
);
	always @* begin
		case(cond)
			4'b0000: matched <= Z; //EQ
			4'b0001: matched <= !Z; // NE
			4'b0010: matched <= C; // CS
			4'b0011: matched <= !C; //CC
			4'b0100: matched <= N; // MI
			4'b0101: matched <= !N; // PL
			4'b0110: matched <= V; // VS
			4'b0111: matched <= !V; //VC
			4'b1000: matched <= C && (!Z); //HI
			4'b1001: matched <= (!C) && Z; // LS
			4'b1010: matched <= (N == V); // GE
			4'b1011: matched <= (N != V); // LT
			4'b1100: matched <= (!Z) && (N == V); //GT
			4'b1101: matched <= Z || (N != V); // LE
			4'b1110: matched <= 1; //AL
			default: matched <= 0;
		endcase
	end


endmodule

