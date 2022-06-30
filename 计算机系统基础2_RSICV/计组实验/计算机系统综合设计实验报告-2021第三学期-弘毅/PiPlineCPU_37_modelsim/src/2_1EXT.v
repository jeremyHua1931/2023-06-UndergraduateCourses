//immgen
module EXT( inst , immout )                                                             ;

	input            [31:0]             inst											        ;
    
	output	 reg     [31:0] 	        immout                                                  ;
   

 //指令解析

	wire [5:0] EXTinst;
   wire   i_lui   =  ~inst[6]& inst[5]& inst[4]&~inst[3]& inst[2]& inst[1]& inst[0]                                     ;    // lui


   wire   auipc   =  ~inst[6]&~inst[5]& inst[4]&~inst[3]& inst[2]& inst[1]& inst[0]                                     ;    //auipc


   // j format 
   wire   jal     =   inst[6]& inst[5]&~inst[4]& inst[3]& inst[2]& inst[1]& inst[0]                                     ;    // jal
   wire   jalr    =   inst[6]& inst[5]&~inst[4]&~inst[3]& inst[2]& inst[1]& inst[0]& ~inst[14]&~inst[13]&~inst[12]   ;    //jlar

   wire   sbtype  =   inst[6]& inst[5]&~inst[4]&~inst[3]&~inst[2]& inst[1]& inst[0]      ;
   wire   i_beq   =   sbtype& ~inst[14]&~inst[13]&~inst[12]             ;    // beq
   wire   i_bne   =   sbtype& ~inst[14]&~inst[13]& inst[12]             ;    //bne
   wire   i_blt   =   sbtype&  inst[14]&~inst[13]&~inst[12]             ;    //blt
   wire   i_bge   =   sbtype&  inst[14]&~inst[13]& inst[12]             ;    //bge
   wire   i_bltu  =   sbtype&  inst[14]& inst[13]&~inst[12]             ;    //bltu
   wire   i_bgeu  =   sbtype&  inst[14]& inst[13]& inst[12]             ;    //bgeu


   // i format
   wire   ltype   =  ~inst[6]&~inst[5]&~inst[4]&~inst[3]&~inst[2]& inst[1]& inst[0]                                     ; 

   wire   i_lb    =   ltype & ~inst[14]&~inst[13]&~inst[12]                                            ;    // lb
   wire   i_lh    =   ltype & ~inst[14]&~inst[13]& inst[12]                                            ;    // lh
   wire   i_lw    =   ltype & ~inst[14]& inst[13]&~inst[12]                                            ;    // lw
                                                                    
   wire   i_lbu   =   ltype &  inst[14]&~inst[13]&~inst[12]                                            ;    // lw
   wire   i_lhu   =   ltype &  inst[14]&~inst[13]& inst[12]                                            ;    // lw
     

   // s format
   wire   stype   =  ~inst[6]& inst[5]&~inst[4]&~inst[3]&~inst[2]& inst[1]& inst[0]                                     ;

   wire   i_sb    =   stype & ~inst[14]&~inst[13]&~inst[12]                                            ;    // sb
   wire   i_sh    =   stype & ~inst[14]&~inst[13]& inst[12]                                            ;    // sh
   wire   i_sw    =   stype & ~inst[14]& inst[13]&~inst[12]                                            ;    // sw
 

   // i format(立即数)
   wire   itype   =  ~inst[6]&~inst[5]&inst[4]&~inst[3]&~inst[2]&inst[1]&inst[0]                                        ;
   wire   i_addi  =   itype & ~inst[14]&~inst[13]&~inst[12]                                            ;    // addi 
   wire   i_slti  =   itype & ~inst[14]& inst[13]&~inst[12]                                            ;    //sltu
   wire   i_sltiu =   itype & ~inst[14]& inst[13]& inst[12]                                            ;    //sltui
   wire   i_xori  =   itype &  inst[14]&~inst[13]&~inst[12]                                                                              ;    //xori
   wire   i_ori   =   itype &  inst[14]& inst[13]&~inst[12]                                                                              ;    // ori
   wire   i_andi  =   itype &  inst[14]& inst[13]& inst[12]                                                                              ;    // andi

   wire   i_slli  =   itype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]& ~inst[14]&~inst[13]& inst[12] ;    // slli
   wire   i_srli  =   itype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]&  inst[14]&~inst[13]& inst[12] ;    // srli
   wire   i_srai  =   itype& ~inst[31]& inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]&  inst[14]&~inst[13]& inst[12] ;    // srai

  // r format
   wire   rtype   =  ~inst[6]&inst[5]&inst[4]&~inst[3]&~inst[2]&inst[1]&inst[0]; //0110011

   wire   r_add   =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]& ~inst[14]&~inst[13]&~inst[12] ;    // add 
   wire   r_sub   =   rtype& ~inst[31]& inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]& ~inst[14]&~inst[13]&~inst[12] ;    // sub
  
   wire   r_sll   =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]& ~inst[14]&~inst[13]& inst[12] ;    //sll
   wire   r_slt   =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]& ~inst[14]& inst[13]&~inst[12] ;    //slt
   wire   r_sltu  =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]& ~inst[14]& inst[13]& inst[12] ;    //sltu
  
   wire   r_xor   =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]&  inst[14]&~inst[13]&~inst[12] ;    //xor
   wire   r_srl   =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]&  inst[14]&~inst[13]& inst[12] ;    //srl
   wire   r_sra   =   rtype& ~inst[31]& inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]&  inst[14]&~inst[13]& inst[12] ;    //sra
  
   wire   r_or    =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]&  inst[14]& inst[13]&~inst[12] ;    //or
   wire   r_and   =   rtype& ~inst[31]&~inst[30]&~inst[29]&~inst[28]&~inst[27]&~inst[26]&~inst[25]&  inst[14]& inst[13]& inst[12] ;    // and  


  // signed extension

  //1-lui,    auipc                                                     000001         {inst[31:12],12'b0}                              
  //2-jal                                                               000010         {{20{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0} 
  //3-jalr,   lb,lh,lw,lbu,lwu,   addi,slti,sltiu,xori,ori,andi         000100         {{20{inst[31]}},inst[31:20]}
  //4-beq,bne,blt,bge,bltu,bgeu                                         001000         {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0} 
  //5-sb.sh,sw                                                          010000         {{20{inst[31]}},inst[31:25],inst[11:7]}                                                    
  //6-slli,srli,srai                                                    100000         {{27{inst[31]}},inst[24:20]}

  assign EXTinst[0]    =    i_lui  | auipc                                                                                                    ;
  assign EXTinst[1]    =    jal                                                                                                               ;
  assign EXTinst[2]    =    jalr   | ltype  | i_addi | i_slti | i_slti  | i_sltiu | i_xori | i_ori | i_andi                                   ;
  assign EXTinst[3]    =    sbtype                                                                                                            ;
  assign EXTinst[4]    =    stype                                                                                                             ;
  assign EXTinst[5]    =    i_slli | i_srli | i_srai                                                                                          ;


