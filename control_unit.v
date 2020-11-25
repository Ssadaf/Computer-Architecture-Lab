module control_unit(
  input [1:0] mode,
  input [3:0] opcode,
  input S_in,
  output reg [3:0] exec_command,
  output mem_read, mem_write,
  wb_enable, I, B, reg S_out
);
  
  assign B = (mode == 2'b10); //B
  assign mem_read = (mode == 2'b01 && S_in==1); //LDR
  assign mem_write = (mode == 2'b01 && S_in==0); //STR
  assign wb_enable = !(opcode==4'b1010) && !(opcode==4'b1000) && !(mode==2'b10) && !(mode==2'b01 && S_in==0);
  assign imm = I;
  
  always@(*)begin
    if(mode==2'b00)
      S_out <= S_in;
    else
      S_out <= 0;
  end
  
  always@(*)begin
    case (opcode)
      4'b1101  : exec_command <= 4'b0001; //MOV
      4'b1111  : exec_command <= 4'b1001; //MVN
      4'b0100  : exec_command <= 4'b0010; //ADD
      4'b0101  : exec_command <= 4'b0011; //ADC
      4'b0010  : exec_command <= 4'b0100; //SUB
      4'b0110  : exec_command <= 4'b0101; //SBC
      4'b0000  : exec_command <= 4'b0110; //AND
      4'b1100  : exec_command <= 4'b0111; //ORR
      4'b0001  : exec_command <= 4'b1000; //EOR
      4'b1010  : exec_command <= 4'b0100; //CMP
      4'b1000  : exec_command <= 4'b0110; //TST
      4'b0100  : exec_command <= 4'b0010; //LDR,STR
      default : exec_command <= 4'b1111; //B
    endcase
  end

endmodule