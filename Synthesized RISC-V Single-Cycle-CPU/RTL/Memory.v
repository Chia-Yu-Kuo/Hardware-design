module RAM(clk,w_en,address,write_data,read_data);
    input clk;
    input w_en;
    input [11:0] address;
    input [31:0] write_data;
    output reg[31:0] read_data;

    reg [31:0] mem [0:4095];
    //parameter index= address;           ////////?? 用parameter?\

    
    //write(sequential)
    always @(posedge clk ) 
    begin
        if (w_en) 
        begin
            mem[address] <=write_data[31:0];           /////next cycle?
        end
        else
        begin
            mem[address] <=mem[address] ;
        end
    end

    //read(comb)    fetch
    always @(*) 
    begin
        read_data = mem[address];
    end

endmodule
