//next pc
module NPC(PC, NPCOp , NPC , inst , aluout,clk,PC_0 )                                                     ;  
    
   input clk;
   input           [31:0]      PC_0         ; 
   input           [31:0]      inst         ;
   input           [31:0]      aluout       ;
   
   input           [ 1:0]      NPCOp        ;     // next pc operation
   input           [31:0]      PC           ;        // pc 
   output   reg    [31:0]      NPC          ;   // next pc
   
   
   // NPC_PLUS4   2'b00
   // NPC_BRANCH  2'b01
   // NPC_Jal    2'b10
   //NPC_jalr     2'b11

   always @(*) begin
      if(NPCOp==2'b01)
         NPC   =    PC_0+ {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0}  ;
      else if(NPCOp==2'b10)
         NPC   =    PC_0+ {{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0}      ;
      else if(NPCOp==2'b11)
         NPC   =    aluout[31:0] ;
      else
         NPC =PC+4;
   end
 
endmodule
