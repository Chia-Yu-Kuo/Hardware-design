module EGD(
	input clk,
	input rst,
	input si_data,
	output reg valid,	
	output reg [3:0] po_data,
	output reg busy
);
// write your code...
// you can modify the output port to reg if you want
	wire [3:0]next_po_data;
	wire [2:0] perfix;
	reg [2:0]offset,next_offset;

	reg next_valid;
	reg next_busy;


	reg [3:0] cs,ns;
	reg [2:0] m,next_m;

	assign perfix= 3'b111>>(3'd3-m);
	assign next_po_data=perfix+offset;
	

	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			valid <=1'b0;
			po_data <=4'b0;
			busy <=1'b0;	
		end	
		else
		begin
			valid <=next_valid;
			po_data <=next_po_data;
			busy <=next_busy;
		end
	end

	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			cs<=4'd11;	
		end	
		else
		begin
			if (valid) 
			begin
				cs<=4'b0;	
			end
			else
			begin
				cs<=ns;					
			end
		end
	end

	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			m<=3'd0;	
		end	
		else
		begin
			/*
			if (ns==4'd11) 				//cs==4'd11
			begin
				m<=m;	
			end
			else
			begin
				m<=next_m;
			end
			*/
			m<=next_m;
		end
	end

	always @(posedge clk or posedge rst) 
	begin
		if (rst) 
		begin
			offset<=3'd0;	
		end	
		else
		begin
			offset<=next_offset; 
		end
	end

	always @(*) 
	begin
		next_valid=1'b0;
		next_busy=1'b0;
		next_m=3'd0;
		next_offset=3'd0;
		case (cs)
			4'd0:
			begin
				if (si_data) 
				begin
					ns=4'd1;	
				end
				else
				begin
					ns=4'd10;
					next_busy=1'b1;
					next_m=3'd0;
				end		

			end 
			4'd1:
			begin
				if (si_data) 
				begin
					ns=4'd2;	
				end
				else
				begin
					ns=4'd4;
					next_m=3'd1;
				end	
			end
			4'd2:
			begin
				if (si_data) 
				begin
					ns=4'd3;	
				end
				else
				begin
					ns=4'd5;
					next_m=3'd2;
				end	
			end
			4'd3:
			begin
				if (si_data) 
				begin
					ns=4'd15;			//error state
				end
				else
				begin
					ns=4'd7;
					next_m=3'd3;

				end
			end
			4'd4:
			begin
				next_busy=1'b1;
				ns=4'd10;
				next_m=3'd1;
				next_offset={2'b00,si_data};
			end
			4'd5:
			begin
				ns=4'd6;
				next_m=3'd2;
				next_offset={1'b0,si_data,1'b0};				
			end
			4'd6:
			begin
				ns=4'd10;	
				next_busy=1'b1;
				next_m=3'd2;
				next_offset={offset[2:1],si_data};
			end
			4'd7:
			begin
				ns=4'd8;
				next_m=3'd3;	
				next_offset={si_data,2'b00};
			end
			4'd8:
			begin
				ns=4'd9;
				next_m=3'd3;				
				next_offset={offset[2],si_data,1'b0};
			end
			4'd9:
			begin
				ns=4'd10;
				next_busy=1'b1;
				next_m=3'd3;	
				next_offset={offset[2:1],si_data};
			end
			4'd10:
			begin
				ns=4'd11;
				next_busy=1'b1;
				next_valid=1'b1;
				next_m=m;	
				next_offset=offset;
			end
			4'd11:
			begin
				ns=4'd0;
				next_busy=1'b0;
				next_valid=1'b0;
			end
			default:
			begin
				ns=4'd15;
			end
		endcase	
	end





endmodule
	