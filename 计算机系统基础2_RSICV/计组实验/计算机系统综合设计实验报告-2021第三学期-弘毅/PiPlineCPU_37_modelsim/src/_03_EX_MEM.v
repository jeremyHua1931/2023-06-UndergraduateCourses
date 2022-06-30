module EX_MEM_Register(
    clk,rst,

    pc_in,pc_out,
    inst_in,inst_out,
    
    alu_signal_in,alu_signal_out,

    aluout_in,aluout_out,

     imm_in,imm_out,

    rd_in,rd_out,
    RD2_in,RD2_out,

    MEM_signal_in,MEM_signal_out,
    WB_signal_in,WB_signal_out,
    MemWrite_out
);

input clk;
input rst;

input [31:0] pc_in;
input [31:0] inst_in;

input   [31:0]  imm_in        ;

input  [3:0] alu_signal_in     ;
input [31:0] aluout_in;

input [4:0]     MEM_signal_in;
input [4:0]     WB_signal_in ;


input   [4:0]    rd_in         ;
input [31:0] RD2_in;

output  reg MemWrite_out;


output reg [31:0] pc_out;
output reg [31:0] inst_out;

output   reg [31:0]   imm_out       ;

output reg [3:0] alu_signal_out;
output reg [31:0]   aluout_out       ;

output reg  [4:0]     MEM_signal_out;
output reg  [4:0]     WB_signal_out ;

output   reg [4:0]    rd_out         ;
output reg [31:0] RD2_out;



always @(posedge clk,posedge rst)
begin
    if(rst)
        begin
            pc_out<=32'b0          ;
            inst_out<=32'b0        ;

            alu_signal_out <=4'b0;
            aluout_out   <=32'b0;
            
            imm_out      <=  32'b0 ; 
            
            MEM_signal_out <= 4'b0;
            WB_signal_out  <= 4'b0;

            RD2_out      <=  32'b0 ; 
            rd_out         <=   4'b0;
            MemWrite_out   <=1'b0;
        end
      else begin
        pc_out             <=    pc_in        ;
        inst_out           <=    inst_in      ;

        alu_signal_out     <=    alu_signal_in;
        aluout_out         <=    aluout_in;
       
        imm_out            <=    imm_in       ;
           
        MEM_signal_out     <=    MEM_signal_in;
        WB_signal_out      <=    WB_signal_in ;
        
        rd_out             <=    rd_in         ;
        RD2_out            <=    RD2_in         ;

        MemWrite_out    <=  MEM_signal_in[0];
    end
end
endmodule