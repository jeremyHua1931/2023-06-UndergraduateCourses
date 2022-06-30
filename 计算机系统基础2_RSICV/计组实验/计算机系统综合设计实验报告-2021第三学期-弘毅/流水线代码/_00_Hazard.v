module  hazard(

    input [31:0] inst_IF_ID,
    input [4:0] ID_EX_Rd,

    input [4:0] IF_R1,
    input [4:0] IF_R2,

    input Memread,

    output reg IF_ID_Write,
    output reg PCWrite,
    output reg  hazard_ctrl_mux
);

wire condition1=(ID_EX_Rd==IF_R1);
wire condition2=(ID_EX_Rd==IF_R2);

   
always @(*) begin
    if(Memread & ((condition1)|(condition2)))
        begin
             IF_ID_Write=1;
             PCWrite=1;
             hazard_ctrl_mux=1;
        end
    else begin
        IF_ID_Write=0;
             PCWrite=0;
             hazard_ctrl_mux=0;
    end

end


endmodule