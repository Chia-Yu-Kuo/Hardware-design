module  COMP (clk, reset, IOLED, VTH, VDD, K, VDATA);
	input clk, reset;
	input [8:0] IOLED;
	input [3:0] K; 
	input [15:0] VDD; 
	input [15:0] VTH; 
	output reg[15:0] VDATA; 

	//--------------------------------------
	//  \^o^/   Write your code here~  \^o^/
	//--------------------------------------
	wire [8:0] div_out;
	wire [15:0] squr_out ,VDATA_out;

	assign div_out= IOLED/{4'b0000,K};

	SQRT sqrt(div_out[6:0],squr_out); 

	assign VDATA_out= VDD-VTH-squr_out;

	always @(posedge clk or posedge reset) 
	begin
		if (reset) 
		begin
			VDATA<=16'b0;
		end
		else
		begin
			VDATA<=VDATA_out;
		end	
	end	
	

endmodule


module SQRT (x, root); //integer square root
input [6:0] x;
output reg [15:0] root; //output integer 8 bits and floating number 8 bits

always@(x) begin
	case(x)
		7'd100: root = 4'd10 << 8;
		7'd81 : root = 4'd9 << 8;
		7'd64 : root = 4'd8 << 8;
		7'd49 : root = 4'd7 << 8;
		7'd36 : root = 4'd6 << 8;
		7'd25 : root = 4'd5 << 8;
		7'd16 : root = 4'd4 << 8;
		7'd9  : root = 4'd3 << 8;
		7'd4  : root = 4'd2 << 8;
		7'd1  : root = 4'd1 << 8;
		default: root = 4'd0;
    endcase
end

endmodule








