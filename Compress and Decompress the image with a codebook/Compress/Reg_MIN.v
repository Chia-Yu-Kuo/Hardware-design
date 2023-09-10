module Reg_MIN (
        clk,
        rst,
        d0_min_in,
        d1_min_in,
        d2_min_in,
        d3_min_in,
        d4_min_in,
        d5_min_in,
        d6_min_in,
        d7_min_in,
        d0_min_pos_in,
        d1_min_pos_in,
        d2_min_pos_in,
        d3_min_pos_in,
        d4_min_pos_in,
        d5_min_pos_in,
        d6_min_pos_in,
        d7_min_pos_in,
        state_in,
        RAM2_WE_reg_out_in,
        RAM2_A_reg_out_in,
        d0_min_out,
        d1_min_out,
        d2_min_out,
        d3_min_out,
        d4_min_out,
        d5_min_out,
        d6_min_out,
        d7_min_out,
        d0_min_pos_out,
        d1_min_pos_out,
        d2_min_pos_out,
        d3_min_pos_out,
        d4_min_pos_out,
        d5_min_pos_out,
        d6_min_pos_out,
        d7_min_pos_out,
        state_out,
        RAM2_WE_reg_out_out,
        RAM2_A_reg_out_out
    );

    input clk,rst;
    input [1:0]state_in;
    input RAM2_WE_reg_out_in;
    input [19:0] RAM2_A_reg_out_in;
    input [9:0] d0_min_in,d1_min_in,d2_min_in,d3_min_in,d4_min_in,d5_min_in,d6_min_in,d7_min_in;
    input [2:0] d0_min_pos_in,d1_min_pos_in,d2_min_pos_in,d3_min_pos_in,d4_min_pos_in,d5_min_pos_in,d6_min_pos_in,d7_min_pos_in;
    output reg [9:0] d0_min_out,d1_min_out,d2_min_out,d3_min_out,d4_min_out,d5_min_out,d6_min_out,d7_min_out;
    output reg [2:0] d0_min_pos_out,d1_min_pos_out,d2_min_pos_out,d3_min_pos_out,d4_min_pos_out,d5_min_pos_out,d6_min_pos_out,d7_min_pos_out;
    output reg [1:0] state_out;     
    output reg  RAM2_WE_reg_out_out;
    output reg [19:0] RAM2_A_reg_out_out;



    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            d0_min_out <= 10'b0000000000;
            d1_min_out <= 10'b0000000000;   
            d2_min_out <= 10'b0000000000;
            d3_min_out <= 10'b0000000000;
            d4_min_out <= 10'b0000000000;
            d5_min_out <= 10'b0000000000;
            d6_min_out <= 10'b0000000000;
            d7_min_out <= 10'b0000000000;

            d0_min_pos_out <= 3'b000;
            d1_min_pos_out <= 3'b000;   
            d2_min_pos_out <= 3'b000;
            d3_min_pos_out <= 3'b000;
            d4_min_pos_out <= 3'b000;
            d5_min_pos_out <= 3'b000;
            d6_min_pos_out <= 3'b000;
            d7_min_pos_out <= 3'b000;

            state_out <= 2'b00;
            RAM2_WE_reg_out_out <=1'b0;
            RAM2_A_reg_out_out <=20'h00000;
        end
        else
        begin
            d0_min_out <= d0_min_in;
            d1_min_out <= d1_min_in;   
            d2_min_out <= d2_min_in;
            d3_min_out <= d3_min_in;
            d4_min_out <= d4_min_in;
            d5_min_out <= d5_min_in;
            d6_min_out <= d6_min_in;
            d7_min_out <= d7_min_in;

            d0_min_pos_out <= d0_min_pos_in;
            d1_min_pos_out <= d1_min_pos_in;   
            d2_min_pos_out <= d2_min_pos_in;
            d3_min_pos_out <= d3_min_pos_in;
            d4_min_pos_out <= d4_min_pos_in;
            d5_min_pos_out <= d5_min_pos_in;
            d6_min_pos_out <= d6_min_pos_in;
            d7_min_pos_out <= d7_min_pos_in;

            state_out<= state_in;
            RAM2_WE_reg_out_out <=RAM2_WE_reg_out_in;
            RAM2_A_reg_out_out <=RAM2_A_reg_out_in;
        end    
    end


endmodule