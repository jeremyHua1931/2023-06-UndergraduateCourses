//RegFile
module RF( clk , rst , RFWr , A1 , A2 , A3 , WD , RD1 , RD2 ,inst)            ;

  input                        clk                                       ;
  input                        rst                                       ;
  input                        RFWr                                      ;
  input      [ 4:0]            A1                                        ;
  input      [ 4:0]            A2                                        ;
  input      [ 4:0]            A3                                        ;
  input      [31:0]            WD                                        ;
  output  wire  [31:0]            RD1                                       ;
  output  wire  [31:0]            RD2                                       ;
  input      [31:0]   inst;
               

  reg        [31:0]            rf[31:0]                                  ;

  integer      i                                                         ;

  always @(negedge clk or posedge rst)
      begin
          if (rst) 
              begin    //  reset
                    for (i=0; i<32; i=i+1)
                        rf[i] <= 0                                       ; //  i;
              end  
          else 
              if (RFWr) 
                  begin
                        rf[A3]      <=    WD                             ;
                        rf[0]       <=    32'b0                          ;
          //$display("r[00-07]=0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X", 0, rf[1], rf[2], rf[3], rf[4], rf[5], rf[6], rf[7]);
          //$display("r[08-15]=0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X", rf[8], rf[9], rf[10], rf[11], rf[12], rf[13], rf[14], rf[15]);
          //$display("r[16-23]=0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X", rf[16], rf[17], rf[18], rf[19], rf[20], rf[21], rf[22], rf[23]);
          //$display("r[24-31]=0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X, 0x%8X", rf[24], rf[25], rf[26], rf[27], rf[28], rf[29], rf[30], rf[31]);
                        if(A3!=0) 
                              begin
                                  $display("                     ") ;
                                  $display("r[%2d] = 0x%8X  ,  inst : 0x%8x  ", A3, WD,inst)  ;
                                  $display("                     ")      ;
                              end 
                  end 
             
       end

       assign           RD1     =    (A1 != 0) ? rf[A1] : 0                         ;
       assign          RD2     =    (A2 != 0) ? rf[A2] : 0                         ;

     


endmodule 
