/////////////////////////////////////////////////////////////////////
// ---------------------- IVCAD 2022 Spring ---------------------- //
// ---------------------- Version : v.1.10  ---------------------- //
// ---------------------- Date : 2022.04.13 ---------------------- //
// ------------------------ VEP module --------------------------//
// ----------------- Feb. 2022 Willie authored --------------------//
/////////////////////////////////////////////////////////////////////

module VEP(clk, rst, W_update, neighbor_sel, pixel,   					D_update,
				d0, d1, d2, d3, d4, d5, d6, d7, w0, w1, w2, w3, w4, w5, w6, w7);

// ---------------------- input  ---------------------- //
	input clk; 
	input rst; 
	input W_update;
	input D_update;								
	input [15:0] neighbor_sel; 
	//input [1:0] sel0, sel1, sel2, sel3, sel4, sel5, sel6, sel7;
	input [23:0] pixel; 			
// ---------------------- output  ---------------------- //
	output [9:0] d0;
	output [9:0] d1;
	output [9:0] d2;
	output [9:0] d3;
	output [9:0] d4;
	output [9:0] d5;
	output [9:0] d6;
	output [9:0] d7;
	output [23:0] w0;
	output [23:0] w1;
	output [23:0] w2;
	output [23:0] w3;
	output [23:0] w4;
	output [23:0] w5;
	output [23:0] w6;
	output [23:0] w7;
	
