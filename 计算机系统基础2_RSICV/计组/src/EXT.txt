//immgen
module EXT( inst , EXTOp , immout )                                                             ;

	input            [31:0]             inst											        ;
    input            [ 5:0]             EXTOp                                                   ;
	output	 reg     [31:0] 	        immout                                                  ;
   
always @ (*) 
	begin
		case(EXTOp)
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



