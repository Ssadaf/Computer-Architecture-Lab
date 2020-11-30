module val2_generator(
  input [31:0] val_Rm,
  input [11:0] shift_operand,
  input imm, load_store,
  output reg [31:0] val2
);

  integer index;
  reg [31:0] imm_32bit = 0;
  
  always@(*)begin
    if(load_store) begin
      val2 = {{20{shift_operand[11]}},shift_operand};
    end
    else if (imm) begin
      imm_32bit = {24'b0, shift_operand[7:0]};
		  for(index = 0; index < 2*shift_operand[11:8]; index = index + 1) begin
        imm_32bit = {imm_32bit[0], imm_32bit[31:1]};
      end
	    val2 = imm_32bit;
	  end  
    else begin
      case (shift_operand[6:5])
        2'b00: val2 = val_Rm << shift_operand[11:7]; //LSL
        2'b01: val2 = val_Rm >> shift_operand[11:7]; //LSR
        2'b10: val2 = val_Rm >>> shift_operand[11:7]; //ASR
        2'b11: begin //ROR
          val2 = val_Rm;
		      for(index = 0; index < shift_operand[11:7]; index = index + 1) begin
            val2 = {val2[0], val2[31:1]};
          end   
        end
      endcase
    end
  end
  
endmodule



