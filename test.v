`timescale 1ns/1ns
module test();
  reg [31:0] Rm = 5;
  reg [11:0] shift_operand = 12'b001110000101;
  reg imm = 0;
  reg load_store = 1;
  wire [31:0] val2;
  
  val2_generator val_gen(Rm, shift_operand, imm, load_store, val2);
  
  initial begin
    // load-store
    #50
    // 32-bit immediate
    imm = 1;
    load_store = 0;
    #50
    // immediate shift
    imm = 0;
    #50
    shift_operand[6:5] = 2'b01;
    #50
    shift_operand[6:5] = 2'b10;
    #50
    shift_operand[6:5] = 2'b11;
    #50
    shift_operand[6:5] = 2'b11;
  end 

endmodule

