module MAN (
    clk,
    rst,
    weight_en,
    weight_data,
    weight_A,
    tag_en,
    tag_A,
    MAN_out
);

    input clk,rst;
    input weight_en,tag_en;
    input [23:0] weight_data;
    input [5:0] weight_A , tag_A;
    output reg [23:0] MAN_out;


    reg [23:0] weight [63:0];

     integer i; 
    //weight
    always @(posedge clk or posedge rst)
    if(rst)
    begin
    	for(i=0;i<64;i=i+1)
 	begin
	   weight[i]<=24'b0;
	end
    end
    else 
    begin
        if (weight_en)      //else latch?
        begin
           weight[weight_A] <= weight_data;
        end
    end

    //MAN_out
    always @(*) 
    begin
        if (tag_en)         
        begin
            MAN_out=weight[tag_A];
        end
        else
        begin
            MAN_out=24'h000000;
        end
    end
    
endmodule
