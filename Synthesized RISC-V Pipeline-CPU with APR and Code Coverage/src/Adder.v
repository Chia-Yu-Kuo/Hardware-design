module Adder (current_pc,current_pc_add4);
    input [15:0] current_pc;
    output [15:0] current_pc_add4;
/*	
    wire [32:0]temp;

    assign temp=current_pc+32'd4;
    assign current_pc_add4=temp[31:0];

    wire overflow;
*/
    assign current_pc_add4=current_pc+16'd4;

endmodule
