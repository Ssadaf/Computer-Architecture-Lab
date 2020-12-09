module memory(
  input clk, mem_read, mem_write,
  input [31:0] address, data_write,
  output reg [31:0] data_read
);

  reg [31:0] mem [0:63]; // 64K???
  
  always@(*)begin
    if(mem_read)
      data_read <= mem[(address-1024)>>2];
    else
      data_read <= 0;
  end
  
  always@(posedge clk)begin
    if(mem_write)begin
        mem[(address-1024)>>2] <= data_write;
    end
  end
    

endmodule
