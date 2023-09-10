/////////////////////////////////////////////////////////////////////
// ---------------------- IVCAD 2022 Spring ---------------------- //
// ---------------------- Version : v.1.10  ---------------------- //
// ---------------------- Date : 2022.04.13 ---------------------- //
// ------------------------- USS module ---------------------------//
// ----------------- Feb. 2022 Willie authored --------------------//
/////////////////////////////////////////////////////////////////////

module USS(X_in, X_c, Y_c, neighbor_sel);		//clk, rst, 

// ---------------------- input  ---------------------- //
	//input clk;
	//input rst;
	input [2:0] X_in;
	input [2:0] X_c;
	input [2:0] Y_c;

// ---------------------- output  ---------------------- //
	output [15:0] neighbor_sel;
	//output reg [1:0] sel0_out,sel1_out,sel2_out,sel3_out,sel4_out,sel5_out,sel6_out,sel7_out;
	
// ---------------------- Write down Your design below  ---------------------- //
	wire [2:0] delta_X;
	wire [2:0] delta_Y [7:0];
	reg [1:0] sel [7:0];

	integer i;

	//abs_delta
	assign delta_X= (X_in>X_c) ? X_in-X_c : X_c-X_in;		

	assign delta_Y[0]= (Y_c<3'd0 ) ? 3'd0-Y_c : Y_c-3'd0;
	assign delta_Y[1]= (Y_c<3'd1 ) ? 3'd1-Y_c : Y_c-3'd1;
	assign delta_Y[2]= (Y_c<3'd2 ) ? 3'd2-Y_c : Y_c-3'd2;
	assign delta_Y[3]= (Y_c<3'd3 ) ? 3'd3-Y_c : Y_c-3'd3;
	assign delta_Y[4]= (Y_c<3'd4 ) ? 3'd4-Y_c : Y_c-3'd4;
	assign delta_Y[5]= (Y_c<3'd5 ) ? 3'd5-Y_c : Y_c-3'd5;
	assign delta_Y[6]= (Y_c<3'd6 ) ? 3'd6-Y_c : Y_c-3'd6;
	assign delta_Y[7]= (Y_c<3'd7 ) ? 3'd7-Y_c : Y_c-3'd7;

	assign neighbor_sel={sel[0],sel[1],sel[2],sel[3],sel[4],sel[5],sel[6],sel[7]};

/*

	always @(*) 
	begin		
		sel0_out= sel[0];
		sel1_out= sel[1];
		sel2_out= sel[2];
		sel3_out= sel[3];
		sel4_out= sel[4];
		sel5_out= sel[5];
		sel6_out= sel[6];
		sel7_out= sel[7];
	end
*/
	//combinational
	always @(*) 
	begin
		case (delta_X)
			3'd0:	// .. 0.125 0.25 1 0.25 0.125 ..
			begin
				for (i = 0; i<8 ;i=i+1 ) 
				begin
					case (delta_Y[i])
						3'd0:
						begin
							sel[i]=2'b00;
						end 
						3'd1:
						begin
							sel[i]=2'b01;							
						end
						3'd2:
						begin
							sel[i]=2'b10;
						end
						default:
						begin
							sel[i]=2'b11;
						end 
					endcase	
				end
			end
			3'd1: 	// .. 0.125 0.25 0.25 0.25 0.125 ..
			begin
				for (i = 0; i<8 ;i=i+1 ) 
				begin
					case (delta_Y[i])
						3'd0:
						begin
							sel[i]=2'b01;
						end 
						3'd1:
						begin
							sel[i]=2'b01;							
						end
						3'd2:
						begin
							sel[i]=2'b10;
						end
						default:
						begin
							sel[i]=2'b11;
						end 
					endcase	
				end
			end
			3'd2:	// .. 0.125 0.125 0.125 0.125 0.125 ..
			begin
				for (i = 0; i<8 ;i=i+1 ) 
				begin
					case (delta_Y[i])
						3'd0:
						begin
							sel[i]=2'b10;
						end 
						3'd1:
						begin
							sel[i]=2'b10;							
						end
						3'd2:
						begin
							sel[i]=2'b10;
						end
						default:
						begin
							sel[i]=2'b11;
						end 
					endcase	
				end
			end
			default: 	//11
			begin
				for (i=0 ;i<8 ;i=i+1) 
				begin
					sel[i]=2'b11;						
				end
			end
		endcase
	end




endmodule

