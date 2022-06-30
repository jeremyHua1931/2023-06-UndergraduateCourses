// top_comp
module sccomp( clk, rstn)                        ;

   input                  clk                    ;
   input                  rstn                   ; 
   
   
   wire    [31:0]         instr                  ;
   wire    [31:0]         PC                     ;
   wire            MemWrite               ;
   wire    [31:0]         dm_addr                ;
   wire    [31:0]         dm_din                 ;
   wire    [31:0]         dm_dout                ;
   wire    [31:0]         inst_DM;
   
   wire rst = ~rstn;
       
   
   sccpu   U_SCPU
   (
      .clk        (clk)                          ,   // input:  cpu clock
      .rst        (rst)                          ,   // input:  reset
      .inst    (instr)                        ,   // input:  instruction
      .readdata   (dm_dout)                      ,   // input:  data to cpu  
      
      .MemWrite   (MemWrite)                     ,   // output: memory write signal
      .PC         (PC)                           ,   // output: PC
      .aluout_EX_MEM (dm_addr)                      ,   // output: address from cpu to memory
      .writedata_EX_MEM (dm_din)  ,                         // output: data from cpu to memory
      .inst_MEM_WB(inst_DM)
    );
         
 
   dm      U_DM
   (
      .clka   (clk)                         ,    // input:  cpu clock
      .wea    (MemWrite)                    ,    // input:  ram write
      .addra  (dm_addr[11:2])                ,    // input:  ram address
                    
      .dina   (dm_din)                      ,    // input:  data to ram
      .douta  (dm_dout)                      ,    // output: data from ram
      .inst(inst_DM)
   );
         
  
   im     U_IM 
   ( 
      .a       (PC[11:2])                          ,    // input:  rom address
      .spo      (instr)                            // output: instruction
   );
        
endmodule

