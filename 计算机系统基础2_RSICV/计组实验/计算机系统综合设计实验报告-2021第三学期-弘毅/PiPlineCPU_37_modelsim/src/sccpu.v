module sccpu( clk, rst, inst, readdata, PC, MemWrite, aluout_EX_MEM, writedata_EX_MEM,inst_MEM_WB//
//,CPU_MIO,MIO_ready,INT
);
   
   input                   clk         ;    // clock
   input                   rst         ;    // reset
   //input  CPU_MIO;input  MIO_ready;input  INT;    
   
   input     [31:0]        inst       ;    // instruction
   input     [31:0]        readdata    ;    // data from data memory
   
   output    [31:0]        PC          ;    // PC address
   output                  MemWrite    ;    // memory write
   output    [31:0]        aluout_EX_MEM ;    // ALU output

   output    [31:0]        writedata_EX_MEM   ;    // data to data memory
   output    [31:0]        inst_MEM_WB ;

wire     [31:0]   writedata_0;

wire      flush;
wire      [31:0]        PC_IF_ID  ;
wire      [31:0]        PC_ID_EX  ;
wire      [31:0]        PC_EX_MEM ;
wire      [31:0]        PC_MEM_WB ;


wire      [31:0]        inst_IF_ID ;
wire      [31:0]        inst_ID_EX;
wire      [31:0]        inst_EX_MEM;
//wire      [31:0]        inst_MEM_WB;

//NPC signal
wire      [ 1:0]        NPCOp        ;    // next PC operation
wire      [31:0]        NPC      ; 

//hazard signal
wire     PCWrite;
wire     IF_ID_Write;
wire     hazard_ctrl_mux;
wire      Memread;
wire      Memread_ID_EX;

//hazard ctrl
wire       [10:0]          EX_signal_hazard_ctrl;
wire       [5:0]           MEM_signal_hazard_ctrl;
wire       [4:0]           WB_signal_hazard_ctrl;


//control  signal 
wire      [10:0]         EX_signal  ;
wire      [10:0]         EX_signal_ID_EX  ;

wire      [4:0]         MEM_signal ;
wire      [4:0]         MEM_signal_ID_EX ;
wire      [4:0]         MEM_signal_EX_MEM ;

wire      [4:0]         WB_signal  ;
wire      [4:0]         WB_signal_ID_EX  ;
wire      [4:0]         WB_signal_EX_MEM  ;
wire      [4:0]         WB_signal_MEM_WB  ;

//EXT  signal
wire      [31:0]        Imm32            ;    
wire      [31:0]        Imm32_ID_EX      ;    
wire      [31:0]        Imm32_EX_MEM     ; 

//RF  signal

wire      [31:0]        RD1              ;
wire      [31:0]        RD1_ID_EX        ;

wire      [31:0]        RD2              ;    // register data specified by rs/rt
wire      [31:0]        RD2_ID_EX        ;
wire      [31:0]        RD2_EX_MEM       ;

wire      [4:0]         rd_ID_EX         ;
wire      [4:0]         rd_MEM_WB        ;
wire      [4:0]         rd_EX_MEM        ;


//forward  aignal
wire      [1:0]         forward_A;
wire      [1:0]         forward_B;
wire      [31:0] B_0;

//alu signal
wire      [31:0]            A;
wire      [31:0]            B;
wire      [31:0]        aluout           ;  
wire      [31:0]        aluout_MEM_WB    ;

wire      [3:0]      alu_signal ;
wire      [3:0]      alu_signal_EX_MEM;



//dm

wire     [31:0]          readdata_MEM_WB;
wire     [31:0]          WD                 ;
wire     [31:0]          WD_MEM_WB          ;


//assign MemWrite = MEM_signal_EX_MEM[0];


/**************         IF                  ************/

