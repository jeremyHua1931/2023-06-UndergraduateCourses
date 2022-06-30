// data memory
module dm( clk , DMWr , addr , addr_sign , din, dout )                                                    ;

   input                     clk                                                                          ;
   input        [ 1:0]       addr_sign                                                                    ;
   input        [ 2:0]       DMWr                                                                         ;   //写信号
   input        [ 6:0]       addr                                                                         ;   //写入地址(4)
   
   input        [31:0]       din                                                                          ;   //写入的数据
   output reg   [31:0]       dout                                                                         ;   //输出数据
     
   reg          [31:0]       dmem[127:0]                                                                  ;
   
   wire         [31:0]       data_old          =     dmem[addr[6:0]]                                      ;
   wire         [31:0]       data_old_next     =     dmem[(addr[6:0])+1]                                  ;


   // memory write
   //000  donothing
   //001  i_sw
   //010  i_sh
   //100  i_sb
 
    //写入
   always @ (posedge clk) 
        case(DMWr)
            3'b001:   //001  i_sw
                begin
                    case(addr_sign)
                    2'b00:      dmem[addr[6:0]]       <=    din                                            ; 
                    2'b01:  
                            begin 
                                dmem[addr[6:0]]       <=    {din[23:0],data_old[7:0]}                      ;  
                                dmem[(addr[6:0]+1)]   <=    {data_old_next[31:8],din[31:24]}               ; 
                            end
                    2'b10:  
                            begin 
                                dmem[addr[6:0]]       <=    {din[15:0],data_old[15:0]}                     ;  
                                dmem[(addr[6:0]+1)]   <=    {data_old_next[31:16],din[31:16]}              ; 
                            end
                    2'b11:  
                            begin 
                                dmem[addr[6:0]]       <=    {din[7:0],data_old[23:0]}                      ; 
                                dmem[(addr[6:0]+1)]   <=    {data_old_next[31:24],din[31:8]}               ; 
                            end
                endcase   
                $display("dmem[0x%8x]=0x%8x", addr<<2,din);
                $display(" ");

                end 
            3'b010:   //010  i_sh
            begin 
                case(addr_sign)
                    2'b00:      dmem[addr[6:0]]       <=    {data_old[31:16],din[15:0]}                    ; 
                    2'b01:      dmem[addr[6:0]]       <=    {data_old[31:24],din[15:0],data_old[7:0]}      ;
                    2'b10:      dmem[addr[6:0]]       <=    {din[15:0],data_old[15:0]}                     ;
                    2'b11:  
                            begin 
                                dmem[addr[6:0]]       <=    {din[7:0],data_old[23:0]}                      ;  
                                dmem[(addr[6:0]+1)]   <=    {data_old_next[31:8],din[15:8]}                ; 
                            end
                endcase   
                $display("dmem[0x%8x]=0x%8x", addr<<2,din);  
                $display(" ");                           
            end           
            3'b100://100  i_sb
            begin 
                case(addr_sign)
                    2'b00:      dmem[addr[6:0]]       <=     {data_old[31:8],din[7:0]}                     ;  
                    2'b01:      dmem[addr[6:0]]       <=     {data_old[31:16],din[7:0],data_old[7:0]}      ; 
                    2'b10:      dmem[addr[6:0]]       <=     {data_old[31:24],din[7:0],data_old[15:0]}     ;
                    2'b11:      dmem[addr[6:0]]       <=     {din[7:0],data_old[23:0]}                     ;
                endcase                                
                $display("dmem[0x%8x]=0x%8x", addr<<2,din);
                $display(" ");
            end      
           
        endcase

   
    //读出
    always @(*)begin
        case(addr_sign)
                    2'b00:      dout                  <=     {data_old[31:0]}                              ;
                    2'b01:      dout                  <=     {data_old_next[7:0],data_old[31:8]}           ;
                    2'b10:      dout                  <=     {data_old_next[15:0],data_old[31:16]}         ;
                    2'b11:      dout                  <=     {data_old_next[23:0],data_old[31:24]}         ;
        endcase
   end   
endmodule    


