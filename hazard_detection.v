module hazard_detection_unit (
  input [3:0] src1, src2, exec_dest, mem_dest,
  input exec_wb_enable, mem_wb_enable, two_src,
  output reg hazard
);

  always@(*)begin
    if (
      (exec_wb_enable && exec_dest==src1) ||
      (exec_wb_enable && exec_dest==src2 && two_src) ||
      (mem_wb_enable && mem_dest==src1) ||
      (mem_wb_enable && mem_dest==src2 && two_src)
      ) 
    begin
        hazard <= 1; // CHANGE BACK TO 1
    end
    else begin
      hazard <= 0;
    end
  end

endmodule
