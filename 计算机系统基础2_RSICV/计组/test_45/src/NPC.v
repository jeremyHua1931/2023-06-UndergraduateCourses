//next pc
module NPC(PC, NPCOp , NPC , inst , aluout )                                                     ;  
    
   input           [ 1:0]      NPCOp                                                             ;     // next pc operation
   input           [31:0]      PC                                                                ;        // pc  
   input           [31:0]      inst                                                              ;
   input           [31:0]      aluout                                                            ;
   output   reg    [31:0]      NPC                                                               ;   // next pc
   
   wire            [31:0]      PCPLUS4                                                           ;
   
   assign  PCPLUS4   =    PC + 4                                                                 ; // pc + 4 
  
   // NPC_PLUS4   2'b00
   // NPC_BRANCH  2'b01
   // NPC_Jal    2'b10
   //NPC_jalr     2'b11
   
   always @(*) begin
      case (NPCOp)
          2'b00 :  NPC   =    PCPLUS4                                                            ;
          2'b01 :  NPC   =    PC+ {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0}           ;  
          2'b10 :  NPC   =    PC+ {{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0}         ;
          2'b11 :  NPC   =    {aluout[31:1],1'b0}                                                ;
      endcase
   end // end always   
endmodule
