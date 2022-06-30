//second top_comp
module SCPU( clk, rst, instr, readdata, PC, MemWrite, aluout, writedata,CPU_MIO,MIO_ready,INT)        ;
         
   input                   clk                                                   ;    // clock
   input                   rst ;
   
   input  CPU_MIO;
   input  MIO_ready;
   input  INT;                                                  // reset
   
   input     [31:0]        instr                                                 ;    // instruction
   input     [31:0]        readdata                                              ;    // data from data memory
   
   output    [31:0]        PC                                                    ;    // PC address
   output           MemWrite                                              ;    // memory write
   output    [31:0]        aluout                                                ;    // ALU output
   output    [31:0]        writedata                                             ;    // data to data memory
   
   wire                    RegWrite                                              ;    // control signal to register write
   wire      [ 5:0]        EXTOp                                                 ;    // control signal to signed extension
   wire      [ 9:0]        ALUOp                                                 ;    // ALU opertion
   wire      [ 1:0]        NPCOp                                                 ;    // next PC operation

   wire      [ 3:0]        MemtoReg                                              ;    // (register) write data selection
   
   wire                    ALUSrc                                                ;    // ALU source for B
   
   wire                    zf                                                    ;    // ALU ouput 
   wire                    sf                                                    ;
   wire                    cf                                                    ;
   wire                    of                                                    ;


   wire      [31:0]        NPC                                                   ;    // next PC

   wire      [ 4:0]        rs1                                                   ;    // rs
   wire      [ 4:0]        rs2                                                   ;    // rt
   wire      [ 4:0]        rd                                                    ;    // rd
   wire      [ 6:0]        Op                                                    ;    // opcode
   wire      [ 6:0]        Funct7                                                ;    // funct7
   wire      [ 2:0]        Funct3                                                ;    // funct3
   
   wire      [31:0]        Imm32                                                 ;    // 32-bit immediate

   wire      [ 4:0]        A3                                                    ;    // register address for write
   wire      [31:0]        WD                                                    ;    // register write data
   wire      [31:0]        RD1                                                   ;
   wire      [31:0]        RD2                                                   ;    // register data specified by rs/rt

   wire      [31:0]        A                                                     ;  
   wire      [31:0]        B                                                     ;    // operator for ALU B
    
   assign    Op            =        instr[ 6: 0]                                 ;    // instruction
   assign    Funct7        =        instr[31:25]                                 ;    // funct7
   assign    Funct3        =        instr[14:12]                                 ;    // funct3
   assign    rs1           =        instr[19:15]                                 ;    // rs1
   assign    rs2           =        instr[24:20]                                 ;    // rs2
   assign    rd            =        instr[11: 7]                                 ;    // rd  
   assign    writedata     =        RD2;
   
  
ctrl U_ctrl
(
    .Op            (Op)                                                          ,
    .Funct7        (Funct7)                                                      ,
    .Funct3        (Funct3)                                                      , 
    .zf            (zf)                                                          , 
    .sf            (sf)                                                          ,
    .cf            (cf)                                                          ,
    .of            (of)                                                          ,
    .RegWrite      (RegWrite)                                                    , 
    .MemWrite      (MemWrite)                                                    ,
    .EXTOp         (EXTOp)                                                       , 
    .ALUOp         (ALUOp)                                                       , 
    .NPCOp         (NPCOp)                                                       , 
    .ALUSrc        (ALUSrc)                                                      , 
    .MemtoReg      (MemtoReg)

);
    
PC U_pc
(
    .clk           (clk)                                                         ,
    .rst           (rst)                                                         ,
    .NPC           (NPC)                                                         ,
    .PC            (PC)
);

alu U_alu
(
    .A             (RD1)                                                         ,
    .B             (B)                                                           ,
    .ALUOp         (ALUOp)                                                       ,
    .C             (aluout)                                                      ,
    .zf            (zf)                                                          ,
    .sf            (sf)                                                          ,
    .cf            (cf)                                                          ,
    .of            (of)                                                          
);

RF U_RF
(
    .clk           (clk)                                                         ,
    .rst           (rst)                                                         ,
    .RFWr          (RegWrite)                                                    ,
    .A1            (rs1)                                                         ,
    .A2            (rs2)                                                         ,
    .A3            (rd)                                                          ,                                                         
    .WD            (WD)                                                          ,                                                         
    .RD1           (RD1)                                                         ,
    .RD2           (RD2)                                                         
); 

EXT U_EXT
(
    .inst          (instr)                                                       ,
    .EXTOp         (EXTOp)                                                       ,
    .immout        (Imm32)
);

NPC U_PC
(
    .PC            (PC)                                                          ,
    .NPCOp         (NPCOp)                                                       ,
    .aluout        (aluout)                                                      ,
    .inst          (instr)                                                       ,
    .NPC           (NPC)
);



mux1 mux_alu_B
(
    .signal       (ALUSrc)                                                       ,
    .mux_0        (RD2)                                                          ,
    .mux_1        (Imm32)                                                        ,
    .mux_out      (B)
);    

mux2 U_mux_mem2reg
(
    .mux_in1      (aluout)                                                       ,
    .mux_in2      (readdata)                                                     ,
    .PC           (PC)                                                           ,
    .MemtoReg     (MemtoReg)                                                     ,
    .WD           (WD)
);

endmodule