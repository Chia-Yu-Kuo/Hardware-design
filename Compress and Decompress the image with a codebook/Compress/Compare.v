module  Compare(
    d8_min,         //trash
    d8_min_pos,
    d0_min_pos,
    d1_min_pos,
    d2_min_pos,
    d3_min_pos,
    d4_min_pos,
    d5_min_pos,
    d6_min_pos,
    d7_min_pos,
    RAM2_D
);

    input [9:0] d8_min;
    input [2:0]d8_min_pos,d0_min_pos,d1_min_pos,d2_min_pos,d3_min_pos,d4_min_pos,d5_min_pos,d6_min_pos,d7_min_pos;
    output reg [23:0] RAM2_D;



    //RAM2_D
    always @(*) 
    begin
        case (d8_min_pos)
        3'd0:
        begin
            RAM2_D={{21'd0},d0_min_pos};
        end
        3'd1: 
        begin
            RAM2_D={{21'd0},d1_min_pos}+24'd8;
        end
        3'd2: 
        begin
            RAM2_D={{21'd0},d2_min_pos}+24'd16;
        end
        3'd3:
        begin
            RAM2_D={{21'd0},d3_min_pos}+24'd24;
        end 
        3'd4: 
        begin
            RAM2_D={{21'd0},d4_min_pos}+24'd32;
        end
        3'd5:
        begin
            RAM2_D={{21'd0},d5_min_pos}+24'd40;
        end 
        3'd6:
        begin
            RAM2_D={{21'd0},d6_min_pos}+24'd48;
        end 
        3'd7:
        begin
            RAM2_D={{21'd0},d7_min_pos}+24'd56;
        end 
        endcase    
    end

    
endmodule