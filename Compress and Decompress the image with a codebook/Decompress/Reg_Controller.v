module Reg_Controller (
    clk,
    rst,         
    weight_en_in,
    weight_data_in,
    weight_A_in,
    tag_en_in,
    tag_A_in,
    RAM3_WE_reg_out_in,
    RAM3_A_reg_out_in,
    state_in,
    weight_en_out,
    weight_data_out,
    weight_A_out,
    tag_en_out,
    tag_A_out,
    RAM3_WE_reg_out_out,
    RAM3_A_reg_out_out,
    state_out
);
    
    input clk,rst;
    input weight_en_in,tag_en_in,RAM3_WE_reg_out_in;
    input [23:0] weight_data_in;
    input [5:0] weight_A_in;
    input [19:0] RAM3_A_reg_out_in;
    input [5:0] tag_A_in;
    input [1:0] state_in;
    output reg weight_en_out,tag_en_out,RAM3_WE_reg_out_out;
    output reg [23:0] weight_data_out;
    output reg [5:0] weight_A_out;
    output reg [19:0] RAM3_A_reg_out_out;
    output reg [5:0] tag_A_out;
    output reg[1:0] state_out;




    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            weight_en_out <=  1'b0;
            weight_data_out <= 24'h000000;
            weight_A_out <= 6'b000000;
            tag_en_out <= 1'b0;
            tag_A_out <= 6'b000000;
            RAM3_WE_reg_out_out <= 1'b0;
            RAM3_A_reg_out_out <= 20'h00000;
            state_out <=2'b00;
        end
        else
        begin
            weight_en_out <= weight_en_in;
            weight_data_out <= weight_data_in;
            weight_A_out <= weight_A_in;
            tag_en_out <=tag_en_in;
            tag_A_out <= tag_A_in;
            RAM3_WE_reg_out_out <= RAM3_WE_reg_out_in;
            RAM3_A_reg_out_out <= RAM3_A_reg_out_in;
            state_out <= state_in;
        end    
    end

endmodule
