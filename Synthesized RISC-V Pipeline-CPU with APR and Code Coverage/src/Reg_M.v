module Reg_M (clk,rst,pc_in,alu_out_in,rs2_data_in,pc_out,alu_out_out,rs2_data_out);
    input clk,rst;
    input [31:0] alu_out_in,rs2_data_in;
	input [15:0] pc_in;
	output reg[15:0] pc_out;
    output reg[31:0] alu_out_out,rs2_data_out;


    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            pc_out <=16'b0;
            alu_out_out <= 32'b0;   
            rs2_data_out <= 32'b0;
        end
        else
        begin
            pc_out <= pc_in;
            alu_out_out <= alu_out_in;   
            rs2_data_out <= rs2_data_in;
        end    
    end

    
endmodule