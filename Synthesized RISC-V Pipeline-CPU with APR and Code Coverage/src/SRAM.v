module SRAM(clk,w_en,address,write_data,read_data);
    input clk;
    input [3:0] w_en;
    input [15:0] address;
    input [31:0] write_data;
    output reg[31:0] read_data;

    reg [7:0] mem [0:65535];
    //parameter index= address;           ////////?? 用parameter?\

    
    //write(sequential)
    always @(posedge clk) 
    begin
        if (w_en[0]) 
        begin
            mem[address] <=write_data[7:0];           /////next cycle?
        end
        else
        begin
            mem[address] <=mem[address];           /////next cycle?
        end

        if (w_en[1]) 
        begin
            mem[address+1] <=write_data[15:8];
        end
        else
        begin
             mem[address+1] <= mem[address+1];
        end

        if (w_en[2]) 
        begin
            mem[address+2] <=write_data[23:16];
        end
        else
        begin
             mem[address+2] <= mem[address+2] ;
        end

        if (w_en[3]) 
        begin
            mem[address+3] <=write_data[31:24];
        end  
        else
        begin
            mem[address+3] <=mem[address+3] ;
        end      
    end


    //read(comb)    fetch
    always @(*) 
    begin
        read_data ={mem[address+3],mem[address+2],mem[address+1],mem[address]};
    end

/*
    assign read_data[7:0]=mem[address];
    assign read_data[15:8]=mem[address+1];
    assign read_data[23:16]=mem[address+2];
    assign read_data[31:24]=mem[address+3];     
*/
//assign   read_data ={mem[address+3],mem[address+2],mem[address+1],mem[address]};
endmodule
