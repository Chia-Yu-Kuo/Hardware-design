//*************************************************
//** 2019 spring iVCAD
//** Description: Random-access memory
//** Mar. 2018 Henry authored
//** Mar. 2019 Kevin revised
//** Mar. 2020 Claire revised
//*************************************************

`timescale 1ns/10ps

module RAM (CK, A, WE, OE, D, Q);

  input         CK;     //clk
  input  [17:0] A;      //address
  input         WE;     //write enable
  input         OE;     //read enable
  input  [23:0] D;      //write data
  output [23:0] Q;      //read data

  reg    [23:0] Q;
 // reg    [19:0] latched_A;
  reg    [17:0] latched_A_neg;
  reg    [23:0] memory [0:4095];
  
  //write
  always @(posedge CK) begin
  
    if (WE) begin
	
		memory[A] <= D;
		
    end
	
	//	latched_A <= A;
  end
  
  always@(negedge CK) begin
	latched_A_neg <= A; //latched_A;
  end
  
  //read
  always @(*) begin
  
    if (OE) begin
	
      Q = memory[latched_A_neg];
	  
    end
    else begin
	
      Q = 24'hZZZ;      //z
	  
    end
	
  end

endmodule