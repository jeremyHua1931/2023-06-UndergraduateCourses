module ALUControl(
    input rst,
    input[5:0] funct,
    input[1:0] alu_ct_op,
    output reg[3:0] alu_ct
);
    always@(*) begin
        if(!rst)
            alu_ct = 0;
        else
            case(alu_ct_op)
                2'b00:alu_ct= 4'b0010;
                2'b01:alu_ct= 4'b0110;
                2'b10:begin case(funct)
     //在此补充代码：当指令中 funct 段为 100001 时，alu_ct 输出 4’b0010（执行加法操作）。
                        default: alu_ct = 0;
                    endcase end
                default: alu_ct = 0;
            endcase
    end
    
endmodule