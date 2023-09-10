`include "controller.v"
`include "MAN.v"
`include "MIN_D.v"
`include "Compare.v"
`include "Reg_Controller.v"
`include "Reg_MAN_state.v"
//`include "Reg_MAN.v"
`include "Reg_MIN.v"

// include else

module top(
		input clk,
		input rst,

		//實體RAM 是在top_tb建
		//RAM1					
		input [23:0] RAM1_Q,			// ram1吐data出來
		output [23:0] RAM1_D,			//trash
		output [19:0] RAM1_A,			//top 給address給ram1要資料
		output RAM1_WE,					//trash ==0
		output RAM1_OE,					//by controller

		//RAM2
		//input [23:0] RAM2_Q,
		output [23:0] RAM2_D,		//tag data
		output [19:0] RAM2_A,			//from 0~4095
		output RAM2_WE,					//==1 
		output RAM2_OE,					//trash  ==0

		//controller
		output done

	);
	

	//w_c_m
	//in
	wire w_c_m0,w_c_m1,w_c_m2,w_c_m3,w_c_m4,w_c_m5,w_c_m6,w_c_m7,w_c_m8;
	wire [23:0] w_c_m9;
	wire [2:0] w_c_m10;
	wire [1:0] w_c_m11;
	wire w_c_m12;
	wire [19:0] w_c_m13;
	//out
	wire w_c_m20,w_c_m21,w_c_m22,w_c_m23,w_c_m24,w_c_m25,w_c_m26,w_c_m27,w_c_m28;
	wire [23:0] w_c_m29;
	wire [2:0] w_c_m30;
	wire [1:0] w_c_m31;
	wire w_c_m32;
	wire [19:0] w_c_m33;


	//w_man_m
	//in
	wire [9:0] w_man0_m0,w_man0_m1,w_man0_m2,w_man0_m3,w_man0_m4,w_man0_m5,w_man0_m6,w_man0_m7; 
	wire [9:0] w_man1_m0,w_man1_m1,w_man1_m2,w_man1_m3,w_man1_m4,w_man1_m5,w_man1_m6,w_man1_m7; 
	wire [9:0] w_man2_m0,w_man2_m1,w_man2_m2,w_man2_m3,w_man2_m4,w_man2_m5,w_man2_m6,w_man2_m7; 
	wire [9:0] w_man3_m0,w_man3_m1,w_man3_m2,w_man3_m3,w_man3_m4,w_man3_m5,w_man3_m6,w_man3_m7; 
	wire [9:0] w_man4_m0,w_man4_m1,w_man4_m2,w_man4_m3,w_man4_m4,w_man4_m5,w_man4_m6,w_man4_m7; 
	wire [9:0] w_man5_m0,w_man5_m1,w_man5_m2,w_man5_m3,w_man5_m4,w_man5_m5,w_man5_m6,w_man5_m7; 
	wire [9:0] w_man6_m0,w_man6_m1,w_man6_m2,w_man6_m3,w_man6_m4,w_man6_m5,w_man6_m6,w_man6_m7; 
	wire [9:0] w_man7_m0,w_man7_m1,w_man7_m2,w_man7_m3,w_man7_m4,w_man7_m5,w_man7_m6,w_man7_m7; 

	wire [1:0] w_man_m31;
	wire w_man_m32;
	wire [19:0] w_man_m33;


	//w_min_m
	//in
	wire [9:0] w_min_m0,w_min_m1,w_min_m2,w_min_m3,w_min_m4,w_min_m5,w_min_m6,w_min_m7;
	wire [2:0] w_min_m10,w_min_m11,w_min_m12,w_min_m13,w_min_m14,w_min_m15,w_min_m16,w_min_m17;
	//out
	wire [9:0] w_min_m20,w_min_m21,w_min_m22,w_min_m23,w_min_m24,w_min_m25,w_min_m26,w_min_m27;
	wire [2:0] w_min_m30,w_min_m31,w_min_m32,w_min_m33,w_min_m34,w_min_m35,w_min_m36,w_min_m37;

	wire [1:0] w_min_m41;
	wire w_min_m42;
	wire [19:0] w_min_m43;


	//w_m_c		//min到compare
	
	wire [9:0] w_m_c4;
	wire [2:0] w_m_c5;	
	wire [23:0] w_m_c6;	//ram2_d


	//assign trash
	assign RAM1_D=24'h000000;
	assign RAM1_WE=1'b0;
	assign RAM2_OE=1'b0;
	//ram2_d
	assign RAM2_D = w_m_c6;


	controller Controller(
		.clk(clk),
		.rst(rst),
		.state_in(w_min_m41),		//from reg_min
		.done(done),		//by assign		
		.RAM1_Q(RAM1_Q),
		.RAM1_OE(RAM1_OE),
		.RAM1_A(RAM1_A),			
		.RAM2_WE_reg_in(w_min_m42),		
		.RAM2_A_reg_in(w_min_m43),
		.RAM2_WE(RAM2_WE),			//by assign
		.RAM2_A(RAM2_A),	//by assign		//原reg
		.RAM1_Q_latch(w_c_m9),		//by assign			//沒用latch  reg
		.data_en(w_c_m8),		//自己家的
		.wen0(w_c_m0),
		.wen1(w_c_m1),
		.wen2(w_c_m2),
		.wen3(w_c_m3),
		.wen4(w_c_m4),
		.wen5(w_c_m5),
		.wen6(w_c_m6),
		.wen7(w_c_m7),
		.MAN_A_WEIGHT(w_c_m10),
		.state(w_c_m11),
		.RAM2_WE_reg_out(w_c_m12),
		.RAM2_A_reg_out(w_c_m13)
	);

	Reg_Controller reg_controller(
		.clk(clk),
    	.rst(rst),         
    	.wen0_in(w_c_m0),
    	.wen1_in(w_c_m1),
    	.wen2_in(w_c_m2),
    	.wen3_in(w_c_m3),
    	.wen4_in(w_c_m4),
    	.wen5_in(w_c_m5),
    	.wen6_in(w_c_m6),
    	.wen7_in(w_c_m7),
    	.data_en_in(w_c_m8),
    	.RAM1_Q_latch_in(w_c_m9),
    	.MAN_A_WEIGHT_in(w_c_m10),
    	.state_in(w_c_m11), 
    	.RAM2_WE_reg_out_in(w_c_m12),
    	.RAM2_A_reg_out_in(w_c_m13),
    	.wen0_out(w_c_m20),
    	.wen1_out(w_c_m21),
    	.wen2_out(w_c_m22),
    	.wen3_out(w_c_m23),
    	.wen4_out(w_c_m24),
    	.wen5_out(w_c_m25),
    	.wen6_out(w_c_m26),
    	.wen7_out(w_c_m27),
    	.data_en_out(w_c_m28),
    	.RAM1_Q_latch_out(w_c_m29),
    	.MAN_A_WEIGHT_out(w_c_m30),
    	.state_out(w_c_m31),
    	.RAM2_WE_reg_out_out(w_c_m32),
    	.RAM2_A_reg_out_out(w_c_m33)
	);

	MAN man0(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m20),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man0_m0),
		.d1_out(w_man0_m1),
		.d2_out(w_man0_m2),
		.d3_out(w_man0_m3),
		.d4_out(w_man0_m4),
		.d5_out(w_man0_m5),
		.d6_out(w_man0_m6),
		.d7_out(w_man0_m7)		
	);
	MAN man1(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m21),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man1_m0),
		.d1_out(w_man1_m1),
		.d2_out(w_man1_m2),
		.d3_out(w_man1_m3),
		.d4_out(w_man1_m4),
		.d5_out(w_man1_m5),
		.d6_out(w_man1_m6),
		.d7_out(w_man1_m7)		
	);
	MAN man2(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m22),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man2_m0),
		.d1_out(w_man2_m1),
		.d2_out(w_man2_m2),
		.d3_out(w_man2_m3),
		.d4_out(w_man2_m4),
		.d5_out(w_man2_m5),
		.d6_out(w_man2_m6),
		.d7_out(w_man2_m7)		
	);
	MAN man3(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m23),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man3_m0),
		.d1_out(w_man3_m1),
		.d2_out(w_man3_m2),
		.d3_out(w_man3_m3),
		.d4_out(w_man3_m4),
		.d5_out(w_man3_m5),
		.d6_out(w_man3_m6),
		.d7_out(w_man3_m7)		
	);
	MAN man4(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m24),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man4_m0),
		.d1_out(w_man4_m1),
		.d2_out(w_man4_m2),
		.d3_out(w_man4_m3),
		.d4_out(w_man4_m4),
		.d5_out(w_man4_m5),
		.d6_out(w_man4_m6),
		.d7_out(w_man4_m7)		
	);
	MAN man5(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m25),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man5_m0),
		.d1_out(w_man5_m1),
		.d2_out(w_man5_m2),
		.d3_out(w_man5_m3),
		.d4_out(w_man5_m4),
		.d5_out(w_man5_m5),
		.d6_out(w_man5_m6),
		.d7_out(w_man5_m7)		
	);
	MAN man6(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m26),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man6_m0),
		.d1_out(w_man6_m1),
		.d2_out(w_man6_m2),
		.d3_out(w_man6_m3),
		.d4_out(w_man6_m4),
		.d5_out(w_man6_m5),
		.d6_out(w_man6_m6),
		.d7_out(w_man6_m7)		
	);
	MAN man7(
		.clk(clk),
		.rst(rst),
		.data_en(w_c_m28),		//state給   前期:data_en=0  後期:data_en=1
		.data_in(w_c_m29),			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)
		.wen(w_c_m27),						// 前期:c_en =1   後期:0
		.MAN_A_W(w_c_m30),			//what address from c_in0~c_in7
		.d0_out(w_man7_m0),
		.d1_out(w_man7_m1),
		.d2_out(w_man7_m2),
		.d3_out(w_man7_m3),
		.d4_out(w_man7_m4),
		.d5_out(w_man7_m5),
		.d6_out(w_man7_m6),
		.d7_out(w_man7_m7)		
	);

	Reg_MAN_state reg_man_state(
		.clk(clk),
        .rst(rst),
        .state_in(w_c_m31),
        .RAM2_WE_reg_out_in(w_c_m32),
        .RAM2_A_reg_out_in(w_c_m33),
        .state_out(w_man_m31),
        .RAM2_WE_reg_out_out(w_man_m32),
        .RAM2_A_reg_out_out(w_man_m33)
	);


	MIN_D min_d0(
		.d0(w_man0_m0),
		.d1(w_man0_m1),
		.d2(w_man0_m2),
		.d3(w_man0_m3),
		.d4(w_man0_m4),
		.d5(w_man0_m5),
		.d6(w_man0_m6),
		.d7(w_man0_m7),
		.d_min(w_min_m0),			//distance
		.d_min_pos(w_min_m10)
	);
	MIN_D min_d1(
		.d0(w_man1_m0),
		.d1(w_man1_m1),
		.d2(w_man1_m2),
		.d3(w_man1_m3),
		.d4(w_man1_m4),
		.d5(w_man1_m5),
		.d6(w_man1_m6),
		.d7(w_man1_m7),
		.d_min(w_min_m1),			//distance
		.d_min_pos(w_min_m11)
	);
	MIN_D min_d2(
		.d0(w_man2_m0),
		.d1(w_man2_m1),
		.d2(w_man2_m2),
		.d3(w_man2_m3),
		.d4(w_man2_m4),
		.d5(w_man2_m5),
		.d6(w_man2_m6),
		.d7(w_man2_m7),
		.d_min(w_min_m2),			//distance
		.d_min_pos(w_min_m12)
	);
	MIN_D min_d3(
		.d0(w_man3_m0),
		.d1(w_man3_m1),
		.d2(w_man3_m2),
		.d3(w_man3_m3),
		.d4(w_man3_m4),
		.d5(w_man3_m5),
		.d6(w_man3_m6),
		.d7(w_man3_m7),
		.d_min(w_min_m3),			//distance
		.d_min_pos(w_min_m13)
	);
	MIN_D min_d4(
		.d0(w_man4_m0),
		.d1(w_man4_m1),
		.d2(w_man4_m2),
		.d3(w_man4_m3),
		.d4(w_man4_m4),
		.d5(w_man4_m5),
		.d6(w_man4_m6),
		.d7(w_man4_m7),
		.d_min(w_min_m4),			//distance
		.d_min_pos(w_min_m14)
	);
	MIN_D min_d5(
		.d0(w_man5_m0),
		.d1(w_man5_m1),
		.d2(w_man5_m2),
		.d3(w_man5_m3),
		.d4(w_man5_m4),
		.d5(w_man5_m5),
		.d6(w_man5_m6),
		.d7(w_man5_m7),
		.d_min(w_min_m5),			//distance
		.d_min_pos(w_min_m15)
	);
	MIN_D min_d6(
		.d0(w_man6_m0),
		.d1(w_man6_m1),
		.d2(w_man6_m2),
		.d3(w_man6_m3),
		.d4(w_man6_m4),
		.d5(w_man6_m5),
		.d6(w_man6_m6),
		.d7(w_man6_m7),
		.d_min(w_min_m6),			//distance
		.d_min_pos(w_min_m16)
	);
	MIN_D min_d7(
		.d0(w_man7_m0),
		.d1(w_man7_m1),
		.d2(w_man7_m2),
		.d3(w_man7_m3),
		.d4(w_man7_m4),
		.d5(w_man7_m5),
		.d6(w_man7_m6),
		.d7(w_man7_m7),
		.d_min(w_min_m7),			//distance
		.d_min_pos(w_min_m17)
	);

	Reg_MIN reg_min(
		.clk(clk),
        .rst(rst),
        .d0_min_in(w_min_m0),
        .d1_min_in(w_min_m1),
        .d2_min_in(w_min_m2),
        .d3_min_in(w_min_m3),
        .d4_min_in(w_min_m4),
        .d5_min_in(w_min_m5),
        .d6_min_in(w_min_m6),
        .d7_min_in(w_min_m7),
        .d0_min_pos_in(w_min_m10),
        .d1_min_pos_in(w_min_m11),
        .d2_min_pos_in(w_min_m12),
        .d3_min_pos_in(w_min_m13),
        .d4_min_pos_in(w_min_m14),
        .d5_min_pos_in(w_min_m15),
        .d6_min_pos_in(w_min_m16),
        .d7_min_pos_in(w_min_m17),
        .state_in(w_man_m31),
        .RAM2_WE_reg_out_in(w_man_m32),
        .RAM2_A_reg_out_in(w_man_m33),
        .d0_min_out(w_min_m20),
        .d1_min_out(w_min_m21),
        .d2_min_out(w_min_m22),
        .d3_min_out(w_min_m23),
        .d4_min_out(w_min_m24),
        .d5_min_out(w_min_m25),
        .d6_min_out(w_min_m26),
        .d7_min_out(w_min_m27),
        .d0_min_pos_out(w_min_m30),
        .d1_min_pos_out(w_min_m31),
        .d2_min_pos_out(w_min_m32),
        .d3_min_pos_out(w_min_m33),
        .d4_min_pos_out(w_min_m34),
        .d5_min_pos_out(w_min_m35),
        .d6_min_pos_out(w_min_m36),
        .d7_min_pos_out(w_min_m37),
        .state_out(w_min_m41),
        .RAM2_WE_reg_out_out(w_min_m42),
        .RAM2_A_reg_out_out(w_min_m43)
	);

	MIN_D min_d8(
		.d0(w_min_m20),
		.d1(w_min_m21),
		.d2(w_min_m22),
		.d3(w_min_m23),
		.d4(w_min_m24),
		.d5(w_min_m25),
		.d6(w_min_m26),
		.d7(w_min_m27),
		.d_min(w_m_c4),			//distance
		.d_min_pos(w_m_c5)
	);

	Compare compare(
		.d8_min(w_m_c4),         //trash
    	.d8_min_pos(w_m_c5),
    	.d0_min_pos(w_min_m30),
    	.d1_min_pos(w_min_m31),
    	.d2_min_pos(w_min_m32),
    	.d3_min_pos(w_min_m33),
    	.d4_min_pos(w_min_m34),
    	.d5_min_pos(w_min_m35),
    	.d6_min_pos(w_min_m36),
    	.d7_min_pos(w_min_m37),
    	.RAM2_D(w_m_c6)
	);

	

endmodule
