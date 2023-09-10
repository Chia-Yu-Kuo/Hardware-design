module Controller(
	input clk,
	input rst,
	output done,		//by assign
	//RAM1
	input  [23:0]RAM1_Q,
	output reg [19:0]RAM1_A,	
	output reg RAM1_OE,
	//RAM2
	input [23:0] RAM2_Q,	
	output reg [19:0] RAM2_A,
	output reg RAM2_OE,
	//RAM3
    //output[23:0] RAM3_D,
	output [19:0] RAM3_A,
	output RAM3_WE,	
	//RAM3_reg
	input RAM3_WE_reg_in,
	input [19:0] RAM3_A_reg_in,

	output reg RAM3_WE_reg_out,
	output reg [19:0] RAM3_A_reg_out,
	//weight
	output reg weight_en,
	output [23:0]weight_data,
	output [5:0]weight_A,  //64歌

	output reg tag_en,
	output [5:0]tag_A,

	input [1:0] state_in,
    output reg [1:0] state
);


	//wire [19:0] W_RAM1_A;
	reg [1:0] next_state;

	parameter  idle = 2'd0, read_weight = 2'd1, wr_ans= 2'd2, have_done=2'd3 ;

	assign weight_data=RAM1_Q;
	//assign W_RAM1_A=RAM1_A;
	assign weight_A = RAM1_A[5:0];					//?????
	assign tag_A = RAM2_Q[5:0];				
	assign done = (state_in==have_done) ? 1'b1 :1'b0;

	assign RAM3_WE=RAM3_WE_reg_in;
	assign RAM3_A=RAM3_A_reg_in;

	//state
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			state <=idle;	
		end	
		else
		begin			
			state <= next_state;			
		end
	end

	//next_state
	always @(*) 
	begin
		case (state)
			idle: 
			begin				
				next_state=read_weight;			
			end
			read_weight:
			begin
				if (RAM1_A==20'd63) 			//have done
				begin
					next_state=wr_ans;
				end
				else
				begin
					next_state=read_weight;
				end				
			end
			wr_ans:
			begin
				if (RAM2_A==20'd4095) 		//have done
				begin
					next_state=have_done;
				end
				else
				begin
					next_state=wr_ans;
				end				
			end
			have_done:
			begin
				next_state=have_done;				
			end			 
		endcase	
	end
	
	//ram1 address
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			//RAM1_OE <= 1'b0;
			RAM1_A <= (20'd0-20'd1);			//出問題??
		end
		else
		begin
			if (next_state==read_weight) 
			begin
				//RAM1_OE <= 1'b1;
				RAM1_A <= (RAM1_A+20'd1);
			end
			else 
			begin
				//RAM1_OE <= 1'b0;
				RAM1_A <= 20'h00000;
			end			
		end
	end

	//ram2 address
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM2_A <= 20'h00000;
		end
		else
		begin
			if (state==wr_ans) 
			begin
				RAM2_A <= RAM2_A+20'd1;
			end
			else
			begin
				RAM2_A <=20'd0;
			end
		end
	end

	//ram3_reg address
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM3_A_reg_out <= 20'h00000;
		end
		else
		begin
			if (state==wr_ans) 
			begin
				RAM3_A_reg_out <= RAM3_A_reg_out+20'd1;
			end
			else
			begin
				RAM3_A_reg_out <=20'd0;
			end
		end
	end

	//each state do thing
	always @(*) 
	begin
		case (state)
			idle: 
			begin			
				RAM1_OE=1'b0;
				RAM2_OE=1'b0;
				weight_en=1'b0;
				RAM3_WE_reg_out=1'b0;
				tag_en=1'b0;
			end
			read_weight:
			begin
				RAM1_OE=1'b1;
				RAM2_OE=1'b0;
				weight_en=1'b1;
				RAM3_WE_reg_out=1'b0;
				tag_en=1'b0;
			end
			wr_ans:
			begin
				RAM1_OE=1'b0;
				RAM2_OE=1'b1;
				weight_en=1'b0;
				RAM3_WE_reg_out=1'b1;
				tag_en=1'b1;
			end
			have_done:
			begin
				RAM1_OE=1'b0;
				RAM2_OE=1'b0;
				weight_en=1'b0;
				RAM3_WE_reg_out=1'b0;
				tag_en=1'b0;
			end			 
		endcase	
	end
	



endmodule


