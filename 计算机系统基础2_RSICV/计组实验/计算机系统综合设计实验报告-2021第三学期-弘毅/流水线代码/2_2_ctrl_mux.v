module ctrl_mux (

    EX_signal_in,EX_signal_out,
    MEM_signal_in,MEM_signal_out,
    WB_signal_in,WB_signal_out,
    hazard_ctrl_mux
);

input hazard_ctrl_mux;

input [10:0]    EX_signal_in ;
input [4:0]     MEM_signal_in;
input [4:0]     WB_signal_in ;

output reg  [10:0]    EX_signal_out ;
output reg  [5:0]     MEM_signal_out;
output reg  [4:0]     WB_signal_out ;

always @(*) begin
    if(hazard_ctrl_mux)
        begin
            EX_signal_out  <= 10'b0; 
            MEM_signal_out <= 4'b0;
            WB_signal_out  <= 4'b0;
        end 
    else 
    begin
        EX_signal_out  <= EX_signal_in ; 
        MEM_signal_out <= MEM_signal_in;
        WB_signal_out  <= WB_signal_in ;
    end   
    
end
    
endmodule