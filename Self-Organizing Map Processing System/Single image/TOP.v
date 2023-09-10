/////////////////////////////////////////////////////////////////////
// ---------------------- IVCAD 2022 Spring ---------------------- //
// ---------------------- Version : v.1.10  ---------------------- //
// ---------------------- Date : 2022.04.13 ---------------------- //
// ------------------------ TOP module ----------------------------//
// ----------------- Feb. 2022 Willie authored --------------------//
/////////////////////////////////////////////////////////////////////

`include "VEP.v"
`include "MIN_1.v"
`include "MIN_2.v"
`include "USS.v"
`include "Controller.v"
`include "Mux.v"

module TOP(clk, rst, RAM_IF_Q, RAM_W_Q, RAM_RESULT_Q, RAM_IF_OE, RAM_IF_WE, RAM_IF_A, RAM_IF_D,
		RAM_W_OE, RAM_W_WE, RAM_W_A, RAM_W_D, RAM_RESULT_OE, RAM_RESULT_WE, RAM_RESULT_A, RAM_RESULT_D, done);

// ---------------------- input  ---------------------- //
	input clk;
	input rst;
	input [23:0] RAM_IF_Q;
	input [23:0] RAM_W_Q;
	input [23:0] RAM_RESULT_Q;
	
// ---------------------- output  ---------------------- //	
	output RAM_IF_OE;
	output RAM_IF_WE;
	output [17:0] RAM_IF_A;
	output [23:0] RAM_IF_D;
	output RAM_W_OE;
	output RAM_W_WE;
	output [17:0] RAM_W_A;
	output [23:0] RAM_W_D;
	output RAM_RESULT_OE;
	output RAM_RESULT_WE;
	output [17:0] RAM_RESULT_A;
	output [23:0] RAM_RESULT_D;
	output done;

