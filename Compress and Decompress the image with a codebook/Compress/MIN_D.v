module MIN_D(
	//input clk,
	//input rst,
	
	input [9:0] d0,
	input [9:0] d1,
	input [9:0] d2,
	input [9:0] d3,
	input [9:0] d4,
	input [9:0] d5,
	input [9:0] d6,
	input [9:0] d7,
	output [9:0] d_min,			//distance
	output [2:0]  d_min_pos			//out_index
);

  wire [9:0] m1,m2,m3,m4,m5,m6;

  assign m1 = (d0<d1) ? d0 : d1;
  assign m2 = (d2<d3) ? d2 : d3;
  assign m3 = (d4<d5) ? d4 : d5;
  assign m4 = (d6<d7) ? d6 : d7;
  assign m5 = (m1<m2) ? m1 : m2;
  assign m6 = (m3<m4) ? m3 : m4;
  assign d_min = (m5<m6) ? m5 : m6;

  assign d_min_pos = (d_min==d7) ? 3'd7 :
                     (d_min==d6) ? 3'd6 :
                     (d_min==d5) ? 3'd5 :
                     (d_min==d4) ? 3'd4 :
                     (d_min==d3) ? 3'd3 :
                     (d_min==d2) ? 3'd2 :
                     (d_min==d1) ? 3'd1 : 3'd0;
  


endmodule