always @ (*) 
	begin
		case(EXTinst)
	    	 6'b000001 :  immout   <=  {inst[31:12],12'b0} 										;        //1-lui,    auipc 
			 6'b000010 :  immout   <=  {{20{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0}   ;       //2-jal
			 6'b000100 :  immout   <=  {{20{inst[31]}},inst[31:20]}                             ;       //3-jalr,   lb,lh,lw,lbu,lwu,   addi,slti,sltiu,xori,ori,andi   
			 6'b001000 :  immout   <=  {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0}     ;       //4-beq,bne,blt,bge,bltu,bgeu   
			 6'b010000 :  immout   <=  {{20{inst[31]}},inst[31:25],inst[11:7]}                  ;       //5-sb.sh,sw
			 6'b100000 :  immout   <=  {{27{inst[24]}},inst[24:20]}                             ;       //6-slli,srli,srai 
		     default   :  immout   <=  32'b0;
	    endcase
    end
endmodule

  //1-lui,    auipc                                                     000001         {inst[31:12],12'b0}                              
  //2-jal                                                               000010         {{20{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0} 
  //3-jalr,   lb,lh,lw,lbu,lwu,   addi,slti,sltiu,xori,ori,andi         000100         {{20{inst[31]}},inst[31:20]}
  //4-beq,bne,blt,bge,bltu,bgeu                                         001000         {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0} 
  //5-sb.sh,sw                                                          010000        {{20{inst[31]}},inst[31:25],inst[11:7]}                                                    
  //6-slli,srli,srai                                                    100000         {{27{inst[31]}},inst[24:20]}



