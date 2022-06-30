//instruction memory
module im( addr , dout )                           ;

  input           [31:0]           addr            ;
  output          [31:0]           dout            ;

  reg             [31:0]           ROM[1023:0]     ;

  assign    dout    =              ROM[addr>>2]    ; // word aligned
endmodule  
