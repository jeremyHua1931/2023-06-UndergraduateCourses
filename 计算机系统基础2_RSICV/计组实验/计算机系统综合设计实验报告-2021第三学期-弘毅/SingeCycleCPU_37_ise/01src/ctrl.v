//ctrl 
module ctrl( Op , Funct7 , Funct3 , zf , sf , cf , of , RegWrite , MemWrite , EXTOp , ALUOp , NPCOp , ALUSrc , MemtoReg )                   ;
 
   input             zf                                                                                                                     ;
   input             sf                                                                                                                     ;
   input             cf                                                                                                                     ;
   input             of                                                                                                                     ;

   input    [2:0]    Funct3                                                                                                                 ;          
   input    [6:0]    Op                                                                                                                     ;   
   input    [6:0]    Funct7                                                                                                                 ;   
   
   
   output            ALUSrc                                                                                                                 ;    // ALU source for B
   output            RegWrite                                                                                                               ;    // control signal for register write
   output   [1:0]    NPCOp                                                                                                                  ;    // next pc operation
   output            MemWrite                                                                                                               ;    // control signal for memory write
   output   [3:0]    MemtoReg                                                                                                               ;    // 寄存器使用alu结果还是内存结果
   output   [5:0]    EXTOp                                                                                                                  ;    // control signal to signed extension
   output   [9:0]    ALUOp                                                                                                                  ;    // ALU opertion
   


   //指令解析

   wire   i_lui   =  ~Op[6]& Op[5]& Op[4]&~Op[3]& Op[2]& Op[1]& Op[0]                                                                       ;    // lui


   wire   auipc   =  ~Op[6]&~Op[5]& Op[4]&~Op[3]& Op[2]& Op[1]& Op[0]                                                                       ;    //auipc


   // j format 
   wire   jal     =   Op[6]& Op[5]&~Op[4]& Op[3]& Op[2]& Op[1]& Op[0]                                                                       ;    // jal
   wire   jalr    =   Op[6]& Op[5]&~Op[4]&~Op[3]& Op[2]& Op[1]& Op[0]& ~Funct3[2]&~Funct3[1]&~Funct3[0]                                     ;    //jlar


   // sb format
   wire   sbtype  =   Op[6]& Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0]                                                                       ;

   wire   i_beq   =   sbtype& ~Funct3[2]&~Funct3[1]&~Funct3[0]                                                                              ;    // beq
   wire   i_bne   =   sbtype& ~Funct3[2]&~Funct3[1]& Funct3[0]                                                                              ;    //bne
   wire   i_blt   =   sbtype&  Funct3[2]&~Funct3[1]&~Funct3[0]                                                                              ;    //blt
   wire   i_bge   =   sbtype&  Funct3[2]&~Funct3[1]& Funct3[0]                                                                              ;    //bge
   wire   i_bltu  =   sbtype&  Funct3[2]& Funct3[1]&~Funct3[0]                                                                              ;    //bltu
   wire   i_bgeu  =   sbtype&  Funct3[2]& Funct3[1]& Funct3[0]                                                                              ;    //bgeu


   // i format
   wire   ltype   =  ~Op[6]&~Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0]                                                                       ; 

   wire   i_lb    =   ltype & ~Funct3[2]&~Funct3[1]&~Funct3[0]                                                                              ;    // lb
   wire   i_lh    =   ltype & ~Funct3[2]&~Funct3[1]& Funct3[0]                                                                              ;    // lh
   wire   i_lw    =   ltype & ~Funct3[2]& Funct3[1]&~Funct3[0]                                                                              ;    // lw
                                                                    
   wire   i_lbu   =   ltype &  Funct3[2]&~Funct3[1]&~Funct3[0]                                                                              ;    // lw
   wire   i_lhu   =   ltype &  Funct3[2]&~Funct3[1]& Funct3[0]                                                                              ;    // lw
     

   // s format
   wire   stype   =  ~Op[6]& Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0]                                                                       ;

   wire   i_sb    =   stype & ~Funct3[2]&~Funct3[1]&~Funct3[0]                                                                              ;    // sb
   wire   i_sh    =   stype & ~Funct3[2]&~Funct3[1]& Funct3[0]                                                                              ;    // sh
   wire   i_sw    =   stype & ~Funct3[2]& Funct3[1]&~Funct3[0]                                                                              ;    // sw
 

   // i format(立即数)
   wire   itype   =  ~Op[6]&~Op[5]&Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]                                                                          ;
   wire   i_addi  =   itype & ~Funct3[2]&~Funct3[1]&~Funct3[0]                                                                              ;    // addi 
   wire   i_slti  =   itype & ~Funct3[2]& Funct3[1]&~Funct3[0]                                                                              ;    //sltu
   wire   i_sltiu =   itype & ~Funct3[2]& Funct3[1]& Funct3[0]                                                                              ;    //sltui
   wire   i_xori  =   itype &  Funct3[2]&~Funct3[1]&~Funct3[0]                                                                              ;    //xori
   wire   i_ori   =   itype &  Funct3[2]& Funct3[1]&~Funct3[0]                                                                              ;    // ori
   wire   i_andi  =   itype &  Funct3[2]& Funct3[1]& Funct3[0]                                                                              ;    // andi

   wire   i_slli  =   itype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& ~Funct3[2]&~Funct3[1]& Funct3[0] ;    // slli
   wire   i_srli  =   itype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&  Funct3[2]&~Funct3[1]& Funct3[0] ;    // srli
   wire   i_srai  =   itype& ~Funct7[6]& Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&  Funct3[2]&~Funct3[1]& Funct3[0] ;    // srai

  // r format
   wire   rtype   =  ~Op[6]&Op[5]&Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]; //0110011

   wire   r_add   =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& ~Funct3[2]&~Funct3[1]&~Funct3[0] ;    // add 
   wire   r_sub   =   rtype& ~Funct7[6]& Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& ~Funct3[2]&~Funct3[1]&~Funct3[0] ;    // sub
  
   wire   r_sll   =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& ~Funct3[2]&~Funct3[1]& Funct3[0] ;    //sll
   wire   r_slt   =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& ~Funct3[2]& Funct3[1]&~Funct3[0] ;    //slt
   wire   r_sltu  =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& ~Funct3[2]& Funct3[1]& Funct3[0] ;    //sltu
  
   wire   r_xor   =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&  Funct3[2]&~Funct3[1]&~Funct3[0] ;    //xor
   wire   r_srl   =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&  Funct3[2]&~Funct3[1]& Funct3[0] ;    //srl
   wire   r_sra   =   rtype& ~Funct7[6]& Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&  Funct3[2]&~Funct3[1]& Funct3[0] ;    //sra
  
   wire   r_or    =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&  Funct3[2]& Funct3[1]&~Funct3[0] ;    //or
   wire   r_and   =   rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&  Funct3[2]& Funct3[1]& Funct3[0] ;    // and   



   //信号控制
   // generate control signals 

   // register write
  assign RegWrite     =   i_lui | auipc | jal | jalr | ltype | itype | rtype                                                                ;

  // memory write
  //000  donothing
  //001  i_sw
  //010  i_sh
  //100  i_sb
  assign MemWrite =   i_sw;

  // memory to register
  //0000    aluout     
  //0001    readdata-lw    i_lw
  //0010    pc+aluout      auipc
  //0100    pc+4           jal,jalr
  //1000    readdata-lb    i_lb
 
  //1001    readdata-lh    i_lh
  //1010    readdata-lbu   i_lbu
  //1100    readdata-lhu   i_lhu
  assign MemtoReg[0]  =   i_lw   | i_lh                                                                                                     ;                     
  assign MemtoReg[1]  =   auipc  | i_lbu                                                                                                    ;                     
  assign MemtoReg[2]  =   jal    | jalr   | i_lhu                                                                                           ;                     
  assign MemtoReg[3]  =   i_lb   | i_lh   | i_lbu  | i_lhu                                                                                  ;                                      


                             

  // ALU B is from instruction immediate
  assign ALUSrc       =   i_lui  | auipc  | jal    | jalr   |  ltype  | stype  | itype | i_slli | i_srli | i_srai                            ;


  // signed extension

  //1-lui,    auipc                                                     000001         {inst[31:12],12'b0}                              
  //2-jal                                                               000010         {{20{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0} 
  //3-jalr,   lb,lh,lw,lbu,lwu,   addi,slti,sltiu,xori,ori,andi         000100         {{20{inst[31]}},inst[31:20]}
  //4-beq,bne,blt,bge,bltu,bgeu                                         001000         {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0} 
  //5-sb.sh,sw                                                          010000         {{20{inst[31]}},inst[31:25],inst[11:7]}                                                    
  //6-slli,srli,srai                                                    100000         {{27{inst[31]}},inst[24:20]}

  assign EXTOp[0]    =    i_lui  | auipc                                                                                                    ;
  assign EXTOp[1]    =    jal                                                                                                               ;
  assign EXTOp[2]    =    jalr   | ltype  | i_addi | i_slti | i_slti  | i_sltiu | i_xori | i_ori | i_andi                                   ;
  assign EXTOp[3]    =    sbtype                                                                                                            ;
  assign EXTOp[4]    =    stype                                                                                                             ;
  assign EXTOp[5]    =    i_slli | i_srli | i_srai                                                                                          ;
            
 
   //NPC 
  // NPC_PLUS4   2'b00
  // NPC_BRANCH  2'b01
  // NPC_JUMP    2'b10
  //auipc        2'b11

  assign NPCOp[0]  =     jalr  | (i_beq & zf) | (~zf& i_bne) | (i_blt & sf) | (i_bge & ~sf) | (i_bltu & cf) | (i_bgeu & ~cf)                ;
  assign NPCOp[1]  =     jal   | jalr                                                                                                       ;
 // assign NPCOp[0] = (i_beq & zf) | (i_bne &~zf) | 
                     //(i_blt &~zf) | (i_bge&zf) | (i_bltu &(~zf)) | (i_bgeu&zf) | jalr;
  //assign NPCOp[1] = jal | jalr;

  // alu 
  //add /addi/jalr           00_0000_0001
  //sub                      00_0000_0010
  //sll /slli                00_0000_0010
  //slt /slti                00_0000_1000
  //sltu /sltiu              00_0001_0000
  //xor /xori                00_0010_0000
  //srl /srli                00_0100_0000
  //sra /srali               00_1000_0000
  //or /ori                  01_0000_0000
  //and /andi                10_0000_0000

assign ALUOp[0]   =     r_add  |  i_addi    |ltype   | stype | jalr                                                                         ;
assign ALUOp[1]   =     r_sub  |  sbtype                                                                                                    ;
assign ALUOp[2]   =     r_sll  |  i_slli                                                                                                    ;
assign ALUOp[3]   =     r_slt  |  i_slti                                                                                                    ;
assign ALUOp[4]   =     r_sltu |  i_sltiu                                                                                                   ;
assign ALUOp[5]   =     r_xor  |  i_xori                                                                                                    ;
assign ALUOp[6]   =     r_srl  |  i_srli                                                                                                    ;
assign ALUOp[7]   =     r_sra  |  i_srai                                                                                                    ;
assign ALUOp[8]   =     r_or   |  i_ori                                                                                                     ;
assign ALUOp[9]   =     r_and  |  i_andi                                                                                                    ;
 

  
endmodule
