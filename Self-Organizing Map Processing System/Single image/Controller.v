/////////////////////////////////////////////////////////////////////
// ---------------------- IVCAD 2022 Spring ---------------------- //
// ---------------------- Version : v.1.10  ---------------------- //
// ---------------------- Date : 2022.04.13 ---------------------- //
// --------------------- Controller module ------------------------//
// ----------------- Feb. 2022 Willie authored --------------------//
/////////////////////////////////////////////////////////////////////

module Controller(clk, rst, W_update_latch, D_update, RAM_IF_A, RAM_IF_OE, RAM_W_A, RAM_W_WE, RAM_RESULT_A, RAM_RESULT_WE, done);		//

// ---------------------- input  ---------------------- //
	input clk;
	input rst;

// ---------------------- output  ---------------------- //	
	output D_update;
	output reg W_update_latch;
	//RAM_IF
	output reg [17:0] RAM_IF_A;
	output reg RAM_IF_OE;
	//RAM_W
	output reg [17:0] RAM_W_A;
	output reg RAM_W_WE;
	//RAM_RESULT
	output reg [17:0] RAM_RESULT_A;
	output reg RAM_RESULT_WE;
	output done;
	
// ---------------------- Write down Your design below  ---------------------- //
	reg [2:0]state;
	reg [2:0]next_state;

	parameter idle = 3'd0  ,som =3'd2 ,w_weight=3'd3, w_pic=3'd4, have_done=3'd5 , error=3'd7 ;		//, idle_idle =3'd1

	//trash
	assign D_update=1'b0;

	assign done= (state==have_done) ? 1'b1 :1'b0;
	assign W_update= (state==som) ? 1'b1 : 1'b0;

	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			W_update_latch<=1'b0;	
		end	
		else
		begin
			W_update_latch <=W_update;
		end
	end	

	//state
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			state<=idle;	
		end	
		else
		begin
			state <=next_state;
		end
	end

	//next_state
	always @(*) 
	begin
		case (state)
			idle: 
			begin				
				next_state=som;			
			end
			/*
			idle_idle:
			begin
				next_state=som;
			end
			*/
			som:
			begin
				if (RAM_IF_A==18'd4095) 			//have done
				begin
					next_state=w_weight;
				end
				else
				begin
					next_state=som;
				end				
			end
			w_weight:
			begin
				if (RAM_W_A==18'd63) 		//have done
				begin
					next_state=w_pic;
				end
				else
				begin
					next_state=w_weight;
				end				
			end
			w_pic:
			begin
				if (RAM_RESULT_A==18'd4095) 		//have done
				begin
					next_state=have_done;
				end
				else
				begin
					next_state=w_pic;
				end					
			end		
			have_done:
			begin
				next_state=have_done;				
			end	
			default: 
			begin
				next_state=error;				
			end
		endcase	
	end


	//ram_if address
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM_IF_OE <= 1'b0;
			RAM_IF_A <= (18'd0-18'd1);			//因為rst是非同步，所以要用nextstate，A=-1
		end
		else
		begin
			/*
			case (next_state)				
				som: 
				begin
					RAM_IF_OE <= 1'b1;
					RAM_IF_A <= (RAM_IF_A+18'd1);
				end
				w_weight:
				begin
					RAM_IF_OE <= 1'b0;
					RAM_IF_A <= 18'd878787;					
				end
				w_pic:
				begin
					RAM_IF_OE <= 1'b0;
					
				end
				have_done:
				begin
					
				end
				default: 
					RAM_IF_OE <= 1'b0;
					RAM_IF_A <= 18'd878787;
			endcase
			*/


			if ( (next_state==som) || (next_state==w_pic) ) 
			begin
				RAM_IF_OE <= 1'b1;
				RAM_IF_A <= (RAM_IF_A+18'd1);
			end
			else 
			begin
				RAM_IF_OE <= 1'b0;
				RAM_IF_A <= (18'd0-18'd1);
			end		
			
		end
	end

	//ram_W address
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM_W_WE <= 1'b0;
			RAM_W_A <= (18'd0-18'd2);		
		end
		else
		begin
			if (next_state==w_weight ) 						//苦用state了
			begin
				RAM_W_WE <= 1'b1;
				RAM_W_A <= RAM_W_A+18'd1;	
			end
			else 
			begin
				RAM_W_WE <= 1'b0;
				RAM_W_A <= (18'd0-18'd1);
			end			
		end
	end


	//RAM_RESULT_A
	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			RAM_RESULT_WE <= 1'b0;
			RAM_RESULT_A <= (18'd0-18'd2);		
		end
		else
		begin
			if ( next_state==w_pic ) 						//苦用state了
			begin
				RAM_RESULT_WE <= 1'b1;
				RAM_RESULT_A <= RAM_RESULT_A +18'd1;	
			end
			else 
			begin
				RAM_RESULT_WE <= 1'b0;
				RAM_RESULT_A <= (18'd0-18'd2);
			end			
		end
	end



endmodule 
