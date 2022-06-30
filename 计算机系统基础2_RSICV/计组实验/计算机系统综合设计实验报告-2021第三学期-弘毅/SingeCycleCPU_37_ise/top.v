`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:28:06 06/29/2021 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(

         input [3:0] BTN_y,
         input clk_100mhz,
         input RSTN,
         input [15:0] SW,
         output [4:0] BTN_x,
         output CR,
         output led_clk,
         output led_clrn,
         output LED_PEN,
         output led_sout,
         output RDY,
         output readn,
         output seg_clk,
         output seg_clrn,
         output SEG_PEN,
         output seg_sout
         );
   
   wire [31:0] Ai;
   wire [31:0] Bi;
   wire [7:0] blink;
   wire [3:0] BTN_OK;
   wire Clk_CPU;
   wire [31:0] CNT;
   wire [31:0] Disp_num;
   wire [31:0] Div;
   wire [7:0] LE_out;
   wire N0;
   wire [7:0] point_out;
   wire [3:0] Pulse;
   wire rst;
   wire [15:0] SW_OK;
   wire V5;

   wire [4:0] U9M4_Key_out;
   wire [31:0] ROMD;
   wire INV1;
   wire [31:0] RAMB;
   wire Key_ready;
   wire M4_readn;
   wire [31:0]  ram_data_in;
   wire         data_ram_we;
   wire [9:0]   ram_addr;
   wire [31:0]  ram_data_out;
   wire [31:0]  CPU2IO;
   wire         GPIOF0;
   wire [1:0]   counter_set;
   wire [15:0]  LED_out;
   wire [13:0]  GPIOf0;
   wire [31:0]  inst;
   wire [31:0]  Data_in;
   wire [31:0]  Data_out;
   wire [31:0]  Addr_out;
   wire         mem_w;
   wire [31:0]  PC;
   wire [31:0]  Counter_out;
   wire         counter0_OUT;
   wire         counter1_OUT;
   wire         counter2_OUT;
   wire         GPIOe0000000_we;
   wire         counter_we;

   
   assign RDY = Key_ready;
   assign readn = M4_readn;

   SCPU U1
   (	
      .clk(Clk_CPU),			
	   .rst(rst),
	   .instr(ROMD),
	   .readdata(Data_in),	
	   .MemWrite(mem_w),
	   .PC(PC),
	   .aluout(Addr_out),
	   .writedata(Data_out), 
	   .CPU_MIO(),
		.MIO_ready(),
	   .INT(counter0_OUT)
	);

   ROM_D  U2 
   (
       .a(PC[11:2]), 
       .spo(ROMD[31:0])
    );


   RAM_B  U3 
   (
       .addra(ram_addr), 
        .clka(~clk_100mhz), 
        .dina(ram_data_in), 
        .wea(data_ram_we), 
        .douta(RAMB[31:0])
    );

   MIO_BUS U4
   ( 
        .clk(clk_100mhz),
		.rst(rst),
		.BTN(BTN_OK),
		.SW(SW_OK),
		.mem_w(mem_w),
		.Cpu_data2bus(Data_out),				//data from CPU
		.addr_bus(Addr_out),
		.ram_data_out(RAMB),
		.led_out(LED_out),
		.counter_out(Counter_out),
		.counter0_out(counter0_OUT),
		.counter1_out(counter1_OUT),
		.counter2_out(counter2_OUT),
		.Cpu_data4bus(Data_in),				//write to CPU
		.ram_data_in(ram_data_in),				//from CPU write to Memory
		.ram_addr(ram_addr),						//Memory Address signals
		.data_ram_we(data_ram_we),
		.GPIOf0000000_we(GPIOF0),
		.GPIOe0000000_we(GPIOe0000000_we),
		.counter_we(counter_we),
		.Peripheral_in(CPU2IO)
	);


   SEnter_2_32  M4 
   (
       .BTN(BTN_OK[2:0]), 
        .clk(clk_100mhz), 
        .Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}), 
        .Din(U9M4_Key_out), 
        .D_ready(Key_ready), 
        .Ai(Ai), 
        .Bi(Bi), 
        .blink(blink), 
        .readn(M4_readn)
     );

   Multi_8CH32  U5 
   (
       .clk(clk_100mhz), 
       .Data0(CPU2IO), 
       .data1({N0,N0,PC[31:2]}), 
       .data2(ROMD), 
       .data3(Counter_out), 
       .data4(Addr_out), 
       .data5(Data_out), 
       .data6(Data_in), 
       .data7(PC), 
       .EN(GPIOe0000000_we),                   //from U4 GPIOe0000000_we
       .LES({64{1'b0}}), 
       .point_in({Div[31:0], Div[31:0]}), 
       .rst(rst), 
       .Test(SW_OK[7:5]), 
       .Disp_num(Disp_num[31:0]), 
       .LE_out(LE_out[7:0]), 
       .point_out(point_out[7:0])
    );


   SSeg7_Dev  U6 
   (
       .clk(clk_100mhz), 
        .flash(Div[25]), 
        .Hexs(Disp_num[31:0]), 
        .LES(LE_out[7:0]), 
        .point(point_out[7:0]), 
        .rst(rst), 
        .Start(Div[20]), 
        .SW0(SW_OK[0]), 
        .seg_clk(seg_clk), 
        .seg_clrn(seg_clrn), 
        .SEG_PEN(SEG_PEN), 
        .seg_sout(seg_sout)
    );

   SPIO  U7 
   (
       .clk(clk_100mhz), 
       .EN(GPIOF0),       //from U4
       .P_Data(CPU2IO), 
       .rst(rst), 
       .Start(Div[20]), 
       .counter_set(counter_set), 
       .GPIOf0(GPIOf0), 
       .led_clk(led_clk), 
       .led_clrn(led_clrn), 
       .LED_out(LED_out), 
       .LED_PEN(LED_PEN), 
       .led_sout(led_sout)
    );

   clk_div  U8 
   (
        .clk(clk_100mhz), 
        .rst(rst), 
        .SW2(SW_OK[2]), 
        .clkdiv(Div[31:0]), 
        .Clk_CPU(Clk_CPU)
    );

   SAnti_jitter  U9 
   (
       .clk(clk_100mhz),                 
       .Key_y(BTN_y[3:0]), 
       .readn(M4_readn), 
       .RSTN(RSTN), 
       .SW(SW[15:0]), 
       .BTN_OK(BTN_OK[3:0]), 
       .CR(CR), 
       .Key_out(U9M4_Key_out), 
       .Key_ready(Key_ready), 
       .Key_x(BTN_x[4:0]), 
       .pulse_out(Pulse[3:0]), 
       .rst(rst), 
       .SW_OK(SW_OK[15:0])
     );

   Counter_x U10
   (
       .clk(clk_100mhz),
	   .rst(rst),
	   .clk0(Div[6]),
	   .clk1(Div[9]),
	   .clk2(Div[11]),
	   .counter_we(counter_we),
	   .counter_val(CPU2IO),
	   .counter_ch(counter_set),				//Counter channel set
       .counter0_OUT(counter0_OUT),
	   .counter1_OUT(counter1_OUT),
	   .counter2_OUT(counter2_OUT),
	   .counter_out(Counter_out)
	);


endmodule
