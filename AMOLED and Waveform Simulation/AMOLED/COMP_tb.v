// COMP_tb.v
`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
`define VTH_dat "./VTH.txt"
`define VDATA_dat "./VDATA_40nA.txt" //change verified VDATA here!


module COMP_tb;
	
	reg clk, reset;
	reg [8:0] IOLED; 
	reg [3:0] K;  
	reg [15:0] VDD; 
	reg [15:0] VTH; 
	
	wire [15:0] VDATA; 

	integer i, err;
	integer num = 0;	
	reg [15:0] VTH_in [0:19];
	reg [15:0] VDATA_out [0:19];
	reg stop;
	reg ready;
	reg ready_VDATA;

	
    COMP comp(.clk(clk), .reset(reset), .IOLED(IOLED), .K(K), .VDD(VDD), .VTH(VTH), .VDATA(VDATA) );

initial 
begin

    $readmemb (`VTH_dat,VTH_in);
    $readmemb (`VDATA_dat,VDATA_out);
    
end
	
initial begin
  clk = 0;
  i = 0;
  ready = 0;
  ready_VDATA = 0;
  stop = 0;
  err = 0;
	
end

// duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
always #20 clk = ~clk;	
	
// reset
initial 
begin 
	reset = 0;
	#40;
	reset = 1;
	#60;
	reset = 0;
	#20;
	ready = 1;
	#20;
	ready_VDATA = 1;
end	
	

always @(negedge clk) 
  begin
   if (!ready) begin
	IOLED = 0;  
	K = 10;  
	VDD = 0; 
	VTH = 0; 
   end
   else begin
    IOLED = 9'd40; // change your IOLED here!
	K = 4'd10;  
	VDD = 4'd8 << 8; 
	VTH = VTH_in[i]; 
	i=i+1 ;
		
	if (i == 21)
	stop = 1 ;

	if(ready_VDATA) begin
		if(VDATA == VDATA_out[num])
		$display("%d VDATA is correct %h", num, VDATA_out[num]);
		else begin
		$display("%d VDATA is error %h, correct is %h, when IOLED=%d nA, K=%d nA/v2, VDD=%h, VTH=%h", num, VDATA, VDATA_out[num], IOLED, K, VDD, VTH_in[num]);
		err = err + 1;
		end
		num=num+1;

	end

   end

  end  

  
initial begin
      @(posedge stop)
      $display("---------------------------------------------\n");
      if (err == 0)
        begin
          $display("All VDATA have been generated successfully!\n");
          $display("-------------------PASS-------------------\n");
        end
      else 
      $display("There are %d errors!\n", err);
      $display("---------------------------------------------\n");
      $finish;
   end
   

endmodule  
  

