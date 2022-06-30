module IF_ID_Register(clk, rst, pc_in,pc_out,inst_in,inst_out,IF_ID_Write,flush);

input  clk;
input  rst;
input flush;

input [31:0]   pc_in          ;

input [31:0]   inst_in        ;
input  IF_ID_Write;

output reg [31:0] pc_out      ;
output reg [31:0] inst_out    ;


always @(posedge clk ,posedge rst)
begin

    if(rst)
    begin
        pc_out      <=  32'b0       ;
        inst_out    <=   32'b0      ;
    end
    else if(flush==1'b1)
    begin
        pc_out      <=  32'b0       ;
        inst_out    <=   32'b0      ;
    end
    else if(~IF_ID_Write)
    begin
        pc_out      <=   pc_in      ;      
        inst_out    <=   inst_in    ;

    end


end

endmodule
