module ID_EX_Register(
    clk,rst,
    flush,

    pc_in,pc_out,  //PC
    inst_in,inst_out,

    //EX_signal
    //MEM_signal
    //WB_signal
    EX_signal_in,EX_signal_out,
    MEM_signal_in,MEM_signal_out,
    WB_signal_in,WB_signal_out,

    RD1_in,RD2_in,rd_in,RD1_out,RD2_out,rd_out,   //RF

    imm_in,imm_out ,           //immGen
    Memread_in,Memread_out
);

input   clk;
input   rst;
input flush;

input [31:0] pc_in;
input [31:0] inst_in;

input [10:0]    EX_signal_in ;
input [5:0]     MEM_signal_in;
input [4:0]     WB_signal_in ;

input   [31:0]  RD1_in        ;
input   [31:0]  RD2_in        ;
input   [4:0]   rd_in         ;

input   [31:0]  imm_in        ;
input   Memread_in;
   

output reg [31:0] pc_out;
output reg [31:0] inst_out;

output reg  [10:0]    EX_signal_out ;
output reg  [4:0]     MEM_signal_out;
output reg  [4:0]     WB_signal_out ;

output  reg [31:0]  RD1_out      ;
output  reg [31:0]  RD2_out      ;
output  reg [4:0]   rd_out       ;
output  reg [31:0]  imm_out      ;

output  reg Memread_out;

always @(posedge clk,posedge rst)
begin

    if(rst)
    begin
        pc_out  <=32'b0          ;
        inst_out<=32'b0;

        EX_signal_out  <= 10'b0; 
        MEM_signal_out <= 4'b0;
        WB_signal_out  <= 4'b0;

        RD1_out      <=  32'b0 ;
        RD2_out      <=  32'b0 ;  
        rd_out       <=  32'b0 ; 

        imm_out      <=  32'b0 ; 
        Memread_out<=1'b0;
    end  
    else if(flush==1'b1)
    begin 
        pc_out  <=32'b0          ;
        inst_out<=32'b0;

        EX_signal_out  <= 10'b0; 
        MEM_signal_out <= 4'b0;
        WB_signal_out  <= 4'b0;

        RD1_out      <=  32'b0 ;
        RD2_out      <=  32'b0 ;  
        rd_out       <=  32'b0 ; 

        imm_out      <=  32'b0 ; 
        Memread_out<=1'b0;
    end
    else begin
        pc_out       <=  pc_in        ;
        inst_out      <=  inst_in      ;
        
        EX_signal_out  <= EX_signal_in ; 
        MEM_signal_out <= MEM_signal_in;
        WB_signal_out  <= WB_signal_in ;

        RD1_out      <=  RD1_in       ;
        RD2_out      <=  RD2_in       ; 
        rd_out       <=  rd_in        ;        
        imm_out      <=  imm_in       ; 
        Memread_out <=Memread_in;
    end

end

endmodule