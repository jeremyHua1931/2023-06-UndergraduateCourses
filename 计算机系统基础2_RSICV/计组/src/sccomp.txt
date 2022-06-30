// top_comp
module sccomp( clk, rstn)                        ;

   input                  clk                    ;
   input                  rstn                   ; 
   
   
   wire    [31:0]         instr                  ;
   wire    [31:0]         PC                     ;
   wire    [ 2:0]         MemWrite               ;
   wire    [31:0]         dm_addr                ;
   wire    [31:0]         dm_din                 ;
   wire    [31:0]         dm_dout                ;
   
   wire rst = ~rstn;
       
   
   sccpu   U_SCPU
   (
      .clk        (clk)                          ,   // input:  cpu clock
      .rst        (rst)                          ,   // input:  reset
      .instr      (instr)                        ,   // input:  instruction
      .readdata   (dm_dout)                      ,   // input:  data to cpu  
      .MemWrite   (MemWrite)                     ,   // output: memory write signal
      .PC         (PC)                           ,   // output: PC
      .aluout     (dm_addr)                      ,   // output: address from cpu to memory
      .writedata  (dm_din)                           // output: data from cpu to memory
    );
         
 
   dm      U_DM
   (
      .clk        (clk)                         ,    // input:  cpu clock
      .DMWr       (MemWrite)                    ,    // input:  ram write
      .addr       (dm_addr[8:2])                ,    // input:  ram address
      .addr_sign  (dm_addr[1:0])                ,
      .din        (dm_din)                      ,    // input:  data to ram
      .dout       (dm_dout)                          // output: data from ram
   );
         
  
   im     U_IM 
   ( 
      .addr       (PC)                          ,    // input:  rom address
      .dout       (instr)                            // output: instruction
   );
        
endmodule

