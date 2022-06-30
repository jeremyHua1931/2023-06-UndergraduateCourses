/*
 IFU（Instruction Fetch Unit，取指单元）模块的功能就是从指令内存中取指令
*/
modlue IFU(
            input clk,rst,
            input alu_zero,ct_branch,ct_jump,
            output [31:0] inst 
);

reg[31:0] pc;
reg[31:0] instRom[65535:0] //指令存储空间为256KB
wire [31:0] ext_data;  //符号扩展后的值

intial $readmemh("inst.data",instRom);  //加载指令文件到存储器

assign inst=instRom[pc[17:2]]; //取指令

assign ext_data ={{16{inst[15]}},inst[15:0]};  //符号拓展

always @(posedge clk) begin
    if(!rst)
        pc<=0;
    else begin
        if(ct_jump)
             // 
        else if(ct_branch&&alu_zero)
            //
        else
            pc<=pc=4；
    end    
end

endmodule