NPC U_NPC
(   
    .clk           (clk)         ,
    .PC_0          (PC_ID_EX)    ,
    .inst          (inst_ID_EX)  ,
    .aluout        (aluout)      ,
    .PC            (PC)          ,
    .NPCOp         (NPCOp)       ,
    .NPC           (NPC)  
         
);


PC U_pc
(
    .clk           (clk)     ,
    .rst           (rst)     ,
    .PCWrite       (PCWrite) ,
    .NPC           (NPC)     ,
    .PC            (PC)      
     
);

/******* IF_ID_register  **************/

IF_ID_Register  IF_ID
(
    .clk(clk),
    .rst(rst),
    .flush(flush),

    .pc_in(PC),
    .pc_out(PC_IF_ID),

    .IF_ID_Write(IF_ID_Write),

    .inst_in(inst),
    .inst_out(inst_IF_ID)
);
 
/**************         ID                  ************/


hazard hazard
(
    .inst_IF_ID(inst_IF_ID),
    .ID_EX_Rd(rd_ID_EX),
    .IF_R1(inst_IF_ID[19:15]),
    .IF_R2(inst_IF_ID[24:20]),
    .Memread(Memread_ID_EX),

    .IF_ID_Write(IF_ID_Write),
    .PCWrite(PCWrite),
    .hazard_ctrl_mux(hazard_ctrl_mux)
);


ctrl U_ctrl
(   
    .inst          (inst_IF_ID)           , 
    .Op            (inst_IF_ID[ 6: 0])    ,
    .Funct7        (inst_IF_ID[31:25])    ,
    .Funct3        (inst_IF_ID[14:12])    , 

    .Memread       (Memread)              ,
    .EX_signal     (EX_signal)            ,
    .MEM_signal    (MEM_signal)           ,
    .WB_signal     (WB_signal)
    
);

EXT U_EXT
(
    .inst          (inst_IF_ID)            ,
    
    .immout        (Imm32)
);


RF U_RF
(
    .clk           (clk)                   ,
    .rst           (rst)                   ,
    .RFWr          (WB_signal_MEM_WB[4])   ,
    .A1            (inst_IF_ID[19:15])     ,
    .A2            (inst_IF_ID[24:20])     ,   
    .inst(inst_MEM_WB),                                             
    .RD1           (RD1)                   ,
    .RD2           (RD2)                   ,
    .A3            (rd_MEM_WB)             ,                                                 
    .WD            (WD)                    
); 

ctrl_mux  ctrl_mux
(
    .EX_signal_in(EX_signal), 
    .MEM_signal_in(MEM_signal),
    .WB_signal_in(WB_signal),

    .hazard_ctrl_mux(hazard_ctrl_mux),

    .EX_signal_out( EX_signal_hazard_ctrl),
    .MEM_signal_out(MEM_signal_hazard_ctrl),
    .WB_signal_out( WB_signal_hazard_ctrl)
  
);



/************** ID_EX_register  **************/

ID_EX_Register  ID_EX
(
    .clk(clk),
    .rst(rst),
    .flush(flush),

    .pc_in(PC_IF_ID),
    .pc_out(PC_ID_EX),
    .inst_in(inst_IF_ID),
    .inst_out(inst_ID_EX),

    .EX_signal_in  (EX_signal_hazard_ctrl),
    .MEM_signal_in (MEM_signal_hazard_ctrl),
    .WB_signal_in  (WB_signal_hazard_ctrl),

    .EX_signal_out (EX_signal_ID_EX),
    .MEM_signal_out(MEM_signal_ID_EX),
    .WB_signal_out (WB_signal_ID_EX),

    .RD1_in(RD1),
    .RD2_in(RD2),

    .RD1_out(RD1_ID_EX),
    .RD2_out(RD2_ID_EX),

    .rd_in(inst_IF_ID[11:7]),
    .rd_out(rd_ID_EX),

    .imm_in(Imm32),
    .imm_out(Imm32_ID_EX),
    .Memread_in(Memread),
    .Memread_out(Memread_ID_EX)
);


