module mux1(signal,mux_0,mux_1,mux_out)        ;


    input                 signal               ;
    input       [31:0]    mux_0                ;
    input       [31:0]    mux_1                ;

    output reg  [31:0]    mux_out              ;

always @(*) 
    begin
        case(signal)
        1'b0   :          mux_out<=mux_0       ;
        1'b1   :          mux_out<=mux_1       ;
        endcase
    end
endmodule

