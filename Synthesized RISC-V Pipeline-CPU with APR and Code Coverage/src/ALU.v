module ALU (opcode,func3,func7,operand1,operand2,alu_out,branch_taken);
    input [4:0] opcode;
    input [2:0] func3;
    input       func7;
    input [31:0] operand1,operand2;
    output reg [31:0] alu_out;              // branch taken ==1;
    output reg branch_taken;

    wire signed [31:0] operand1_s,operand2_s;
    reg signed [31:0] alu_out_s;

    parameter [4:0] R=5'b01100,Ii=5'b00100,Ij=5'b11001,Il=5'b00000,S=5'b01000,B=5'b11000,Ul=5'b01101,Ua=5'b00101,J=5'b11011;


    assign operand1_s=operand1;
    assign operand2_s=operand2;

    always @(*) 
    begin
        //default
        branch_taken=1'b0;
        alu_out_s=32'b0;
	alu_out=32'b0;
        case (opcode)
            R:
            begin
                case (func3)
                    3'b000:
                    begin
                        if (func7)  // -
                        begin
                            alu_out=operand1-operand2 ;   
                        end
                        else        // +
                        begin
                            alu_out=operand1+operand2 ;                               
                        end
                    end     
                    3'b001:         //  <<
                    begin
                        alu_out=operand1<<operand2[4:0];    
                    end
                    3'b010:     // slt
                    begin
                        alu_out=(operand1_s<operand2_s) ? 32'd1 : 32'b0;            ///////???
                    end
                    3'b011:     //sltu                                      
                    begin
                        alu_out=(operand1<operand2) ? 32'd1 : 32'b0;            ///////???                       
                    end
                    3'b100:     // xor
                    begin
                        alu_out=operand1^operand2;
                    end
                    3'b101:      
                    begin
                        if (func7) //sra
                        begin
                            alu_out_s=operand1_s >>> operand2[4:0]; 
                            alu_out=alu_out_s;          
                        end
                        else        //srl
                        begin
                            alu_out=operand1 >> operand2[4:0];               
                        end
                    end
                    3'b110:     //  or
                    begin
                        alu_out=operand1|operand2;                       
                    end
                    3'b111:     // and
                    begin
                        alu_out=operand1&operand2;                        
                    end                    
                    default: 
                    begin
                        alu_out=32'b0;                       
                    end                   
                endcase
            end 
            Ii:
            begin
                case (func3)
                    3'b000:     // +
                    begin                      
                        alu_out=operand1+operand2 ;                               
                    end     
                    3'b001:         //  <<
                    begin
                        alu_out=operand1<<operand2[4:0];   
                    end
                    3'b010:     // slt
                    begin
                        alu_out=(operand1_s<operand2_s) ? 32'd1 : 32'b0;        /////??
                    end
                    3'b011:     //sltu                                      
                    begin
                        alu_out=(operand1<operand2) ? 32'd1 : 32'b0;                     ////  ??  
                    end
                    3'b100:     // xor
                    begin
                        alu_out=operand1^operand2;
                    end
                    3'b101:     
                    begin
                        if (func7)  //      srai
                        begin
                            alu_out_s=operand1_s >>> operand2[4:0];  
                            alu_out=alu_out_s;          
                        end
                        else        //srli
                        begin
                            alu_out=operand1>>operand2[4:0];
                        end
                    end
                    3'b110:     //  or
                    begin
                        alu_out=operand1|operand2;                       
                    end
                    3'b111:     // and
                    begin
                        alu_out=operand1&operand2;                        
                    end 
                    default: 
                    begin
                        alu_out=32'b0;                       
                    end
                endcase
            end
            Ij:
            begin
                alu_out=operand1+32'd4;
            end
            Il:
            begin
                alu_out=operand1+operand2;
            end
            S:
            begin
                alu_out=operand1+operand2;                      
            end
            B:                                      //by bit[0]
            begin
                case (func3)
                    3'b000:     //beq
                    begin
                        if (operand1==operand2) 
                        begin
                           branch_taken=1'b1;     
                        end
                        else
                        begin
                            branch_taken=1'b0;                                 
                        end
                    end 
                    3'b001:     //bne
                    begin
                        if (operand1!=operand2) 
                        begin
                            branch_taken=1'b1;     
                        end
                        else
                        begin
                            branch_taken=1'b0;                                 
                        end
                    end
                    3'b100:     //blt
                    begin
                        if (operand1_s<operand2_s)         ///?
                        begin
                            branch_taken=1'b1;     
                        end
                        else
                        begin
                            branch_taken=1'b0;                                 
                        end                        
                    end
                    3'b101:     //bge
                    begin
                        if (operand1_s>=operand2_s) 
                        begin
                            branch_taken=1'b1;     
                        end
                        else
                        begin
                            branch_taken=1'b0;                                 
                        end                        
                    end
                    3'b110:     //bltu
                    begin
                        if (operand1<operand2)         ///?
                        begin
                           branch_taken=1'b1;     
                        end
                        else
                        begin
                            branch_taken=1'b0;                                 
                        end
                    end
                    3'b111:     //bgeu
                    begin
                        if (operand1>=operand2) 
                        begin
                            branch_taken=1'b1;     
                        end
                        else
                        begin
                            branch_taken=1'b0;                                 
                        end
                    end
                    default:
                    begin
                        alu_out=32'b0;
                    end 
                endcase              
            end
            Ul:
            begin
                alu_out=operand2;        
            end
            Ua:
            begin
                alu_out=operand1+operand2;
            end
            J:
            begin
                alu_out=operand1+32'd4;                          
            end
            default: 
                alu_out=32'b0;
                
        endcase
    end
endmodule
