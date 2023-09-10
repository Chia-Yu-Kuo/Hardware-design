module Controller (clk,rst,op_in,f3_in,f7_in,rs1_index_in,rs2_index_in,rd_index_in,branch_taken,F_im_w_en,D_rs1_data_sel,D_rs2_data_sel,E_rs1_data_sel,E_rs2_data_sel,E_jb_op_sel,E_alu_op1_sel,E_alu_op2_sel,E_opcode_out,E_func3_out,E_func7_out,M_dm_w_en,W_wb_en,W_rd_index,W_f3_out,W_wb_data_sel,stall,jb);
    input clk,rst;
    input [4:0] op_in;
    input [2:0] f3_in;
    input f7_in,branch_taken;
    input [4:0] rs1_index_in,rs2_index_in,rd_index_in;
    output [3:0] F_im_w_en;  //
    output reg [3:0] M_dm_w_en;
    output reg D_rs1_data_sel,D_rs2_data_sel;
    output reg [1:0] E_rs1_data_sel,E_rs2_data_sel;
    output reg E_jb_op_sel,E_alu_op1_sel,E_alu_op2_sel;
    output [4:0] E_opcode_out;  //
    output [2:0] E_func3_out;  //
    output E_func7_out;  //
    output reg W_wb_en,W_wb_data_sel;
    output [4:0] W_rd_index;  //
    output [2:0] W_f3_out;  //
    output stall;  //
    output reg jb;  //

    reg [4:0] E_op,M_op,W_op;
    reg [2:0] E_f3,M_f3,W_f3;
    reg [4:0] E_rd,M_rd,W_rd;
    reg [4:0] E_rs1,E_rs2;
    reg E_f7;

    parameter [4:0] R=5'b01100,Ii=5'b00100,Ij=5'b11001,Il=5'b00000,S=5'b01000,B=5'b11000,Ul=5'b01101,Ua=5'b00101,J=5'b11011;


    assign F_im_w_en=4'b0000;
    //assign jb=(branch_taken);// | (E_op==Ij) | (E_op==J);
    assign E_opcode_out=E_op;
    assign E_func3_out=E_f3;
    assign E_func7_out=E_f7;
    assign W_rd_index=W_rd;
    assign W_f3_out=W_f3;
    assign stall=   (E_op==Il ||E_op==Ul ||E_op==Ua) & 
                    ( ( (op_in==R | op_in==Ii | op_in==Il |op_in==S |op_in==B |op_in==Ij)&(rs1_index_in==E_rd)&(E_rd!=1'b0) ) |
                    ( (op_in==R||op_in==B||op_in==S)&(rs2_index_in==E_rd)&(E_rd!=1'b0) )  );      //stall
        //  ??   |op_in==J
    //jb
    always @(*) 
    begin
        if (branch_taken || (E_op==Ij) || (E_op==J)) 
        begin
            jb=1'b1;    
        end
        else
        begin
            jb=1'b0;
        end
    end

    //reg state 傳下去
    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            E_op <=5'b0;
            M_op <=5'b0;
            W_op <=5'b0;     
            E_f3 <=3'b0;
            M_f3 <=3'b0;
            W_f3 <=3'b0;
            E_rd <=5'b0;
            M_rd <=5'b0;
            W_rd <=5'b0;
            E_rs1 <=5'b0;
            E_rs2 <=5'b0;
            E_f7 <=1'b0;
        end
        else
        begin
            if (stall | jb)         // output可拿來用?  //flush
            begin
                E_op <= 5'b00100;
                M_op <= E_op;
                W_op <= M_op;     
                E_f3 <= 3'b0;
                M_f3 <= E_f3;
                W_f3 <= M_f3;
                E_rd <= 5'b0;
                M_rd <= E_rd;
                W_rd <= M_rd;
                E_rs1 <= 5'b0;
                E_rs2 <= 5'b0;
                E_f7 <= 1'b0;
            end
            else
            begin
                E_op <= op_in;
                M_op <= E_op;
                W_op <= M_op;     
                E_f3 <= f3_in;
                M_f3 <= E_f3;
                W_f3 <= M_f3;
                E_rd <= rd_index_in;
                M_rd <= E_rd;
                W_rd <= M_rd;
                E_rs1 <= rs1_index_in;
                E_rs2 <= rs2_index_in;
                E_f7 <= f7_in;
            end
        end    
    end


    //output

   


    //D
    always @(*)                                                                 /////////???????????????
    begin
        //rs1
        if ((op_in==R || op_in==Ii || op_in==Il ||op_in==S ||op_in==B  || op_in==Ij)&&(W_wb_en==1'b1)&&(rs1_index_in==W_rd)&&(W_rd!=1'b0)) 
        begin
             D_rs1_data_sel=1'b1;
        end
        else
        begin
            D_rs1_data_sel=1'b0;
        end
        //rs2
        if ((op_in==R||op_in==B ||op_in==S)&&(W_wb_en==1'b1)&&(rs2_index_in==W_rd)&&(W_rd!=1'b0)) 
        begin
             D_rs2_data_sel=1'b1;
        end
        else
        begin
            D_rs2_data_sel=1'b0;
        end

    end
    //E
    //rs12_data_sel
    always @(*) 
    begin
        //rs1
        if ((E_op==R || E_op==Ii || E_op==Il ||E_op==S ||E_op==B || E_op==Ij)&&(M_op!=S && M_op!=B)&&(E_rs1==M_rd)&&(M_rd!=1'b0))    
        begin
                E_rs1_data_sel=2'd1;                
        end    
        else
        begin
            if ((E_op==R || E_op==Ii || E_op==Il ||E_op==S ||E_op==B  || E_op==Ij)&&(W_wb_en==1'b1)&&(E_rs1==W_rd)&&(W_rd!=1'b0)) //w use ==> judged by op ?? reg not output ??
            begin
                E_rs1_data_sel=2'd0;                
            end
            else
            begin
                E_rs1_data_sel=2'd2;
            end            
        end
        //rs2
        if ((E_op==R || E_op==B || E_op==S)&&(M_op!=S && M_op!=B)&&(E_rs2==M_rd)&&(M_rd!=1'b0))    
        begin
                E_rs2_data_sel=2'd1;                
        end    
        else
        begin
            if ((E_op==R || E_op==B ||E_op==S)&&(W_wb_en==1'b1)&&(E_rs2==W_rd)&&(W_rd!=1'b0)) //w use ==> judged by op ?? reg not output ??
            begin
                E_rs2_data_sel=2'd0;                
            end
            else
            begin
                E_rs2_data_sel=2'd2;
            end            
        end

    end

    //other
    always @(*) 
    begin
        case (E_op)
            R:           
            begin
                E_alu_op1_sel=1'b0;
                E_alu_op2_sel=1'b0;
                E_jb_op_sel=1'b0;        //隨便
            end 
            Ii:
            begin
                E_alu_op1_sel=1'b0;
                E_alu_op2_sel=1'b1;
                E_jb_op_sel=1'b0;            //隨便
            end
            Ij:
            begin
                E_alu_op1_sel=1'b1;
                E_alu_op2_sel=1'b0;       //隨便
                E_jb_op_sel=1'b0;        //rs1
            end            
            Il:
            begin
                E_alu_op1_sel=1'b0;
                E_alu_op2_sel=1'b1;       
                E_jb_op_sel=1'b0;        //隨便            
            end            
            S:
            begin
                E_alu_op1_sel=1'b0;
                E_alu_op2_sel=1'b1;       
                E_jb_op_sel=1'b0;        //隨便
            end            
            B:
            begin
                E_alu_op1_sel=1'b0;
                E_alu_op2_sel=1'b0;       
                E_jb_op_sel=1'b1;        //pc
            end
            Ul:
            begin
                E_alu_op1_sel=1'b0;       //隨便
                E_alu_op2_sel=1'b1;       
                E_jb_op_sel=1'b0;        //隨便
            end
            Ua:
            begin
                E_alu_op1_sel=1'b1;       //pc
                E_alu_op2_sel=1'b1;       
                E_jb_op_sel=1'b0;        //隨便
            end
            J:
            begin
                E_alu_op1_sel=1'b1;       //pc
                E_alu_op2_sel=1'b0;       //隨便
                E_jb_op_sel=1'b1;        //pc
            end
            default: 
            begin
                E_alu_op1_sel=1'b0;
                E_alu_op2_sel=1'b0;       
                E_jb_op_sel=1'b0;        
            end
        endcase
    end


    //M
    always @(*) 
    begin
        if (M_op==5'b01000) 
        begin
            case (M_f3)
                    3'b000:     //sb
                    begin
                        M_dm_w_en=4'b0001;                       
                    end 
                    3'b001:     //sh
                    begin
                        M_dm_w_en=4'b0011;                       
                    end
                    3'b010:     //sw
                    begin
                        M_dm_w_en=4'b1111;                       
                    end
                    default: 
                    begin
                        M_dm_w_en=4'b0;                                              
                    end
            endcase
        end  
        else
        begin
            M_dm_w_en=4'b0;
        end  
    end

    //W
    always @(*) 
    begin
        case (W_op)
            R:           
            begin
                W_wb_en=1'b1;
                W_wb_data_sel=1'b0;
            end 
            Ii:
            begin
                W_wb_en=1'b1;
                W_wb_data_sel=1'b0;
            end
            Ij:
            begin
                W_wb_en=1'b1;
                W_wb_data_sel=1'b0;
            end            
            Il:
            begin  
                W_wb_en=1'b1;
                W_wb_data_sel=1'b1;       
            end            
            S:
            begin  
                W_wb_en=1'b0;
                W_wb_data_sel=1'b0;
            end            
            B:
            begin 
                W_wb_en=1'b0;
                W_wb_data_sel=1'b0;
            end
            Ul:
            begin
                W_wb_en=1'b1;
                W_wb_data_sel=1'b0;
            end
            Ua:
            begin   
                W_wb_en=1'b1;
                W_wb_data_sel=1'b0;
            end
            J:
            begin
                W_wb_en=1'b1;
                W_wb_data_sel=1'b0;
            end
            default: 
            begin
                W_wb_en=1'b0;    
                W_wb_data_sel=1'b0;
            end
        endcase
    end
    
endmodule
