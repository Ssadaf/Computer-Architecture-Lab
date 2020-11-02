`timescale 1ns/1ns
module TB();
  reg clk = 1'b0, rst = 1'b1;
  ARM processor(clk, rst);
  initial begin
    #10 rst = ~rst;
  end 
  initial repeat(50)begin
    #20 clk = ~clk;
  end
endmodule
