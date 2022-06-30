module  branch_judge (
    inst,
    alu_signal,
    branch,
     flush,
    NPC_out
);

input [3:0] alu_signal;
input [3:0] branch;
input [31:0] inst;


output [1:0] NPC_out;
output flush;

wire  zf  = alu_signal[0];
wire  sf  = alu_signal[1];
wire  cf  = alu_signal[2];
wire  of  = alu_signal[3];



// j format 
wire   jal     =  branch[3] & ~branch[2] & ~branch[1] & ~branch[0] ;
wire   jalr    = ~branch[3] & ~branch[2] & ~branch[1] &  branch[0] ;

wire   i_beq   = ~branch[3] & ~branch[2] &  branch[1] & ~branch[0] ;
wire   i_bne   = ~branch[3] &  branch[2] & ~branch[1] & ~branch[0] ;

wire   i_blt   = ~branch[3] & ~branch[2] &  branch[1] &  branch[0] ;
wire   i_bge   = ~branch[3] &  branch[2] & ~branch[1] &  branch[0] ;
wire   i_bltu  = ~branch[3] &  branch[2] &  branch[1] & ~branch[0] ;
wire   i_bgeu  = ~branch[3] &  branch[2] &  branch[1] &  branch[0] ;

 
//NPC 
// NPC_PLUS4   2'b00
// NPC_BRANCH  2'b01
// NPC_JUMP    2'b10
//auipc        2'b11

assign NPC_out[0]  =     jalr  | (i_beq & zf) | (~zf& i_bne) | (i_blt & sf) | (i_bge & ~sf) | (i_bltu & cf) | (i_bgeu & ~cf)  ;
assign NPC_out[1]  =     jal   | jalr                                                                                    ;

assign flush = ~((~NPC_out[0])&(~NPC_out[1]));

endmodule