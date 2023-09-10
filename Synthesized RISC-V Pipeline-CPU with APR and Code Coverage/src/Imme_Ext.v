module Imme_Ext (inst,imme_ext_out);
    input [31:0] inst;
    output reg [31:0] imme_ext_out;

    wire [4:0] opcode;
    parameter [4:0] R=5'b01100,Ii=5'b00100,Ij=5'b11001,Il=5'b00000,S=5'b01000,B=5'b11000,Ul=5'b01101,Ua=5'b00101,J=5'b11011;

    assign opcode = inst[6:2];

    always @(*) 
    begin
        case (opcode)
            R:
            begin
                imme_ext_out=32'b0;
            end 
            Ii:
            begin
                imme_ext_out={{20{inst[31]}},inst[31:20]};
            end
            Ij: 
            begin
                imme_ext_out={{20{inst[31]}},inst[31:20]};
            end                                                        ///////////??
            Il:
            begin
                imme_ext_out={{20{inst[31]}},inst[31:20]};
            end
            S:
            begin
                imme_ext_out={{20{inst[31]}},inst[31:25],inst[11:7]};                
            end
            B:
            begin
                imme_ext_out={{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0};                
            end
            Ul:
            begin
                imme_ext_out={inst[31:12],12'b0};                
            end            
            Ua:
            begin
                imme_ext_out={inst[31:12],12'b0};                
            end
            J:
            begin
                imme_ext_out={{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0};              
            end
            default:
            begin
                imme_ext_out=32'b0;     ///////
                
            end 
        endcase
    end


endmodule