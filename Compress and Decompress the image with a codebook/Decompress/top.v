`include "Controller.v"
`include "Reg_Controller.v"
`include "MAN.v"

module top(
	input clk,
	input rst,
	//RAM1
	input [23:0] RAM1_Q,
	output [23:0] RAM1_D,		//trash
	output [19:0] RAM1_A,
	output RAM1_WE,				//=0
	output RAM1_OE,
	//RAM2
	input [23:0] RAM2_Q,
	output[23:0] RAM2_D,		//trash
	output [19:0] RAM2_A,
	output RAM2_WE,				//=0
	output RAM2_OE,
	//RAM3
	//input [23:0] RAM3_Q,
	output [23:0] RAM3_D,
	output [19:0] RAM3_A,
	output RAM3_WE,
	output RAM3_OE,			//=0
	//controller
	output done
	
);
	//w_cm
	//in
	wire w_cm0;
	wire [23:0] w_cm1;
	wire [5:0] w_cm2;
	wire w_cm3;
	wire [5:0] w_cm4;
	wire w_cm5;
	wire [19:0] w_cm6;
	wire [1:0] w_cm7;
	//out
	wire w_cm10;
	wire [23:0] w_cm11;
	wire [5:0] w_cm12;
	wire w_cm13;
	wire [5:0] w_cm14;
	wire w_cm15;
	wire [19:0] w_cm16;
	wire [1:0] w_cm17;




	//trash
	assign RAM1_D=24'h000000;
	assign RAM2_D=24'h000000;
	assign RAM1_WE=1'b0;
	assign RAM2_WE=1'b0;
	assign RAM3_OE=1'b0;


	Controller controller(
		.clk(clk),
		.rst(rst),
		.done(done),		
		.RAM1_Q(RAM1_Q),
		.RAM1_A(RAM1_A),	
		.RAM1_OE(RAM1_OE),
		.RAM2_Q(RAM2_Q),	
		.RAM2_A(RAM2_A),
		.RAM2_OE(RAM2_OE),
    	//.RAM3_D(RAM3_D),
		.RAM3_A(RAM3_A),
		.RAM3_WE(RAM3_WE),	
		.RAM3_WE_reg_in(w_cm15),
		.RAM3_A_reg_in(w_cm16),
		.RAM3_WE_reg_out(w_cm5),
		.RAM3_A_reg_out(w_cm6),		
		.weight_en(w_cm0),
		.weight_data(w_cm1),
		.weight_A(w_cm2), 
		.tag_en(w_cm3),
		.tag_A(w_cm4),
		.state_in(w_cm17),
		.state(w_cm7)
	);

	Reg_Controller reg_controller(
		.clk(clk),
    	.rst(rst),         
    	.weight_en_in(w_cm0),
    	.weight_data_in(w_cm1),
    	.weight_A_in(w_cm2),
    	.tag_en_in(w_cm3),
    	.tag_A_in(w_cm4),
    	.RAM3_WE_reg_out_in(w_cm5),
    	.RAM3_A_reg_out_in(w_cm6),
		.state_in(w_cm7),
    	.weight_en_out(w_cm10),
    	.weight_data_out(w_cm11),
    	.weight_A_out(w_cm12),
    	.tag_en_out(w_cm13),
    	.tag_A_out(w_cm14),
    	.RAM3_WE_reg_out_out(w_cm15),
    	.RAM3_A_reg_out_out(w_cm16),
		.state_out(w_cm17)
	);

	MAN man(
	.clk(clk),
	.rst(rst),
	.weight_en(w_cm10),
    	.weight_data(w_cm11),
    	.weight_A(w_cm12),
    	.tag_en(w_cm13),
    	.tag_A(w_cm14),
    	.MAN_out(RAM3_D)
	);




endmodule
