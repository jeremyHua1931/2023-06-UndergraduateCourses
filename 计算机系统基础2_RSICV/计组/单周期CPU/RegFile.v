module RegFile(	
		input clk,  
		
		input rf_wen,
		
		input 	[4:0]	rf_addr_r1,//???1
		input 	[4:0]	rf_addr_r2,//???2
		
		input 	[4:0]	rf_addr_w,
		input	[31:0] 	rf_data_w,

		output 	[31:0] 	rf_data_r1, 
		output 	[31:0] 	rf_data_r2
	      );


reg [31:0] file[31:0];

integer i;

initial begin
	for(i =0;i<32;i=i+1)
	    file[i]=32'b0;
end


assign rf_data_r1 = file[rf_addr_r1];
assign rf_data_r2 = file[rf_addr_r2];

always @ (negedge clk) 
begin
	if(rf_wen) 
 	begin
		file[rf_addr_w]<=rf_data_w;
	end
end

endmodule
