//instruction memory
module im( a , spo )                           ;

  input           [11:2]           a            ;
  output          [31:0]           spo            ;

  reg             [31:0]           ROM[255:0]     ;

  assign    spo    =              ROM[a]    ; // word aligned
/*
always @(a) begin
  $display("PC = 0x%3X,  instr = 0x%8X,   line=%3d", a, spo,a/4+1); // used for debug
end
*/
  
endmodule  
