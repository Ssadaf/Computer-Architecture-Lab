module register_file(
  input clk, rst,
  input [3:0] src1, src2, dest_wb,
  input[31:0] result_wb,
  input wb_en,
  output [31:0] reg1, reg2
);
  reg [31:0] reg_file [0:14];
  
  integer index;
  initial begin
		for(index = 0; index < 15; index = index + 1) begin
      reg_file[index] = index;
    end
	end
  
  assign reg1 = reg_file[src1];
  assign reg2 = reg_file[src2];
  
  always@(negedge clk)begin
    if(wb_en)begin
        reg_file[dest_wb] <= result_wb;
    end
  end
  
endmodule