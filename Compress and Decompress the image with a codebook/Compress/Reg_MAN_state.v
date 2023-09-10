module Reg_MAN_state (            
        clk,
        rst,
        state_in,
        RAM2_WE_reg_out_in,
        RAM2_A_reg_out_in,
        state_out,
        RAM2_WE_reg_out_out,
        RAM2_A_reg_out_out
    );

    input clk,rst;
    input [1:0]state_in;
    input RAM2_WE_reg_out_in;
    input [19:0] RAM2_A_reg_out_in;  
    output reg [1:0] state_out;
    output reg  RAM2_WE_reg_out_out;
    output reg [19:0] RAM2_A_reg_out_out;


    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            state_out <= 2'b00;
            RAM2_WE_reg_out_out <=1'b0;
            RAM2_A_reg_out_out <=20'h00000;
        end
        else
        begin
            state_out<= state_in;
            RAM2_WE_reg_out_out <=RAM2_WE_reg_out_in;
            RAM2_A_reg_out_out <=RAM2_A_reg_out_in;
        end    
    end

endmodule