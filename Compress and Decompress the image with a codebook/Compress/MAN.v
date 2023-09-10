module MAN(
	input clk,
	input rst,
	input data_en,		//state給   前期:data_en=0  後期:data_en=1
	input [23:0] data_in,			//前期:c_in(寫code book到weight) //後期:if_in(*4096次)

	input wen,						// 前期:c_en =1   後期:0
	input  [2:0] MAN_A_W,			//what address from c_in0~c_in7
	
	
	
	output reg[9:0] d0_out   ,
	output reg[9:0] d1_out   ,
	output reg[9:0] d2_out   ,
	output reg[9:0] d3_out   ,
	output reg[9:0] d4_out   ,
	output reg[9:0] d5_out   ,
	output reg[9:0] d6_out   ,
	output reg[9:0] d7_out		
);


reg [23:0]weight[7:0];		//==input_colat==code book
reg [23:0]input_feature;
reg [7:0] absR [7:0];
reg [7:0] absG [7:0];
reg [7:0] absB [7:0];

// weight
always @(posedge clk or posedge rst) 
begin
if(rst)
begin
	weight[0]<=24'b0;
	weight[1]<=24'b0;
	weight[2]<=24'b0;
	weight[3]<=24'b0;
	weight[4]<=24'b0;
	weight[5]<=24'b0;
	weight[6]<=24'b0;
	weight[7]<=24'b0;	
end
else
begin
	if (wen) 		//latch??
	begin
		case (MAN_A_W)
			3'd0:
			begin
				weight[0]<=data_in;
			end
			3'd1: 
			begin
				weight[1]<=data_in;
			end
			3'd2:
			begin
				weight[2]<=data_in;
			end 
			3'd3:
			begin
				weight[3]<=data_in;
			end 
			3'd4:
			begin
				weight[4]<=data_in;
			end 
			3'd5:
			begin
				weight[5]<=data_in;
			end 
			3'd6:
			begin
				weight[6]<=data_in;
			end 
			3'd7:
			begin
				weight[7]<=data_in;
			end 			 
		endcase	
	end	
end

end

//input_feature
always @(posedge clk or posedge rst) 
begin
	if(rst)
	begin
		input_feature<=24'd0;
	end
	else
	begin
		if (data_en) 		//latch?
		begin
			input_feature<=data_in;	
		end
	end
end

/*
always @(*) 
begin

		if (data_en) 		//latch?
		begin
			input_feature<=data_in;	
		end

end
*/

