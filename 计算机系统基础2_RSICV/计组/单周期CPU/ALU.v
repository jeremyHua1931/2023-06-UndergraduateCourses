module alu(A,B,ALUOp,C);

input [31:0] A,B;
input [2:0] ALUOp;
output [31:0] C;

reg [31:0] C;

always@(ALUOp[2:0] or A or B)
begin
	case(ALUOp[2:0])
		3'b000:C=$unsigned(A)+$unsigned(B); 
		3'b001:C=$unsigned(A)-$unsigned(B);  
  		3'b010:C=A&B;    
		3'b011:C=A|B;  
		3'b100:C=A>>$unsigned(B); 
		3'b101:  
			 C=($signed(A))>>>B;
		3'b110:  
			begin
				if(A>B)
					C=1;
				else 
					C=0;
			end
		3'b111:  
			begin                        
            			if(A[31]==1&B[31]==0)
                			C=0;
            			else if(A[31]==0&&B[31]==1)
                			C=1;
            			else 
                			C=(A<B)?1:0;
                        
           		end
	endcase
end
endmodule
