`timescale 1ns / 1ps

module waveform_tb();
//input
reg clk;
reg reset;
//output
wire vinit;
wire vcomp;
wire vscan;
wire vem1;
wire vem2;
//Unit under test (UUT)
waveform uut(
    .clk(clk),
    .reset(reset),
    .vinit(vinit),
    .vcomp(vcomp),
    .vscan(vscan),
    .vem1(vem1),
    .vem2(vem2)
    );
 initial
 begin
   reset=0;
   clk=0;
   #10 reset=1;
   #10 reset=0;
   #1800000 $finish;  
 end
 always #5 clk=!clk;   
endmodule

