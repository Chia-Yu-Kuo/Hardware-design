module controller(
	input clk,
	input rst,
	input [1:0]state_in,		//from reg_min
	output done,		//by assign
	//RAM1
	input  [23:0]RAM1_Q,
	output reg RAM1_OE,
	output reg [19:0]RAM1_A,		
	//RAM2_WE
	input RAM2_WE_reg_in,		
	input [19:0]RAM2_A_reg_in,
	output RAM2_WE,			//by assign
	output [19:0]RAM2_A,	//by assign		//原reg
	//MAN0~7
	output [23:0] RAM1_Q_latch,		//by assign			//沒用latch  reg
	output reg data_en,		//自己家的
	output reg wen0,
	output reg wen1,
	output reg wen2,
	output reg wen3,
	output reg wen4,
	output reg wen5,
	output reg wen6,
	output reg wen7,
	output reg[2:0] MAN_A_WEIGHT,
	output reg [1:0] state,
	output reg RAM2_WE_reg_out,
	output reg [19:0]RAM2_A_reg_out
	
);

	
	reg [1:0] next_state;
	wire [19:0] weight;
/*
	reg RAM2_WE_reg_out,RAM2_WE_reg_out_latch;
	reg [19:0]RAM2_A_reg_out,RAM2_A_reg_out_latch;
*/

	parameter  idle = 2'd0, wr_weight = 2'd1, wr_ans= 2'd2, have_done=2'd3 ;

	assign weight=RAM1_A>>2'd3;
	assign RAM1_Q_latch=RAM1_Q;
	assign RAM2_WE=RAM2_WE_reg_in;		//feedback from reg_min
	assign RAM2_A=RAM2_A_reg_in;		//feedback from reg_min
	assign done = (state_in==have_done) ? 1'b1 :1'b0;

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
				next_state=wr_weight;			
			end
			wr_weight:
			begin
				if (RAM1_A==20'd63) 			//have done
				begin
					next_state=wr_ans;
				end
				else
				begin
					next_state=wr_weight;
				end				
			end
			wr_ans:
			begin
				if (RAM1_A==20'd4159) 		//have done
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
/*
	//ram2_reg_out_latch_latch
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM2_WE_reg_out_latch_latch<=1'b0;
			RAM2_A_reg_out_latch_latch<=20'd0;
		end	
		else
		begin			
			RAM2_WE_reg_out_latch_latch<=RAM2_WE_reg_out_latch;
			RAM2_A_reg_out_latch_latch<=RAM2_A_reg_out_latch;		
		end
	end
	//ram2_reg_out_latch
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM2_WE_reg_out_latch<=1'b0;
			RAM2_A_reg_out_latch<=20'd0;
		end	
		else
		begin			
			RAM2_WE_reg_out_latch<=RAM2_WE_reg_out;
			RAM2_A_reg_out_latch<=RAM2_A_reg_out;		
		end
	end
*/
	
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
			if ((next_state==wr_weight) || (next_state==wr_ans)) 
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

	//ram2
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM2_A_reg_out <= 20'h00000;
		end
		else
		begin
			if (state==wr_ans) 
			begin
				RAM2_A_reg_out <= RAM2_A_reg_out+20'd1;
			end
			else
			begin
				RAM2_A_reg_out <=20'd0;
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
				//RAM1_A=20'hZZZZZ;
				data_en=1'b0;
				wen0=1'b0;
				wen1=1'b0;
				wen2=1'b0;
				wen3=1'b0;
				wen4=1'b0;
				wen5=1'b0;
				wen6=1'b0;
				wen7=1'b0;
				MAN_A_WEIGHT=3'b000;
				RAM2_WE_reg_out=1'b0;
				//RAM2_A_reg_out=20'hZZZZZ;
			end
			wr_weight:
			begin
				RAM1_OE=1'b1;
				//RAM1_A=20'hZZZZZ;
				data_en=1'b0;
				case (weight)		// ok?
					20'd0:
					begin
						wen0=1'b1;
						wen1=1'b0;
						wen2=1'b0;
						wen3=1'b0;
						wen4=1'b0;
						wen5=1'b0;
						wen6=1'b0;
						wen7=1'b0;
					end 
					20'd1:
					begin
						wen0=1'b0;
						wen1=1'b1;
						wen2=1'b0;
						wen3=1'b0;
						wen4=1'b0;
						wen5=1'b0;
						wen6=1'b0;
						wen7=1'b0;
					end 
					20'd2:
					begin
						wen0=1'b0;
						wen1=1'b0;
						wen2=1'b1;
						wen3=1'b0;
						wen4=1'b0;
						wen5=1'b0;
						wen6=1'b0;
						wen7=1'b0;
					end 
					20'd3:
					begin
						wen0=1'b0;
						wen1=1'b0;
						wen2=1'b0;
						wen3=1'b1;
						wen4=1'b0;
						wen5=1'b0;
						wen6=1'b0;
						wen7=1'b0;
					end 
					20'd4:
					begin
						wen0=1'b0;
						wen1=1'b0;
						wen2=1'b0;
						wen3=1'b0;
						wen4=1'b1;
						wen5=1'b0;
						wen6=1'b0;
						wen7=1'b0;
					end 
					20'd5:
					begin
						wen0=1'b0;
						wen1=1'b0;
						wen2=1'b0;
						wen3=1'b0;
						wen4=1'b0;
						wen5=1'b1;
						wen6=1'b0;
						wen7=1'b0;
					end 
					20'd6:
					begin
						wen0=1'b0;
						wen1=1'b0;
						wen2=1'b0;
						wen3=1'b0;
						wen4=1'b0;
						wen5=1'b0;
						wen6=1'b1;
						wen7=1'b0;
					end 
					20'd7:
					begin
						wen0=1'b0;
						wen1=1'b0;
						wen2=1'b0;
						wen3=1'b0;
						wen4=1'b0;
						wen5=1'b0;
						wen6=1'b0;
						wen7=1'b1;
					end 
					default: 
					begin
						wen0=1'b0;
						wen1=1'b0;
						wen2=1'b0;
						wen3=1'b0;
						wen4=1'b0;
						wen5=1'b0;
						wen6=1'b0;
						wen7=1'b0;
					end
				endcase
				MAN_A_WEIGHT= RAM1_A % 4'd8;		// =%8		??	
				RAM2_WE_reg_out=1'b0;
				
				
				//RAM2_A_reg_out=20'hZZZZZ;
			end
			wr_ans:
			begin
				RAM1_OE=1'b1;
				//RAM1_A=20'hZZZZZ;
				data_en=1'b1;
				wen0=1'b0;
				wen1=1'b0;
				wen2=1'b0;
				wen3=1'b0;
				wen4=1'b0;
				wen5=1'b0;
				wen6=1'b0;
				wen7=1'b0;
				MAN_A_WEIGHT=3'b000;
				RAM2_WE_reg_out=1'b1;
				//RAM2_A_reg_out=20'hZZZZZ;
			end
			have_done:
			begin
				RAM1_OE=1'b0;
				//RAM1_A=20'hZZZZZ;
				data_en=1'b0;
				wen0=1'b0;
				wen1=1'b0;
				wen2=1'b0;
				wen3=1'b0;
				wen4=1'b0;
				wen5=1'b0;
				wen6=1'b0;
				wen7=1'b0;
				MAN_A_WEIGHT=3'b000;
				RAM2_WE_reg_out=1'b0;
				//RAM2_A_reg_out=20'hZZZZZ;
			end
		
		endcase	
	end





endmodule
