// data memory
module dm(clka, wea, addra, dina, douta,inst);
   input          clka;
   input          wea; //写信号
   input  [31:0]  inst;
   input  [11:2]   addra; //写入地址
   input  [31:0]  dina;  //写入的数据
   output [31:0]  douta; //输出数据
   
     
   reg [31:0] dmem[127:0];
    
    //写入
   always @ (posedge clka) 
        if(wea) begin
            dmem[addra[11:2]] <= dina;
            $display("                     ") ;
            $display("dmem[0x%8X] = 0x%8X,   inst: 0x%8x", addra << 2, dina,inst); 
    end


    //读出
    assign douta = dmem[addra[11:2]];
     
   
    
endmodule    
