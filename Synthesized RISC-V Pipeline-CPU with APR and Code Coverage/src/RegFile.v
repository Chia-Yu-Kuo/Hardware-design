module RegFile (clk,rst,wb_en,wb_data,rd_index,rs1_index,rs2_index,rs1_data_out,rs2_data_out);
    input clk,rst;
    input wb_en;
    input [31:0] wb_data;
    input [4:0] rd_index,rs1_index,rs2_index;
    output reg[31:0] rs1_data_out,rs2_data_out;

    reg [31:0] registers[0:31];

    integer i;

/*
    parameter rd_i =rd_index ;          /////
    parameter rs1_i =rs1_index ;
    parameter rs2_i =rs2_index ;
*/
    //write rd 
    always @(posedge clk) 
    begin
	if(rst)
	begin
		for(i=0;i<32;i=i+1)
		begin
			registers[i] <=32'b0;
		end
	end
	else
	begin
		if (wb_en) 
        	begin
            		if (rd_index!=0) //x0
            		begin
            	    		registers [rd_index] <=wb_data;
           	 	end
            		else                                                                //??  all for keep?
           	 	begin
               	 		registers [rd_index] <= registers [rd_index];
           	 	end                         
        	end      
	end
          
    end

    //read rs1/rs2
    always @(*) 
    begin
        rs1_data_out=registers[rs1_index];
        rs2_data_out=registers[rs2_index];    
    end
    
endmodule
