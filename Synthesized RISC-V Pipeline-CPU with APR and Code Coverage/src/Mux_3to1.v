module Mux_3to1 (i1,i2,i3,sel,o);
    input [31:0] i1,i2,i3;
    input [1:0] sel;
    output reg [31:0] o;

    //0上 1中 2下
    always @(*) 
    begin
        case (sel)
            2'd0:
            begin
                o=i1;
            end 
            2'd1:
            begin
                o=i2;
            end
            2'd2:
            begin
                o=i3;
            end
            default:
                o=32'b0;
        endcase    
    end

endmodule