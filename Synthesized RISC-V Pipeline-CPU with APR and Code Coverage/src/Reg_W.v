module Reg_W (clk,rst,pc_in,ld_data_in,alu_out_in,ld_data_out,alu_out_out);
    input clk,rst;
    input [31:0] alu_out_in,ld_data_in;
	input [15:0] pc_in;
    output reg [31:0] alu_out_out,ld_data_out;
    reg [15:0] pc_out;

    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            pc_out <=16'b0;
            alu_out_out <= 32'b0;   
            ld_data_out <= 32'b0;
        end
        else
        begin
            pc_out <= pc_in;
            alu_out_out <= alu_out_in;   
            ld_data_out <= ld_data_in;
        end    
    end

    
endmodule