//abs0~7
always @(*)             //0
begin
    //R
    if(weight[0][23:16]>input_feature[23:16])
    begin
      absR[0]= weight[0][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[0]= input_feature[23:16]-weight[0][23:16];
    end
    //G
    if(weight[0][15:8]>input_feature[15:8])
    begin
      absG[0]= weight[0][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[0]= input_feature[15:8]-weight[0][15:8];
    end
    //B
    if(weight[0][7:0]>input_feature[7:0])
    begin
      absB[0]= weight[0][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[0]= input_feature[7:0]-weight[0][7:0];
    end  
end

always @(*)             //1
begin
    //R
    if(weight[1][23:16]>input_feature[23:16])
    begin
      absR[1]= weight[1][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[1]= input_feature[23:16]-weight[1][23:16];
    end
    //G
    if(weight[1][15:8]>input_feature[15:8])
    begin
      absG[1]= weight[1][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[1]= input_feature[15:8]-weight[1][15:8];
    end
    //B
    if(weight[1][7:0]>input_feature[7:0])
    begin
      absB[1]= weight[1][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[1]= input_feature[7:0]-weight[1][7:0];
    end  
end

always @(*)             //2
begin
    //R
    if(weight[2][23:16]>input_feature[23:16])
    begin
      absR[2]= weight[2][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[2]= input_feature[23:16]-weight[2][23:16];
    end
    //G
    if(weight[2][15:8]>input_feature[15:8])
    begin
      absG[2]= weight[2][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[2]= input_feature[15:8]-weight[2][15:8];
    end
    //B
    if(weight[2][7:0]>input_feature[7:0])
    begin
      absB[2]= weight[2][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[2]= input_feature[7:0]-weight[2][7:0];
    end  
end

always @(*)             //3
begin
    //R
    if(weight[3][23:16]>input_feature[23:16])
    begin
      absR[3]= weight[3][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[3]= input_feature[23:16]-weight[3][23:16];
    end
    //G
    if(weight[3][15:8]>input_feature[15:8])
    begin
      absG[3]= weight[3][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[3]= input_feature[15:8]-weight[3][15:8];
    end
    //B
    if(weight[3][7:0]>input_feature[7:0])
    begin
      absB[3]= weight[3][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[3]= input_feature[7:0]-weight[3][7:0];
    end  
end

always @(*)             //4
begin
    //R
    if(weight[4][23:16]>input_feature[23:16])
    begin
      absR[4]= weight[4][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[4]= input_feature[23:16]-weight[4][23:16];
    end
    //G
    if(weight[4][15:8]>input_feature[15:8])
    begin
      absG[4]= weight[4][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[4]= input_feature[15:8]-weight[4][15:8];
    end
    //B
    if(weight[4][7:0]>input_feature[7:0])
    begin
      absB[4]= weight[4][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[4]= input_feature[7:0]-weight[4][7:0];
    end  
end

always @(*)             //5
begin
    //R
    if(weight[5][23:16]>input_feature[23:16])
    begin
      absR[5]= weight[5][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[5]= input_feature[23:16]-weight[5][23:16];
    end
    //G
    if(weight[5][15:8]>input_feature[15:8])
    begin
      absG[5]= weight[5][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[5]= input_feature[15:8]-weight[5][15:8];
    end
    //B
    if(weight[5][7:0]>input_feature[7:0])
    begin
      absB[5]= weight[5][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[5]= input_feature[7:0]-weight[5][7:0];
    end  
end

always @(*)             //6
begin
    //R
    if(weight[6][23:16]>input_feature[23:16])
    begin
      absR[6]= weight[6][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[6]= input_feature[23:16]-weight[6][23:16];
    end
    //G
    if(weight[6][15:8]>input_feature[15:8])
    begin
      absG[6]= weight[6][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[6]= input_feature[15:8]-weight[6][15:8];
    end
    //B
    if(weight[6][7:0]>input_feature[7:0])
    begin
      absB[6]= weight[6][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[6]= input_feature[7:0]-weight[6][7:0];
    end  
end

always @(*)             //7
begin
    //R
    if(weight[7][23:16]>input_feature[23:16])
    begin
      absR[7]= weight[7][23:16]-input_feature[23:16];
    end
    else
    begin
      absR[7]= input_feature[23:16]-weight[7][23:16];
    end
    //G
    if(weight[7][15:8]>input_feature[15:8])
    begin
      absG[7]= weight[7][15:8]-input_feature[15:8];
    end
    else
    begin
      absG[7]= input_feature[15:8]-weight[7][15:8];
    end
    //B
    if(weight[7][7:0]>input_feature[7:0])
    begin
      absB[7]= weight[7][7:0]-input_feature[7:0];
    end
    else
    begin
       absB[7]= input_feature[7:0]-weight[7][7:0];
    end  
end

always @(*)
begin
	d0_out={{2'b0},absR[0]}+{{2'b0},absG[0]}+{{2'b0},absB[0]};          //????
	d1_out={{2'b0},absR[1]}+{{2'b0},absG[1]}+{{2'b0},absB[1]};          //????
  d2_out={{2'b0},absR[2]}+{{2'b0},absG[2]}+{{2'b0},absB[2]};          //????
	d3_out={{2'b0},absR[3]}+{{2'b0},absG[3]}+{{2'b0},absB[3]};          //????
	d4_out={{2'b0},absR[4]}+{{2'b0},absG[4]}+{{2'b0},absB[4]};          //????
	d5_out={{2'b0},absR[5]}+{{2'b0},absG[5]}+{{2'b0},absB[5]};          //????
	d6_out={{2'b0},absR[6]}+{{2'b0},absG[6]}+{{2'b0},absB[6]};          //????
	d7_out={{2'b0},absR[7]}+{{2'b0},absG[7]}+{{2'b0},absB[7]};          //????
end


endmodule
