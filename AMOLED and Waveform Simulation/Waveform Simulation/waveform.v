module waveform(clk,reset,vinit,vcomp,vscan,vem1,vem2);
    input clk;  //FPGA內建100M Hz Clock  clk period=10ns
    input reset;  
    output reg vinit;
    output reg vcomp;
    output reg vscan;
    output reg vem1;
    output reg vem2;

    reg [15:0]counter;
    reg [2:0]stage;

   

    always@(posedge clk or negedge reset)
    begin
        if(reset) 
        begin
            counter=16'b0;
        end
        else 
        begin
            if (counter<16'd30000) 
            begin
                counter<=counter+16'd1;
            end
            else
            begin
                counter<=16'b0;
            end
        end
    end

    always @(*) 
    begin
        if (counter<16'd2000) 
        begin
            stage=3'd0;
        end 
        else if (counter<16'd5000)
        begin
            stage=3'd1;
        end   
        else if (counter<16'd25000) 
        begin
            stage=3'd2;    
        end
        else if (counter<16'd28000) 
        begin
            stage=3'd3;    
        end
        else if (counter<16'd30000) 
        begin
            stage=3'd4;
        end
        else
        begin
            stage=3'd7;
        end
    end

    always @(*) 
    begin
        case (stage)
            3'd0:
            begin
                vinit=1;
                vcomp=1;
                vscan=0;
                vem1=0;
                vem2=0;
            end 
            3'd1:
            begin
                vinit=0;
                vcomp=1;
                vscan=1;
                vem1=0;
                vem2=0;
            end
            3'd2:
            begin
                vinit=0;
                vcomp=0;
                vscan=0;
                vem1=1;
                vem2=1;
            end
            3'd3:
            begin
                vinit=0;
                vcomp=1;
                vscan=0;
                vem1=1;
                vem2=1;
            end
            3'd4:
            begin
                vinit=0;
                vcomp=0;
                vscan=0;
                vem1=1;
                vem2=0;
            end
            default: 
            begin
                vinit=1'bZ;
                vcomp=1'bZ;
                vscan=1'bZ;
                vem1=1'bZ;
                vem2=1'bZ;
            end
        endcase
    end
endmodule
