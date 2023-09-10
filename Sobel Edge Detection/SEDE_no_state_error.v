module SEDE (input clk,
			input rst,
			input [7:0] pix_data,
			output reg valid,
			output reg [7:0] edge_out,
			output reg busy
);

	//reg [1:0]state,next_state;
	reg [10:0]input_counter;			//,output_counter;  delta=33	//( >>5 , %32)					//how to count from 0 after rst?
	reg [7:0]kernal[0:95];
	reg signed [10:0]gradientX,gradientY; 		//most to +-255*4
	reg next_valid,next_busy;
	reg [7:0]next_edge_out;

	wire [4:0]input_row,input_col,output_row,output_col;
	wire [6:0] gradient_index;
	wire [6:0] p1,p2,p3,p4,p5,p6,p7,p8;		//index of kernal
	wire signed[10:0] outcome;

	integer i,j;

	parameter idle = 2'd0, read=2'd1, read_out=2'd2, out=2'd3 ;


	assign  outcome=(gradientX+gradientY)>>>1;
	assign  input_row=input_counter>>5;
	assign  output_row=(input_counter-11'd33)>>5;
	assign  input_col=input_counter%32;
	assign  output_col=(input_counter-11'd33)%32;
	assign  gradient_index=7'd64+{2'b00,input_col};
	assign  p1=output_col-7'd1;
	assign  p2=output_col;
	assign  p3=output_col+7'd1;
	assign  p4=output_col+7'd31;
	assign  p5=output_col+7'd32;
	assign  p6=output_col+7'd33;
	assign  p7=output_col+7'd63;
	assign  p8=output_col+7'd64;








	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			valid<=1'b0;
			busy<=1'b0;
			edge_out<=8'b0;	
			//state<=idle;
		end	
		else
		begin
			valid<=next_valid;
			busy<=next_busy;
			edge_out<=next_edge_out;
			//state<=next_state;
		end
	end



	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			input_counter<=11'd2047;			//????????????   +1==0   ????????	
		end	
		else
		begin
			input_counter<=input_counter+11'd1;
		end
	end

/*
	always @(*) 
	begin
		case (state)
			idle:
			begin
				next_state=read;
			end 
			read:
			begin
				if (input_counter<11'd32) 
				begin
					next_state=read;	
				end
				else
				begin
					next_state=read_out;
				end
			end
			read_out:
			begin
				if (input_counter<11'd1023) 
				begin
					next_state=read_out;
				end
				else
				begin
					next_state=out;
				end
			end
			out:
			begin
				if (input_counter<=1056) 
				begin
					next_state=out;	
				end
				else
				begin
					next_state=idle;
				end
			end 
		endcase	
	end
*/

//readinput		(insert form row 2)
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			for (i =0 ;i<96 ;i=i+1 ) 
			begin
				kernal[i]<=8'b0;	
			end	
		end
		else
		begin
			if (input_col==5'b0) 	//shift up one row 
			begin
				for (j =0 ;j<64 ;j=j+1 ) 
				begin
					kernal[j]<=kernal[j+32];	
				end
				kernal[gradient_index]<=pix_data;
			end		
			else
			begin
				kernal[gradient_index]<=pix_data;
			end
		end
	end

//calculate gradient  (9 index of kernel is from pix_data)
	always @(*) 
	begin
		gradientX= kernal[p1] +kernal[p3]+ (kernal[p2]<<1) -kernal[p7] -(kernal[p8]<<1) -pix_data;
		gradientY= kernal[p1] -kernal[p3]+ (kernal[p4]<<1) -(kernal[p6]<<1) +kernal[p7] -pix_data;
	end


	always @(*) 
	begin
		if(input_counter >=11'd1023)  					//(state==out)								//(input_counter >=11'd1023) 
		begin
			next_busy=1'b1;
		end	
		else
		begin
			next_busy=1'b0;
		end
	end

	always @(*) 
	begin
		if((input_counter>=11'd34) && (input_counter<=11'd1056))  		//((input_counter>=11'd33) && (input_counter<=11'd1056)) (state==read_out || state==out )
		begin
			next_valid=1'b1;	
		end	
		else
		begin
			next_valid=1'b0;
		end
	end

//edge output
	always @(*) 
	begin
		if (((output_row!=0) && (output_row!=31)) && ((output_col!=0) && (output_col!=31))) 
		begin
			if (outcome<0) 
			begin
				next_edge_out=8'd0;
			end
			else if (outcome>255) 
			begin
				next_edge_out=8'd255;			
			end
			else
			begin
				next_edge_out=outcome[7:0];			
			end
		end
		else
		begin
			next_edge_out=8'd0;
		end
		
	end

endmodule
