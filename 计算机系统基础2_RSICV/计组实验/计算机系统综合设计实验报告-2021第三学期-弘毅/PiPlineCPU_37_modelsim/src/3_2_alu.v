module alu( A , B , ALUOp , C , alu_signal )            ;
             
   input  signed [31:0]  A                                     ;
   input  signed [31:0]  B                                     ;
   input         [ 9:0]  ALUOp                                 ;
   output signed [31:0]  C                                     ;
  
   //output   zf            ;          //零标志
   //output   sf            ;          // 符号标志
   //output   cf            ;          // 进位标志
   //output   of            ;          // 溢出标志

   output  [3:0] alu_signal ;
    
   reg  [31:0]  C                                              ;
   wire [31:0]  unsigned_A = $unsigned(A)                      ;
   wire [31:0]  unsigned_B = $unsigned(B)                      ;
        
   always @(*) begin 
      case ( ALUOp )  
         10'b00_0000_0000 :  C = B                             ;          // NOP,cout_B
         10'b00_0000_0001 :  C = A + B                         ;          // add/addi     
         10'b00_0000_0010 :  C = A - B                         ;          // sub
         10'b00_0000_0100 :  C = A << {B[4:0]}                 ;          // sll/slli       
         10'b00_0000_1000 :  C = (A<B)? 1:0                    ;          // slt/slti
         10'b00_0001_0000 :  C = (unsigned_A<unsigned_B)? 1:0  ;          // sltu/sltiu
         10'b00_0010_0000 :  C = A ^ B                         ;          // xor/xori
         10'b00_0100_0000 :  C = A>>B                          ;          // srl/srli
         10'b00_1000_0000 :  C = ($signed(A))>>>B              ;          // sra/srali
         10'b01_0000_0000 :  C = A | B                         ;          // or/ori
         10'b10_0000_0000 :  C = A & B                         ;          // and/andi
         default          :  C = A                             ;                           
      endcase 
   end  
    
   assign alu_signal[0]  =   (C == 32'b0)                                 ;
   assign alu_signal[1]  =   (C<0)                                        ;          //符号位
   assign alu_signal[2]  =   (unsigned_A<unsigned_B)? 1:0                 ;          //为一即有进位，此时小于 
   assign alu_signal[3]  =   (A<0== B<0) && (C<0 == A<0)                  ;          // 溢出标志
                
endmodule
    