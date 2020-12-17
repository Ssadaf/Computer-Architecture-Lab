`timescale 1ns/1ns
module TB();
  reg clk = 1'b0, rst = 1'b1, forwarding = 1'b0;
  ARM processor(clk, rst, forwarding);
  initial begin
    #10 rst = ~rst;
  end 
  initial repeat(700)begin
    #20 clk = ~clk;
  end
endmodule
