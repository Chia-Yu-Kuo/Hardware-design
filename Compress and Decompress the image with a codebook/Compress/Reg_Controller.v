module Reg_Controller (
    clk,
    rst,         
    wen0_in,
    wen1_in,
    wen2_in,
    wen3_in,
    wen4_in,
    wen5_in,
    wen6_in,
    wen7_in,
    data_en_in,
    RAM1_Q_latch_in,
    MAN_A_WEIGHT_in,
    state_in, 
    RAM2_WE_reg_out_in,
    RAM2_A_reg_out_in,
    wen0_out,
    wen1_out,
    wen2_out,
    wen3_out,
    wen4_out,
    wen5_out,
    wen6_out,
    wen7_out,
    data_en_out,
    RAM1_Q_latch_out,
    MAN_A_WEIGHT_out,
    state_out,
    RAM2_WE_reg_out_out,
    RAM2_A_reg_out_out
);
    
    input clk,rst;
    input wen0_in,wen1_in,wen2_in,wen3_in,wen4_in,wen5_in,wen6_in,wen7_in,data_en_in,RAM2_WE_reg_out_in;
    input [23:0] RAM1_Q_latch_in;
    input [2:0] MAN_A_WEIGHT_in;
    input [1:0] state_in;
    input [19:0] RAM2_A_reg_out_in;
    output reg wen0_out,wen1_out,wen2_out,wen3_out,wen4_out, wen5_out,wen6_out,wen7_out,data_en_out,RAM2_WE_reg_out_out;
    output reg [23:0] RAM1_Q_latch_out;
    output reg [2:0]  MAN_A_WEIGHT_out;
    output reg [1:0] state_out;
    output reg [19:0] RAM2_A_reg_out_out;




    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            wen0_out <= 1'b0;
            wen1_out <= 1'b0;
            wen2_out <= 1'b0;
            wen3_out <= 1'b0;
            wen4_out <= 1'b0;
            wen5_out <= 1'b0;
            wen6_out <= 1'b0;
            wen7_out <= 1'b0;
            data_en_out <=1'b0;
            RAM1_Q_latch_out <=24'h000000;
            MAN_A_WEIGHT_out <=3'b000;

            state_out <=2'b0;
            RAM2_WE_reg_out_out <=1'b0;
            RAM2_A_reg_out_out <=20'h00000;
        end
        else
        begin
            wen0_out <= wen0_in;
            wen1_out <= wen1_in;
            wen2_out <= wen2_in;
            wen3_out <= wen3_in;
            wen4_out <= wen4_in;
            wen5_out <= wen5_in;
            wen6_out <= wen6_in;
            wen7_out <= wen7_in;
            data_en_out <= data_en_in;
            RAM1_Q_latch_out <=RAM1_Q_latch_in;
            MAN_A_WEIGHT_out <=MAN_A_WEIGHT_in;
            
            state_out <=state_in;
            RAM2_WE_reg_out_out <=RAM2_WE_reg_out_in;
            RAM2_A_reg_out_out <=RAM2_A_reg_out_in;
        end    
    end

endmodule