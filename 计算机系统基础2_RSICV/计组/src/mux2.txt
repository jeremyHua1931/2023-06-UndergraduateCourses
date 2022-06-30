//mux for register_write_selection
module mux2( mux_in1 , mux_in2 , PC , MemtoReg , WD  )                        ;
 
 input        [31:0]       mux_in1                                            ;  //aluout
 input        [31:0]       mux_in2                                            ;  //readdata
 input        [31:0]       PC                                                 ;
 input        [ 3:0]       MemtoReg                                           ;  //WDSel
     
 output reg   [31:0]       WD                                                 ;  //WD writedata to rd

 always @(*)begin
      case(MemtoReg)
         4'b0000   :       WD     <=    mux_in1                               ;  //aluout
         4'b0001   :       WD     <=    mux_in2                               ;  //i_lw 4 byte
         4'b0010   :       WD     <=    PC+mux_in1                            ;  //auipc=pc+aluout
         4'b0100   :       WD     <=    PC+4                                  ;  //jar,jalr
         4'b1000   :       WD     <=    {{24{mux_in2[7]}},mux_in2[7:0]}       ;  //i_lb 1 byte
         4'b1001   :       WD     <=    {{16{mux_in2[15]}},mux_in2[15:0]}     ;  //i_lh 2 byte
         4'b1010   :       WD     <=    {24'h000000,mux_in2[7:0]}             ;  //i_lbu 1 byte
         4'b1100   :       WD     <=    {16'h0000,mux_in2[15:0]}              ;  //i_lhu 2 byte
         default    :       WD     <=    32'b0                                ;
      endcase
 end
endmodule

// memory to register
  //0000    aluout     
  //0001    readdata-lw    i_lw
  //0010    pc+aluout      auipc
  //0100    pc+4           jal,jalr
  //1000    readdata-lb    i_lb
 
  //1001    readdata-lh    i_lh
  //1010    readdata-lbu   i_lbu
  //1100    readdata-lhu   i_lhu
