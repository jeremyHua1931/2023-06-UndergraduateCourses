module alu_2_forward(ALUSrc,forward_B,RD_2,imm,aluout,WD,alu_2,writedata)        ;


    input                 ALUSrc               ;
    input       [1:0]    forward_B ;
    input       [31:0]    RD_2                ;
    input       [31:0]    imm     ;
    input       [31:0]    aluout             ;
    input       [31:0]    WD              ;

    output reg  [31:0]    alu_2             ;
    output reg  [31:0]    writedata         ;

always @(*) 
    begin
        case({ALUSrc,forward_B})

        3'b000    :          
                   begin
                       alu_2     <= RD_2    ;
                       writedata <= RD_2    ;
                   end
        3'b010    :          
                   begin
                       alu_2     <= aluout    ;
                       writedata <= aluout   ;
                   end
        3'b001    :          
                   begin
                       alu_2     <= WD   ;
                       writedata <= WD  ;
                   end
        3'b100    :          
                   begin
                       alu_2     <= imm   ;
                       writedata <= RD_2  ;
                   end
        3'b110    :          
                   begin
                       alu_2     <= imm    ;
                       writedata <= aluout  ;
                   end
        3'b101    :          
                   begin
                       alu_2     <= imm    ;
                       writedata <= WD ;
                   end
        endcase
    end

endmodule

