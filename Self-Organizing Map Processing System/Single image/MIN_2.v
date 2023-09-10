/////////////////////////////////////////////////////////////////////
// ---------------------- IVCAD 2022 Spring ---------------------- //
// ---------------------- Version : v.1.10  ---------------------- //
// ---------------------- Date : 2022.04.13 ---------------------- //
// ------------------------ MIN_2 module --------------------------//
// ----------------- Feb. 2022 Willie authored --------------------//
/////////////////////////////////////////////////////////////////////

module MIN_2(d0,d1,d2,d3,d4,d5,d6,d7,w0,w1,w2,w3,w4,w5,w6,w7,index0,index1,index2,index3,index4,index5,index6,index7,X_c,Y_c,weight_c);		//clk,rst,

// ---------------------- input  ---------------------- //
	//input clk;
	//input rst;
	input [9:0] d0;
	input [9:0] d1;
	input [9:0] d2;
	input [9:0] d3;
	input [9:0] d4;
	input [9:0] d5;
	input [9:0] d6;
	input [9:0] d7;
	input [23:0] w0;
	input [23:0] w1;
	input [23:0] w2;
	input [23:0] w3;
	input [23:0] w4;
	input [23:0] w5;
	input [23:0] w6;
	input [23:0] w7;
	input [2:0] index0;
	input [2:0] index1;
	input [2:0] index2;
	input [2:0] index3;
	input [2:0] index4;
	input [2:0] index5;
	input [2:0] index6;
	input [2:0] index7;
// ---------------------- output  ---------------------- //
	output  [2:0] X_c;
	output  [2:0] Y_c;
	output  [23:0] weight_c;
	
// ---------------------- Write down Your design below  ---------------------- //
  	wire [9:0] m1,m2,m3,m4,m5,m6;
	wire [9:0] d_min;


	//combinational
	assign m1 = (d0<d1) ? d0 : d1;
  	assign m2 = (d2<d3) ? d2 : d3;
  	assign m3 = (d4<d5) ? d4 : d5;
  	assign m4 = (d6<d7) ? d6 : d7;
  	assign m5 = (m1<m2) ? m1 : m2;
  	assign m6 = (m3<m4) ? m3 : m4;
  	assign d_min = (m5<m6) ? m5 : m6;

	//XY corodinate
  	assign X_c =	(d_min==d7) ? 3'd7 :
                    (d_min==d6) ? 3'd6 :
                    (d_min==d5) ? 3'd5 :
                    (d_min==d4) ? 3'd4 :
                    (d_min==d3) ? 3'd3 :
                    (d_min==d2) ? 3'd2 :
                    (d_min==d1) ? 3'd1 : 3'd0;
					
	assign Y_c =    (d_min==d7) ? index7 :
                    (d_min==d6) ? index6 :
                    (d_min==d5) ? index5 :
                    (d_min==d4) ? index4 :
                    (d_min==d3) ? index3 :
                    (d_min==d2) ? index2 :
                    (d_min==d1) ? index1 : index0;	

  	assign weight_c= (d_min==d7) ? w7 :
                     (d_min==d6) ? w6 :
                     (d_min==d5) ? w5 :
                     (d_min==d4) ? w4 :
                     (d_min==d3) ? w3 :
                     (d_min==d2) ? w2 :
                     (d_min==d1) ? w1 : w0;	
					 

endmodule

