//ctrl 
module ctrl( inst,Op , Funct7 , Funct3 , EX_signal,MEM_signal,WB_signal,Memread )  ;
   
   input    [31:0]   inst;

   input    [6:0]    Op     ; 
   input    [2:0]    Funct3 ;          
   input    [6:0]    Funct7 ;   
   
   output             Memread;
   output   [10:0]    EX_signal ; 
   output   [4:0]     MEM_signal ; 
   output   [4:0]     WB_signal ;
   

   //EX signal
   //output            ALUSrc        ;    // ALU source for B
   //output   [9:0]    ALUOp         ;    // ALU opertion

   //MEM signal
   //output             MemWrite      ;    // control signal for memory write
   //output   [1:0]     branch        ;
 
   //WB  signal
  //output            RegWrite      ;    // control signal for register write
  //output   [3:0]    MemtoReg      ;    // 寄存器使用alu结果还是内存结果
   
  
   //指令解析

   wire   i_lui   =  ~Op[6]& Op[5]& Op[4]&~Op[3]& Op[2]& Op[1]& Op[0]                                     ;    // lui


   wire   auipc   =  ~Op[6]&~Op[5]& Op[4]&~Op[3]& Op[2]& Op[1]& Op[0]                                     ;    //auipc


   // j format 
   wire   jal     =   Op[6]& Op[5]&~Op[4]& Op[3]& Op[2]& Op[1]& Op[0]                                     ;    // jal
   wire   jalr    =   Op[6]& Op[5]&~Op[4]&~Op[3]& Op[2]& Op[1]& Op[0]& ~Funct3[2]&~Funct3[1]&~Funct3[0]   ;    //jlar

   wire   sbtype  =   Op[6]& Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0]      ;
   wire   i_beq   =   sbtype& ~Funct3[2]&~Funct3[1]&~Funct3[0]             ;    // beq
   wire   i_bne   =   sbtype& ~Funct3[2]&~Funct3[1]& Funct3[0]             ;    //bne
   wire   i_blt   =   sbtype&  Funct3[2]&~Funct3[1]&~Funct3[0]             ;    //blt
   wire   i_bge   =   sbtype&  Funct3[2]&~Funct3[1]& Funct3[0]             ;    //bge
   wire   i_bltu  =   sbtype&  Funct3[2]& Funct3[1]&~Funct3[0]             ;    //bltu
   wire   i_bgeu  =   sbtype&  Funct3[2]& Funct3[1]& Funct3[0]             ;    //bgeu


   // i format
   wire   ltype   =  ~Op[6]&~Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0]                                     ; 

   wire   i_lb    =   ltype & ~Funct3[2]&~Funct3[1]&~Funct3[0]                                            ;    // lb
   wire   i_lh    =   ltype & ~Funct3[2]&~Funct3[1]& Funct3[0]                                            ;    // lh
   wire   i_lw    =   ltype & ~Funct3[2]& Funct3[1]&~Funct3[0]                                            ;    // lw
                                                                    
   wire   i_lbu   =   ltype &  Funct3[2]&~Funct3[1]&~Funct3[0]                                            ;    // lw
   wire   i_lhu   =   ltype &  Funct3[2]&~Funct3[1]& Funct3[0]                                            ;    // lw
     

   // s format
   wire   stype   =  ~Op[6]& Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0]                                     ;

   wire   i_sb    =   stype & ~Funct3[2]&~Funct3[1]&~Funct3[0]                                            ;    // sb
   wire   i_sh    =   stype & ~Funct3[2]&~Funct3[1]& Funct3[0]                                            ;    // sh
   wire   i_sw    =   stype & ~Funct3[2]& Funct3[1]&~Funct3[0]                                            ;    // sw
 

   // i format(立即数)
   wire   itype   =  ~Op[6]&~Op[5]&Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]                                        ;
   wire   i_addi  =   itype & ~Funct3[2]&~Funct3[1]&~Funct3[0]                                            ;    // addi 
   wire   i_slti  =   itype & ~Funct3[2]& Funct3[1]&~Funct3[0]                                            ;    //sltu
   wire   i_sltiu =   itype & ~Funct3[2]& Funct3[1]& Funct3[0]                                            ;    //sltui
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


   //EX signal
   //output            ALUSrc        ;    // ALU source for B
   //output   [9:0]    ALUOp         ;    // ALU opertion

  // ALU B is from instruction immediate
  //assign ALUSrc       =   i_lui  | auipc  | jal    | jalr   |  ltype  | stype  | itype | i_slli | i_srli | i_srai  

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

  assign EX_signal[10] = i_lui  | auipc  | jal    | jalr   |  ltype  | stype  | itype | i_slli | i_srli | i_srai;
  assign EX_signal[0]   =     r_add  |  i_addi    |ltype   | stype | jalr                            ;
  assign EX_signal[1]   =     r_sub  |  sbtype                                                       ;
  assign EX_signal[2]   =     r_sll  |  i_slli                                                       ;
  assign EX_signal[3]   =     r_slt  |  i_slti                                                       ;
  assign EX_signal[4]   =     r_sltu |  i_sltiu                                                      ;
  assign EX_signal[5]   =     r_xor  |  i_xori                                                       ;
  assign EX_signal[6]   =     r_srl  |  i_srli                                                       ;
  assign EX_signal[7]   =     r_sra  |  i_srai                                                       ;
  assign EX_signal[8]   =     r_or   |  i_ori                                                        ;
  assign EX_signal[9]   =     r_and  |  i_andi                                                       ;



   //MEM signal
   //output             MemWrite      ;    // control signal for memory write
   //output   [1:0]     branch        ;

   //assign MemWrite =   i_sw         ;
   

   //brach

  //1000 jal
  //0001  jlar
  //0010  beq
  //0100  bne

  //0011 blt
  //0101 bge
  //0110 bltu
  //0111 bgeu
  
  assign MEM_signal[0] = i_sw ;
  assign MEM_signal[1] = jalr| i_blt |i_bge| i_bgeu      ;
  assign MEM_signal[2] = i_beq | i_blt | i_bltu | i_bgeu   ;
  assign MEM_signal[3] = i_bne | i_bge | i_bltu | i_bgeu   ;
  assign MEM_signal[4] = jal;

 
   //WB  signal
  //output            RegWrite      ;    // control signal for register write
  //output   [3:0]    MemtoReg      ;    // 寄存器使用alu结果还是内存结果
   
   // register write
  //assign RegWrite     =   i_lui | auipc | jal | jalr | ltype | itype | rtype                                                                ;

  assign WB_signal[4]  =   i_lui | auipc | jal | jalr | ltype | itype | rtype;
  assign WB_signal[0]  =   i_lw   | i_lh                                  ;                     
  assign WB_signal[1]  =   auipc  | i_lbu                                 ;                     
  assign WB_signal[2]  =   jal    | jalr   | i_lhu                        ;                     
  assign WB_signal[3]  =   i_lb   | i_lh   | i_lbu  | i_lhu               ;   

  assign Memread=i_lw |  i_lb | i_lh | i_lbu | i_lhu;                                                                                              
  // memory to register
  //0000    aluout     
  //0001    readdata-lw    i_lw
  //0010    pc+aluout      auipc
  //0100    pc+4           jal,jalr
  //1000    readdata-lb    i_lb
 
  //1001    readdata-lh    i_lh
  //1010    readdata-lbu   i_lbu
  //1100    readdata-lhu   i_lhu


  
endmodule
