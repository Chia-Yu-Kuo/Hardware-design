module FP_adder(FA, FB, op, FS);
input [31:0] FA, FB;
input op; // 0 for add, 1 for sub
output [31:0] FS;

wire [31:0] FB_M;
wire [7:0] FA_E, FB_E, FS_E;
wire FA_S, FB_S, FS_S;
wire [22:0] FA_F, FB_F, FS_F;
wire [25:0] FB_F_shift;
wire [25:0] FA_F_ext, FB_F_ext;
wire [25:0] FA_F_com, FB_F_com;
wire [25:0] FS_F_cal, FS_F_com;
wire [4:0] FS_shift;
wire [7:0] exp_diff;
wire valid, zero;

// merge operation signal and unsigned signal of FB
assign FB_M = {FB[31]^op, FB[30:0]};

// sign, exponent, float point
// let FB less than FA
assign {FA_S, FA_E, FA_F} = (FA[30:23]>FB[30:23]) ? FA : FB_M;
assign {FB_S, FB_E, FB_F} = (FA[30:23]>FB[30:23]) ? FB_M : FA;

// extend hidden bit
assign FA_F_ext = {3'b001, FA_F};
assign FB_F_ext = {3'b001, FB_F};


// shift FB to the same position as FA
assign exp_diff = FA_E - FB_E;
assign FB_F_shift = FB_F_ext >> exp_diff;

// if sign is negative, complememt it
assign FA_F_com = (FA_S) ? ~FA_F_ext + 26'b1 : FA_F_ext;
assign FB_F_com = (FB_S) ? ~FB_F_shift + 26'b1 : FB_F_shift;

// calculate result
// if result negative, complement
assign FS_F_cal = FA_F_com + FB_F_com;
assign FS_F_com = (FS_F_cal[25]) ? ~FS_F_cal + 26'b1 : FS_F_cal;


PENC32 P0({8'b0, FS_F_com[23:0]}, FS_shift, valid);

assign FS_S = FS_F_cal[25];
//shift of not
assign FS_E = (FS_F_com[24]) ? FA_E + 8'b1 : FA_E - (5'd23 - FS_shift);
assign FS_F = (FS_F_com[24]) ? FS_F_com[23:1] : FS_F_com[22:0] <<(5'd23 - FS_shift);

//zero
assign zero = ~(valid|FS_F_com[24]|FS_F_com[25]);
assign FS = (zero) ? 32'b0 : {FS_S, FS_E, FS_F};

endmodule


module PENC4(Din, Dout, Valid);
input [3:0] Din;
output [1:0] Dout;
output Valid;

assign Dout[1] = Din[3]|Din[2];
assign Dout[0] = Din[3]|(Din[1]&(~Din[2]));
assign Valid = |Din;

endmodule


module PENC8(Din, Dout, Valid);
input [7:0] Din;
output [2:0] Dout;
output Valid;

wire [1:0] dout0, dout1;
wire v0, v1;

PENC4 P0(Din[3:0], dout0, v0);
PENC4 P1(Din[7:4], dout1, v1);

assign Dout[2] = v1;
assign Dout[1:0] = (Dout[2]) ? dout1 : dout0;
assign Valid = v0|v1;

endmodule


module PENC32(Din, Dout, Valid);
input [31:0] Din;
output [4:0] Dout;
output Valid;

wire [2:0] dout0, dout1, dout2, dout3;
wire v0, v1, v2, v3;

PENC8 P0(Din[7:0], dout0, v0);
PENC8 P1(Din[15:8], dout1, v1);
PENC8 P2(Din[23:16], dout2, v2);
PENC8 P3(Din[31:24], dout3, v3);

assign Dout[4] = v2|v3;
assign Dout[3] = v3|((~v2)&v1);
assign Dout[2:0] = (Dout[4]) ? ((Dout[3]) ? dout3 : dout2) : ((Dout[3]) ? dout1 : dout0);
assign Valid = v0|v1|v2|v3;

endmodule