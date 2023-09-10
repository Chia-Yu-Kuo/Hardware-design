module Reg_MAN (             //要八個
        clk,
        rst,
        d0_out_in,
        d1_out_in,
        d2_out_in,
        d3_out_in,
        d4_out_in,
        d5_out_in,
        d6_out_in,
        d7_out_in,
        d0_out_out,
        d1_out_out,
        d2_out_out,
        d3_out_out,
        d4_out_out,
        d5_out_out,
        d6_out_out,
        d7_out_out,
    );

    input clk,rst;
    input [9:0] d0_out_in,d1_out_in,d2_out_in,d3_out_in,d4_out_in,d5_out_in,d6_out_in,d7_out_in;
    output reg [9:0] d0_out_out,d1_out_out,d2_out_out,d3_out_out,d4_out_out,d5_out_out,d6_out_out,d7_out_out;



    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            d0_out_out <= 10'b0000000000;
            d1_out_out <= 10'b0000000000;   
            d2_out_out <= 10'b0000000000;
            d3_out_out <= 10'b0000000000;
            d4_out_out <= 10'b0000000000;
            d5_out_out <= 10'b0000000000;
            d6_out_out <= 10'b0000000000;
            d7_out_out <= 10'b0000000000;
        end
        else
        begin
            d0_out_out <= d0_out_in;
            d1_out_out <= d1_out_in;   
            d2_out_out <= d2_out_in;
            d3_out_out <= d3_out_in;
            d4_out_out <= d4_out_in;
            d5_out_out <= d5_out_in;
            d6_out_out <= d6_out_in;
            d7_out_out <= d7_out_in;
        end    
    end

endmodule