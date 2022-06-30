module alu_1_forward(
    input [1:0] forward_A,
    input [31:0] RD_1,
    input [31:0] aluout,
    input [31:0] WD,
    output reg [31:0] alu_1 
);

always @(*) begin
    case(forward_A)
    2'b00:   alu_1  <= RD_1;
    2'b10:   alu_1  <= aluout;
    2'b01:   alu_1  <= WD;
    default: alu_1 <=  RD_1;   
    endcase
end

endmodule