// ---------------------- Write down Your design below  ---------------------- //
	//trash
	assign RAM_IF_D=24'd0;
	assign RAM_IF_WE=1'd0;
	assign RAM_W_OE=1'd0;
	assign RAM_RESULT_OE=1'd0;

	//vep min
	wire [9:0] w_u_v010,w_u_v011,w_u_v012,w_u_v013,w_u_v014,w_u_v015,w_u_v016,w_u_v017;
	wire [23:0]w_u_v020,w_u_v021,w_u_v022,w_u_v023,w_u_v024,w_u_v025,w_u_v026,w_u_v027;

	wire [9:0] w_u_v110,w_u_v111,w_u_v112,w_u_v113,w_u_v114,w_u_v115,w_u_v116,w_u_v117;
	wire [23:0]w_u_v120,w_u_v121,w_u_v122,w_u_v123,w_u_v124,w_u_v125,w_u_v126,w_u_v127;

	wire [9:0] w_u_v210,w_u_v211,w_u_v212,w_u_v213,w_u_v214,w_u_v215,w_u_v216,w_u_v217;
	wire [23:0]w_u_v220,w_u_v221,w_u_v222,w_u_v223,w_u_v224,w_u_v225,w_u_v226,w_u_v227;

	wire [9:0] w_u_v310,w_u_v311,w_u_v312,w_u_v313,w_u_v314,w_u_v315,w_u_v316,w_u_v317;
	wire [23:0]w_u_v320,w_u_v321,w_u_v322,w_u_v323,w_u_v324,w_u_v325,w_u_v326,w_u_v327;

	wire [9:0] w_u_v410,w_u_v411,w_u_v412,w_u_v413,w_u_v414,w_u_v415,w_u_v416,w_u_v417;
	wire [23:0]w_u_v420,w_u_v421,w_u_v422,w_u_v423,w_u_v424,w_u_v425,w_u_v426,w_u_v427;

	wire [9:0] w_u_v510,w_u_v511,w_u_v512,w_u_v513,w_u_v514,w_u_v515,w_u_v516,w_u_v517;
	wire [23:0]w_u_v520,w_u_v521,w_u_v522,w_u_v523,w_u_v524,w_u_v525,w_u_v526,w_u_v527;

	wire [9:0] w_u_v610,w_u_v611,w_u_v612,w_u_v613,w_u_v614,w_u_v615,w_u_v616,w_u_v617;
	wire [23:0]w_u_v620,w_u_v621,w_u_v622,w_u_v623,w_u_v624,w_u_v625,w_u_v626,w_u_v627;

	wire [9:0] w_u_v710,w_u_v711,w_u_v712,w_u_v713,w_u_v714,w_u_v715,w_u_v716,w_u_v717;
	wire [23:0]w_u_v720,w_u_v721,w_u_v722,w_u_v723,w_u_v724,w_u_v725,w_u_v726,w_u_v727;

	//min min
	wire [9:0]w_m_m00;
	wire [2:0]w_m_m01;
	wire [23:0]w_m_m02;

	wire [9:0]w_m_m10;
	wire [2:0]w_m_m11;
	wire [23:0]w_m_m12;

	wire [9:0]w_m_m20;
	wire [2:0]w_m_m21;
	wire [23:0]w_m_m22;

	wire [9:0]w_m_m30;
	wire [2:0]w_m_m31;
	wire [23:0]w_m_m32;

	wire [9:0]w_m_m40;
	wire [2:0]w_m_m41;
	wire [23:0]w_m_m42;

	wire [9:0]w_m_m50;
	wire [2:0]w_m_m51;
	wire [23:0]w_m_m52;

	wire [9:0]w_m_m60;
	wire [2:0]w_m_m61;
	wire [23:0]w_m_m62;

	wire [9:0]w_m_m70;
	wire [2:0]w_m_m71;
	wire [23:0]w_m_m72;


	//min uss
	wire [2:0] w_m_u0;
	wire [2:0] w_m_u1;
	wire [2:0] w_m_u10,w_m_u11,w_m_u12,w_m_u13,w_m_u14,w_m_u15,w_m_u16,w_m_u17;

	assign  w_m_u10=3'd0;
	assign  w_m_u11=3'd1;
	assign  w_m_u12=3'd2;
	assign  w_m_u13=3'd3;
	assign  w_m_u14=3'd4;
	assign  w_m_u15=3'd5;
	assign  w_m_u16=3'd6;
	assign  w_m_u17=3'd7;



	//uss vep
	/*
	wire [1:0] w_u_v00,w_u_v01,w_u_v02,w_u_v03,w_u_v04,w_u_v05,w_u_v06,w_u_v07;
																														//
	wire [1:0] w_u_v10,w_u_v11,w_u_v12,w_u_v13,w_u_v14,w_u_v15,w_u_v16,w_u_v17;
																														//
	wire [1:0] w_u_v20,w_u_v21,w_u_v22,w_u_v23,w_u_v24,w_u_v25,w_u_v26,w_u_v27;
																														//
	wire [1:0] w_u_v30,w_u_v31,w_u_v32,w_u_v33,w_u_v34,w_u_v35,w_u_v36,w_u_v37;
																														//
	wire [1:0] w_u_v40,w_u_v41,w_u_v42,w_u_v43,w_u_v44,w_u_v45,w_u_v46,w_u_v47;
																															//																												
	wire [1:0] w_u_v50,w_u_v51,w_u_v52,w_u_v53,w_u_v54,w_u_v55,w_u_v56,w_u_v57;
																														//
	wire [1:0] w_u_v60,w_u_v61,w_u_v62,w_u_v63,w_u_v64,w_u_v65,w_u_v66,w_u_v67;
																														//
	wire [1:0] w_u_v70,w_u_v71,w_u_v72,w_u_v73,w_u_v74,w_u_v75,w_u_v76,w_u_v77;
																														//
	*/
	wire [15:0] w_u_v0;
	wire [15:0] w_u_v1;																											
	wire [15:0] w_u_v2;																											
	wire [15:0] w_u_v3;																											
	wire [15:0] w_u_v4;																											
	wire [15:0] w_u_v5;																											
	wire [15:0] w_u_v6;																											
	wire [15:0] w_u_v7;																											

	//controller
	wire w_c0;
	wire w_c1;//trash

	//module
	Controller controller(
		.clk(clk), 
		.rst(rst), 
		.W_update_latch(w_c0), 
		.D_update(w_c1),
		.RAM_IF_A(RAM_IF_A), 
		.RAM_IF_OE(RAM_IF_OE), 
		.RAM_W_A(RAM_W_A), 
		.RAM_W_WE(RAM_W_WE), 
		.RAM_RESULT_A(RAM_RESULT_A), 
		.RAM_RESULT_WE(RAM_RESULT_WE), 
		.done(done)
	);

	
	VEP vep0(
			.clk(clk), 
			.rst(rst), 
			.W_update(w_c0), 
			.D_update(w_c1),
			.neighbor_sel(w_u_v0),
			.pixel(RAM_IF_Q),
			.d0(w_u_v010), 
			.d1(w_u_v011), 
			.d2(w_u_v012), 
			.d3(w_u_v013), 
			.d4(w_u_v014), 
			.d5(w_u_v015), 
			.d6(w_u_v016), 
			.d7(w_u_v017),
			.w0(w_u_v020), 
			.w1(w_u_v021), 
			.w2(w_u_v022), 
			.w3(w_u_v023), 
			.w4(w_u_v024), 
			.w5(w_u_v025), 
			.w6(w_u_v026), 
			.w7(w_u_v027)	
			);
	VEP vep1(
			.clk(clk), 
			.rst(rst), 
			.W_update(w_c0), 
			.D_update(w_c1),
			.neighbor_sel(w_u_v1),
			.pixel(RAM_IF_Q),
			.d0(w_u_v110), 
			.d1(w_u_v111), 
			.d2(w_u_v112), 
			.d3(w_u_v113), 
			.d4(w_u_v114), 
			.d5(w_u_v115), 
			.d6(w_u_v116), 
			.d7(w_u_v117),
			.w0(w_u_v120), 
			.w1(w_u_v121), 
			.w2(w_u_v122), 
			.w3(w_u_v123), 
			.w4(w_u_v124), 
			.w5(w_u_v125), 
			.w6(w_u_v126), 
			.w7(w_u_v127)	
			);
	VEP vep2(
			.clk(clk), 
			.rst(rst), 
			.W_update(w_c0), 
			.D_update(w_c1),
			.neighbor_sel(w_u_v2),
			.pixel(RAM_IF_Q),
			.d0(w_u_v210), 
			.d1(w_u_v211), 
			.d2(w_u_v212), 
			.d3(w_u_v213), 
			.d4(w_u_v214), 
			.d5(w_u_v215), 
			.d6(w_u_v216), 
			.d7(w_u_v217),
			.w0(w_u_v220), 
			.w1(w_u_v221), 
			.w2(w_u_v222), 
			.w3(w_u_v223), 
			.w4(w_u_v224), 
			.w5(w_u_v225), 
			.w6(w_u_v226), 
			.w7(w_u_v227)	
			);
	VEP vep3(
			.clk(clk), 
			.rst(rst), 
			.W_update(w_c0), 
			.D_update(w_c1),
			.neighbor_sel(w_u_v3),
			.pixel(RAM_IF_Q),
			.d0(w_u_v310), 
			.d1(w_u_v311), 
			.d2(w_u_v312), 
			.d3(w_u_v313), 
			.d4(w_u_v314), 
			.d5(w_u_v315), 
			.d6(w_u_v316), 
			.d7(w_u_v317),
			.w0(w_u_v320), 
			.w1(w_u_v321), 
			.w2(w_u_v322), 
			.w3(w_u_v323), 
			.w4(w_u_v324), 
			.w5(w_u_v325), 
			.w6(w_u_v326), 
			.w7(w_u_v327)	
			);
	VEP vep4(
			.clk(clk), 
			.rst(rst), 
			.D_update(w_c1),
			.W_update(w_c0), 			
			.neighbor_sel(w_u_v4),
			.pixel(RAM_IF_Q),
			.d0(w_u_v410), 
			.d1(w_u_v411), 
			.d2(w_u_v412), 
			.d3(w_u_v413), 
			.d4(w_u_v414), 
			.d5(w_u_v415), 
			.d6(w_u_v416), 
			.d7(w_u_v417),
			.w0(w_u_v420), 
			.w1(w_u_v421), 
			.w2(w_u_v422), 
			.w3(w_u_v423), 
			.w4(w_u_v424), 
			.w5(w_u_v425), 
			.w6(w_u_v426), 
			.w7(w_u_v427)	
			);
	VEP vep5(
			.clk(clk), 
			.rst(rst), 
			.D_update(w_c1),
			.W_update(w_c0), 
			.neighbor_sel(w_u_v5),
			.pixel(RAM_IF_Q),
			.d0(w_u_v510), 
			.d1(w_u_v511), 
			.d2(w_u_v512), 
			.d3(w_u_v513), 
			.d4(w_u_v514), 
			.d5(w_u_v515), 
			.d6(w_u_v516), 
			.d7(w_u_v517),
			.w0(w_u_v520), 
			.w1(w_u_v521), 
			.w2(w_u_v522), 
			.w3(w_u_v523), 
			.w4(w_u_v524), 
			.w5(w_u_v525), 
			.w6(w_u_v526), 
			.w7(w_u_v527)	
			);
	VEP vep6(
			.clk(clk), 
			.rst(rst), 
			.D_update(w_c1),
			.W_update(w_c0), 
			.neighbor_sel(w_u_v6),
			.pixel(RAM_IF_Q),
			.d0(w_u_v610), 
			.d1(w_u_v611), 
			.d2(w_u_v612), 
			.d3(w_u_v613), 
			.d4(w_u_v614), 
			.d5(w_u_v615), 
			.d6(w_u_v616), 
			.d7(w_u_v617),
			.w0(w_u_v620), 
			.w1(w_u_v621), 
			.w2(w_u_v622), 
			.w3(w_u_v623), 
			.w4(w_u_v624), 
			.w5(w_u_v625), 
			.w6(w_u_v626), 
			.w7(w_u_v627)	
			);
	VEP vep7(
			.clk(clk), 
			.rst(rst), 
			.W_update(w_c0), 
			.D_update(w_c1),
			.neighbor_sel(w_u_v7),
			.pixel(RAM_IF_Q),
			.d0(w_u_v710), 
			.d1(w_u_v711), 
			.d2(w_u_v712), 
			.d3(w_u_v713), 
			.d4(w_u_v714), 
			.d5(w_u_v715), 
			.d6(w_u_v716), 
			.d7(w_u_v717),
			.w0(w_u_v720), 
			.w1(w_u_v721), 
			.w2(w_u_v722), 
			.w3(w_u_v723), 
			.w4(w_u_v724), 
			.w5(w_u_v725), 
			.w6(w_u_v726), 
			.w7(w_u_v727)	
			);

	Mux mux(
			.i0(w_u_v020),
			.i1(w_u_v021),
			.i2(w_u_v022),
			.i3(w_u_v023),
			.i4(w_u_v024),
			.i5(w_u_v025),
			.i6(w_u_v026),
			.i7(w_u_v027),
			.i8(w_u_v120),
			.i9(w_u_v121), 
            .i10(w_u_v122),
			.i11(w_u_v123),
			.i12(w_u_v124),
			.i13(w_u_v125),
			.i14(w_u_v126),
			.i15(w_u_v127),
			.i16(w_u_v220),
			.i17(w_u_v221),
			.i18(w_u_v222),
			.i19(w_u_v223), 
            .i20(w_u_v224),
			.i21(w_u_v225),
			.i22(w_u_v226),
			.i23(w_u_v227),
			.i24(w_u_v320),
			.i25(w_u_v321),
			.i26(w_u_v322),
			.i27(w_u_v323),
			.i28(w_u_v324),
			.i29(w_u_v325), 
            .i30(w_u_v326),
			.i31(w_u_v327),
			.i32(w_u_v420),
			.i33(w_u_v421),
			.i34(w_u_v422),
			.i35(w_u_v423),
			.i36(w_u_v424),
			.i37(w_u_v425),
			.i38(w_u_v426),
			.i39(w_u_v427), 
            .i40(w_u_v520),
			.i41(w_u_v521),
			.i42(w_u_v522),
			.i43(w_u_v523),
			.i44(w_u_v524),
			.i45(w_u_v525),
			.i46(w_u_v526),
			.i47(w_u_v527),
			.i48(w_u_v620),
			.i49(w_u_v621), 
            .i50(w_u_v622),
			.i51(w_u_v623),
			.i52(w_u_v624),
			.i53(w_u_v625),
			.i54(w_u_v626),
			.i55(w_u_v627),
			.i56(w_u_v720),
			.i57(w_u_v721),
			.i58(w_u_v722),
			.i59(w_u_v723), 
            .i60(w_u_v724),
			.i61(w_u_v725),
			.i62(w_u_v726),
			.i63(w_u_v727),
			.sel(RAM_W_A[5:0]),
			.o(RAM_W_D)
			);
	

	MIN_1 min1_1_0(
			.d0(w_u_v010), 
			.d1(w_u_v011), 
			.d2(w_u_v012), 
			.d3(w_u_v013), 
			.d4(w_u_v014), 
			.d5(w_u_v015), 
			.d6(w_u_v016), 
			.d7(w_u_v017),
			.w0(w_u_v020), 
			.w1(w_u_v021), 
			.w2(w_u_v022), 
			.w3(w_u_v023), 
			.w4(w_u_v024), 
			.w5(w_u_v025), 
			.w6(w_u_v026), 
			.w7(w_u_v027),	
			.d_min(w_m_m00),
	 		.d_min_index(w_m_m01),
			.w_min(w_m_m02)
	);
	MIN_1 min1_1_1(
			.d0(w_u_v110), 
			.d1(w_u_v111), 
			.d2(w_u_v112), 
			.d3(w_u_v113), 
			.d4(w_u_v114), 
			.d5(w_u_v115), 
			.d6(w_u_v116), 
			.d7(w_u_v117),
			.w0(w_u_v120), 
			.w1(w_u_v121), 
			.w2(w_u_v122), 
			.w3(w_u_v123), 
			.w4(w_u_v124), 
			.w5(w_u_v125), 
			.w6(w_u_v126), 
			.w7(w_u_v127),	
			.d_min(w_m_m10),
	 		.d_min_index(w_m_m11),
			.w_min(w_m_m12)
	);
	MIN_1 min1_1_2(
			.d0(w_u_v210), 
			.d1(w_u_v211), 
			.d2(w_u_v212), 
			.d3(w_u_v213), 
			.d4(w_u_v214), 
			.d5(w_u_v215), 
			.d6(w_u_v216), 
			.d7(w_u_v217),
			.w0(w_u_v220), 
			.w1(w_u_v221), 
			.w2(w_u_v222), 
			.w3(w_u_v223), 
			.w4(w_u_v224), 
			.w5(w_u_v225), 
			.w6(w_u_v226), 
			.w7(w_u_v227),	
			.d_min(w_m_m20),
	 		.d_min_index(w_m_m21),
			.w_min(w_m_m22)
	);
	MIN_1 min1_1_3(
			.d0(w_u_v310), 
			.d1(w_u_v311), 
			.d2(w_u_v312), 
			.d3(w_u_v313), 
			.d4(w_u_v314), 
			.d5(w_u_v315), 
			.d6(w_u_v316), 
			.d7(w_u_v317),
			.w0(w_u_v320), 
			.w1(w_u_v321), 
			.w2(w_u_v322), 
			.w3(w_u_v323), 
			.w4(w_u_v324), 
			.w5(w_u_v325), 
			.w6(w_u_v326), 
			.w7(w_u_v327),	
			.d_min(w_m_m30),
	 		.d_min_index(w_m_m31),
			.w_min(w_m_m32)
	);
	MIN_1 min1_1_4(
			.d0(w_u_v410), 
			.d1(w_u_v411), 
			.d2(w_u_v412), 
			.d3(w_u_v413), 
			.d4(w_u_v414), 
			.d5(w_u_v415), 
			.d6(w_u_v416), 
			.d7(w_u_v417),
			.w0(w_u_v420), 
			.w1(w_u_v421), 
			.w2(w_u_v422), 
			.w3(w_u_v423), 
			.w4(w_u_v424), 
			.w5(w_u_v425), 
			.w6(w_u_v426), 
			.w7(w_u_v427),	
			.d_min(w_m_m40),
	 		.d_min_index(w_m_m41),
			.w_min(w_m_m42)
	);
	MIN_1 min1_1_5(
			.d0(w_u_v510), 
			.d1(w_u_v511), 
			.d2(w_u_v512), 
			.d3(w_u_v513), 
			.d4(w_u_v514), 
			.d5(w_u_v515), 
			.d6(w_u_v516), 
			.d7(w_u_v517),
			.w0(w_u_v520), 
			.w1(w_u_v521), 
			.w2(w_u_v522), 
			.w3(w_u_v523), 
			.w4(w_u_v524), 
			.w5(w_u_v525), 
			.w6(w_u_v526), 
			.w7(w_u_v527),	
			.d_min(w_m_m50),
	 		.d_min_index(w_m_m51),
			.w_min(w_m_m52)
	);
	MIN_1 min1_1_6(
			.d0(w_u_v610), 
			.d1(w_u_v611), 
			.d2(w_u_v612), 
			.d3(w_u_v613), 
			.d4(w_u_v614), 
			.d5(w_u_v615), 
			.d6(w_u_v616), 
			.d7(w_u_v617),
			.w0(w_u_v620), 
			.w1(w_u_v621), 
			.w2(w_u_v622), 
			.w3(w_u_v623), 
			.w4(w_u_v624), 
			.w5(w_u_v625), 
			.w6(w_u_v626), 
			.w7(w_u_v627),	
			.d_min(w_m_m60),
	 		.d_min_index(w_m_m61),
			.w_min(w_m_m62)
	);
	MIN_1 min1_1_7(
			.d0(w_u_v710), 
			.d1(w_u_v711), 
			.d2(w_u_v712), 
			.d3(w_u_v713), 
			.d4(w_u_v714), 
			.d5(w_u_v715), 
			.d6(w_u_v716), 
			.d7(w_u_v717),
			.w0(w_u_v720), 
			.w1(w_u_v721), 
			.w2(w_u_v722), 
			.w3(w_u_v723), 
			.w4(w_u_v724), 
			.w5(w_u_v725), 
			.w6(w_u_v726), 
			.w7(w_u_v727),	
			.d_min(w_m_m70),
	 		.d_min_index(w_m_m71),
			.w_min(w_m_m72)
	);

	MIN_2 min_2(
			.d0(w_m_m00),
			.d1(w_m_m10),
			.d2(w_m_m20),
			.d3(w_m_m30),
			.d4(w_m_m40),
			.d5(w_m_m50),
			.d6(w_m_m60),
			.d7(w_m_m70),
			.w0(w_m_m02),
			.w1(w_m_m12),
			.w2(w_m_m22),
			.w3(w_m_m32),
			.w4(w_m_m42),
			.w5(w_m_m52),
			.w6(w_m_m62),
			.w7(w_m_m72),
			.index0(w_m_m01),
			.index1(w_m_m11),
			.index2(w_m_m21),
			.index3(w_m_m31),
			.index4(w_m_m41),
			.index5(w_m_m51),
			.index6(w_m_m61),
			.index7(w_m_m71),
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.weight_c(RAM_RESULT_D)
	);

	USS uss0(
			.X_in(w_m_u10),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v0)
	);
	USS uss1(
			.X_in(w_m_u11),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v1)
	);
	USS uss2(
			.X_in(w_m_u12),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v2)
	);
	USS uss3(
			.X_in(w_m_u13),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v3)

	);
	USS uss4(
			.X_in(w_m_u14),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v4)
	);
	USS uss5(
			.X_in(w_m_u15),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v5)

	);
	USS uss6(
			.X_in(w_m_u16),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v6)
	);
	USS uss7(
			.X_in(w_m_u17),			//const  sol : improve tb
			.X_c(w_m_u0),
			.Y_c(w_m_u1),
			.neighbor_sel(w_u_v7)
	);



endmodule
