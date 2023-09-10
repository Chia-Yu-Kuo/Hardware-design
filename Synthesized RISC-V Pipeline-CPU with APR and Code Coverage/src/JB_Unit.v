module JB_Unit (operand1,operand2,jb_out);
    input [31:0] operand1;  //rs1 or pc
    input [31:0] operand2;  //immm
    output reg [31:0] jb_out;

    always @(*) 
    begin
        jb_out=(operand1+operand2)&(~32'd1);      
    end



endmodule