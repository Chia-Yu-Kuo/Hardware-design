module Reg_PC (clk,rst,next_pc,stall,current_pc);           
    input clk,rst,stall;
    input [15:0] next_pc;
    output reg [15:0] current_pc;


    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            current_pc <= 16'b0;    
        end
        else
        begin
            if (stall) 
            begin
                current_pc <= current_pc;
            end
            else
            begin
                current_pc <= next_pc;    
            end
        end    
    end




endmodule