/**************         EX                  ************/

forwarding forward
(
    .ID_EX_Rs1(inst_ID_EX[19:15]),
    .ID_EX_Rs2(inst_ID_EX[24:20]),
    .ID_EX_Rd(inst_ID_EX[11:7]),
    .EX_MEM_RegWrite(WB_signal_EX_MEM[4]),
    .MEM_WB_RegWrite(WB_signal_MEM_WB[4]),
    .EX_MEM_RegisterRd(rd_EX_MEM),
    .MEM_WB_RegisterRd(rd_MEM_WB),
    .forward_A(forward_A),
    .forward_B(forward_B)
);

alu_1_forward alu_1
(
    .forward_A(forward_A),
    .RD_1(RD1_ID_EX),
    .aluout(aluout_EX_MEM),
    .WD(WD),
    .alu_1(A)
);


alu_2_forward alu_2
(
    .ALUSrc(EX_signal_ID_EX[10]),
    .forward_B(forward_B),
    .RD_2(RD2_ID_EX),
    .imm(Imm32_ID_EX),
    .aluout(aluout_EX_MEM),
    .WD(WD),
    .alu_2(B_0),
    .writedata(writedata_0)
);



alu U_alu
(
    .A             (A)                          ,
    .B             (B_0)                           ,
    .ALUOp         (EX_signal_ID_EX[9:0])        ,
    .C             (aluout)                      ,
    .alu_signal    (alu_signal)  
);


branch_judge U_branch_judge
(
    .branch(MEM_signal_ID_EX[4:1]),
    .alu_signal(alu_signal),
    .NPC_out(NPCOp),
    .inst(inst_ID_EX),
    .flush(flush)
);



/************   EX_MEM_register  **************/

EX_MEM_Register EX_MEM
(
    .clk(clk),
    .rst(rst),
 

    .pc_in(PC_ID_EX),
    .pc_out(PC_EX_MEM),
    .inst_in(inst_ID_EX),
    .inst_out(inst_EX_MEM),

    .alu_signal_in(alu_signal),
    .aluout_in(aluout),

    .alu_signal_out(alu_signal_EX_MEM),
    .aluout_out(aluout_EX_MEM),

    .imm_in(Imm32_ID_EX),
    .imm_out(Imm32_EX_MEM),


    .rd_in(rd_ID_EX),
    .RD2_in(writedata_0),

    .rd_out(rd_EX_MEM),
    .RD2_out(writedata_EX_MEM),


    .MEM_signal_in(MEM_signal_ID_EX),
    .WB_signal_in (WB_signal_ID_EX),
    .MEM_signal_out(MEM_signal_EX_MEM),
    .WB_signal_out (WB_signal_EX_MEM),
    .MemWrite_out(MemWrite)

);



/************   MEM_WB_register  **************/

MEM_WB_Register MEM_WB
(
    .clk(clk),
    .rst(rst),

    .pc_in(PC_EX_MEM),
    .pc_out(PC_MEM_WB),

    .inst_in(inst_EX_MEM),
    .inst_out(inst_MEM_WB),

    .aluout_in(aluout_EX_MEM),
    .aluout_out(aluout_MEM_WB),

    .readdata_in(readdata),
    .readdata_out(readdata_MEM_WB),
    
    .rd_in(rd_EX_MEM),
    .rd_out(rd_MEM_WB), 

    .WB_signal_in (WB_signal_EX_MEM),
    .WB_signal_out (WB_signal_MEM_WB)
);


/**************         WB                  ************/

mux2 U_mux_mem2reg
(
    .mux_in1      (aluout_MEM_WB) ,                                                    
    .mux_in2      (readdata_MEM_WB) ,                                                  
    .PC           (PC_MEM_WB),                                                         
    .MemtoReg     (WB_signal_MEM_WB[3:0]),                                             
    .WD           (WD)
);

endmodule