// ---------------------- Write down Your design below  ---------------------- //

	wire trash;
	assign trash=D_update;

	reg [23:0] weight [7:0];  // F/F
	reg [23:0] pixel_latch;			//讓只有半周的pixel延長至一周(但延誤一個cycle)

	//distance
	reg [7:0] absR [7:0];
	reg [7:0] absG [7:0];
	reg [7:0] absB [7:0];
	// + -
	reg sign_R [7:0] ;
	reg sign_G [7:0] ;
	reg sign_B [7:0] ;

	wire [2:0] total_shift [7:0];

	integer i;
	integer j;
	integer k;


	//output weight
	assign w0=weight[0];			//loop回來的值才是correct
	assign w1=weight[1];
	assign w2=weight[2];
	assign w3=weight[3];
	assign w4=weight[4];
	assign w5=weight[5];
	assign w6=weight[6];
	assign w7=weight[7];

	//total shift 0
	assign total_shift [0]= (neighbor_sel[15:14]==2'b00)	?  	3'd2 :		//0.25*1
							(neighbor_sel[15:14]==2'b01)    ?   3'd4 :		//0.25*0.25
							(neighbor_sel[15:14]==2'b10)	?	3'd5 : 3'd0;	//0.25*0.125  //d0 =0
	assign total_shift [1]= (neighbor_sel[13:12]==2'b00)	?  	3'd2 :
							(neighbor_sel[13:12]==2'b01)    ?   3'd4 :
							(neighbor_sel[13:12]==2'b10)	?	3'd5 : 3'd0;
	assign total_shift [2]= (neighbor_sel[11:10]==2'b00)	?  	3'd2 :
							(neighbor_sel[11:10]==2'b01)    ?   3'd4 :
							(neighbor_sel[11:10]==2'b10)	?	3'd5 : 3'd0;
	assign total_shift [3]= (neighbor_sel[9:8]==2'b00)		?  	3'd2 :
							(neighbor_sel[9:8]==2'b01)   	?   3'd4 :
							(neighbor_sel[9:8]==2'b10)		?	3'd5 : 3'd0;
	assign total_shift [4]= (neighbor_sel[7:6]==2'b00)		?  	3'd2 :
							(neighbor_sel[7:6]==2'b01)    	?   3'd4 :
							(neighbor_sel[7:6]==2'b10)		?	3'd5 : 3'd0;
	assign total_shift [5]= (neighbor_sel[5:4]==2'b00)		?  	3'd2 :
							(neighbor_sel[5:4]==2'b01)    	?   3'd4 :
							(neighbor_sel[5:4]==2'b10)		?	3'd5 : 3'd0;
	assign total_shift [6]= (neighbor_sel[3:2]==2'b00)		?  	3'd2 :
							(neighbor_sel[3:2]==2'b01)    	?   3'd4 :
							(neighbor_sel[3:2]==2'b10)		?	3'd5 : 3'd0;
	assign total_shift [7]= (neighbor_sel[1:0]==2'b00)		?  	3'd2 :
							(neighbor_sel[1:0]==2'b01)    	?   3'd4 :
							(neighbor_sel[1:0]==2'b10)		?	3'd5 : 3'd0;	


	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			pixel_latch<=24'd0;	
		end	
		else
		begin
			pixel_latch<=pixel;
		end
	end


	//算distance
	//abs0~7			//要重複立用  1.找中心點  2.算Vector差
	always @(*)          
	begin
		for ( i=0 ; i<8; i=i+1) 
		begin
			//R
			if( weight[i][23:16]<pixel_latch[23:16] )
	    	begin
	    	  	absR[i]= pixel_latch[23:16]-weight[i][23:16];
				sign_R[i]=1'd0;
	    	end
	    	else
	    	begin
	    	  	absR[i]= weight[i][23:16]-pixel_latch[23:16];
				sign_R[i]=1'd1;

	    	end
			//G
			if( weight[i][15:8]<pixel_latch[15:8] )
	    	begin
	    	  	absG[i]= pixel_latch[15:8]-weight[i][15:8];
				sign_G[i]=1'd0;
	    	end
	    	else
	    	begin
	    	  	absG[i]= weight[i][15:8]-pixel_latch[15:8];
				sign_G[i]=1'd1;
	    	end
			//B
			if( weight[i][7:0]<pixel_latch[7:0])
	    	begin
	    	  	absB[i]= pixel_latch[7:0]-weight[i][7:0];
				sign_B[i]=1'd0;
	    	end
	    	else
	    	begin
	    	  	absB[i]= weight[i][7:0]-pixel_latch[7:0];
				sign_B[i]=1'd1;
	    	end
		end
	end


	//d0~d7
	assign d0={{2'b0},absR[0]}+{{2'b0},absG[0]}+{{2'b0},absB[0]};     
	assign d1={{2'b0},absR[1]}+{{2'b0},absG[1]}+{{2'b0},absB[1]};     
  	assign d2={{2'b0},absR[2]}+{{2'b0},absG[2]}+{{2'b0},absB[2]};     
	assign d3={{2'b0},absR[3]}+{{2'b0},absG[3]}+{{2'b0},absB[3]};     
	assign d4={{2'b0},absR[4]}+{{2'b0},absG[4]}+{{2'b0},absB[4]};     
	assign d5={{2'b0},absR[5]}+{{2'b0},absG[5]}+{{2'b0},absB[5]};     
	assign d6={{2'b0},absR[6]}+{{2'b0},absG[6]}+{{2'b0},absB[6]};     
	assign d7={{2'b0},absR[7]}+{{2'b0},absG[7]}+{{2'b0},absB[7]};     

	//weight_update
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			for ( j=0 ; j<8; j=j+1) 
			begin
				weight[j]<=24'b011111010111110101111101;				// 125?? or 255??
			end
		end
		else
		begin
			if (W_update) 	
			begin
				for ( k=0 ; k<8 ; k=k+1) 
				begin
					if (total_shift[k]!=3'd0) 
					begin
						if (sign_R[k])	//negative 
						begin
							weight[k][23:16]<=weight[k][23:16]- (absR[k]>>total_shift[k]);	
						end
						else	//positive
						begin
							weight[k][23:16]<=weight[k][23:16] + (absR[k]>>total_shift[k]);	
						end	

						if (sign_G[k])	//negative 
						begin
							weight[k][15:8] <=weight[k][15:8] - (absG[k]>>total_shift[k]);			
						end
						else	//positive
						begin
							weight[k][15:8] <=weight[k][15:8] + (absG[k]>>total_shift[k]);			
						end	

						if (sign_B[k])	//negative 
						begin
							weight[k][7:0]  <=weight[k][7:0]  - (absB[k]>>total_shift[k]);			
						end
						else	//positive
						begin
							weight[k][7:0]  <=weight[k][7:0]  + (absB[k]>>total_shift[k]);		
						end	
					end
				end
			end
		end	
	end


endmodule
