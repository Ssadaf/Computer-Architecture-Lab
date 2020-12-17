module forwarding_unit (
  input forwarding,
  input [3:0] src1, src2,
  input MEM_wb_en, WB_wb_en,
  input [3:0] MEM_wb_dest, WB_wb_dest,
  output reg [1:0] sel_src1, sel_src2
);

	always @(*) begin
		if(~forwarding)begin
			sel_src1 <= 2'b00;
		end

		else begin
			if(MEM_wb_en && (MEM_wb_dest==src1))begin
				sel_src1 <= 2'b01;
			end
			else if(WB_wb_en && (WB_wb_dest==src1))begin
				sel_src1 <= 2'b10;
			end
			else begin
				sel_src1 <= 2'b00;
			end
		end
	end

	always @(*) begin
		if(~forwarding)begin
			sel_src2 <= 2'b00;
		end

		else begin
			if(MEM_wb_en && (MEM_wb_dest==src2))begin
				sel_src2 <= 2'b01;
			end
			else if(WB_wb_en && (WB_wb_dest==src2))begin
				sel_src2 <= 2'b10;
			end
			else begin
				sel_src2 <= 2'b00;
			end
		end
	end

endmodule
