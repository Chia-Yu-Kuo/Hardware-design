module Mux (i1,i2,sel,o);
    input [31:0] i1,i2;
    input sel;
    output [31:0] o;

    assign o = (sel) ? i2 : i1 ;        //0上 1下
    
endmodule