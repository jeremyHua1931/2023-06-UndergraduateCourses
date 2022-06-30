module MEM_WB_Register(
    clk,rst,

    pc_in,pc_out,
    inst_in,inst_out,

    aluout_in,aluout_out,
    WB_signal_in , WB_signal_out,

    readdata_in,readdata_out,

    rd_in,rd_out
);

input clk;
input rst;

input [31:0] pc_in;
input [31:0] inst_in;

input [31:0] aluout_in;

input [4:0]  WB_signal_in ;

input [31:0] readdata_in;

input [4:0] rd_in; 


output reg [31:0] pc_out;
output reg [31:0] inst_out;

output reg  [31:0] aluout_out;
output reg  [4:0]  WB_signal_out ;

output reg  [31:0] readdata_out;
output reg  [4:0]  rd_out;

always @(posedge clk,posedge rst)
begin
    
    if(rst)
    begin
        pc_out<=32'b0          ;
        inst_out<=32'b0        ;

        aluout_out   <=32'b0;
        WB_signal_out  <= 4'b0;

        readdata_out  <= 32'b0;

        rd_out        <= 5'b0;

    end

    else begin
        pc_out          <=   pc_in        ;
        inst_out        <=   inst_in      ;

        aluout_out      <=   aluout_in     ;
        WB_signal_out   <=   WB_signal_in ;

        readdata_out    <=   readdata_in;

        rd_out          <=   rd_in;             
    end
end

endmodule