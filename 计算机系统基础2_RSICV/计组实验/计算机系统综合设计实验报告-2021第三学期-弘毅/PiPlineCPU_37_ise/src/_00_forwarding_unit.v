module forwarding(
    ID_EX_Rs1,
    ID_EX_Rs2,
    ID_EX_Rd,

    EX_MEM_RegWrite,
    MEM_WB_RegWrite,

    EX_MEM_RegisterRd,
    MEM_WB_RegisterRd,
     forward_A,
     forward_B
);


    input [4:0] ID_EX_Rs1;
    input [4:0] ID_EX_Rs2;
    input [4:0] ID_EX_Rd;

    input       EX_MEM_RegWrite;
    input        MEM_WB_RegWrite;

    input [4:0] EX_MEM_RegisterRd;
    input [4:0] MEM_WB_RegisterRd;

    output reg [1:0] forward_A;
    output reg [1:0] forward_B;

    
    wire ForwardA_0 = EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0 ) & (EX_MEM_RegisterRd == ID_EX_Rs1);
    wire ForwardA_1 = (MEM_WB_RegWrite & (MEM_WB_RegisterRd != 0 )  & (MEM_WB_RegisterRd == ID_EX_Rs1)) & ~(EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0 ) & (EX_MEM_RegisterRd == ID_EX_Rs1));
    wire ForwardB_0 = EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0 ) & (EX_MEM_RegisterRd == ID_EX_Rs2);
    wire ForwardB_1 = (MEM_WB_RegWrite & (MEM_WB_RegisterRd != 0 )  & (MEM_WB_RegisterRd == ID_EX_Rs2)) & ~(EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0 ) & (EX_MEM_RegisterRd == ID_EX_Rs2));

    
always@(*)begin
    if ((ForwardA_0 === 0 | ForwardA_0 === 1) & (ForwardA_1 === 0 | ForwardA_1 === 1))  forward_A = {ForwardA_0,ForwardA_1};
    else forward_A = 2'b00;
    if ((ForwardB_0 === 0 | ForwardB_0 === 1) & (ForwardB_1 === 0 | ForwardB_1 === 1))  forward_B = {ForwardB_0,ForwardB_1};
    else  forward_B = 2'b00;
end


endmodule