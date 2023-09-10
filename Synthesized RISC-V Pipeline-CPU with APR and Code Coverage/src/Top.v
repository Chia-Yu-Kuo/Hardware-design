`include "./src/Adder.v"
`include "./src/ALU.v"
`include "./src/Controller.v"
`include "./src/Decoder.v"
`include "./src/Imme_Ext.v"
`include "./src/JB_Unit.v"
`include "./src/LD_Filter.v"
`include "./src/Mux_3to1.v"
`include "./src/Mux.v"
`include "./src/Reg_D.v"
`include "./src/Reg_E.v"
`include "./src/Reg_M.v"
`include "./src/Reg_PC.v"
`include "./src/Reg_W.v"
`include "./src/RegFile.v"
`include "./src/MuxPC.v"
//`include "./src/SRAM.v"




module Top (clk,rst,im_read_data,dm_read_data,im_w_en,dm_w_en,im_address,dm_address,im_w_data,dm_w_data);
    input clk,rst;
    input [31:0] im_read_data,dm_read_data;
    output [3:0] im_w_en,dm_w_en;
    output [15:0] im_address,dm_address;
    output [31:0] im_w_data,dm_w_data;

    //pc d
    wire [15:0] pc_d_1;

    //d e
    wire [31:0] d_e_2,d_e_3,d_e_4,d_e_5,d_e_6,d_e_7,d_e_8;
	wire [15:0] d_e_1;
    wire [4:0] d_e_51,d_e_52,d_e_53;    
    //e m
    wire [31:0] e_m_2,e_m_3,e_m_4,e_m_5,e_m_6,e_m_7,e_m_8,e_m_9,e_m_10,e_m_11;
	wire [15:0] e_m_1;
    //m w
    wire [31:0] m_w_2;
	wire [15:0] m_w_1;
    //e or w to pc
    wire [31:0] e_p_2,e_p_4,e_p_5,e_p_6; 
	wire [15:0] e_p_1,e_p_3;
    //control
    wire c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12;
    wire [1:0] c_21,c_22;
    wire [2:0] c_31,c_32,c_33;
    wire [4:0] c_51,c_52,c_53;

   //assign im_read_data=pc_d_3;
   //assign dm_read_data=m_w_3;
   //assign im_w_en=c_41;
   //assign dm_w_en=c_42; 
   assign im_address = pc_d_1;
   assign dm_address = e_m_5[15:0];
   assign im_w_data = 32'b0;
   //assign dm_w_data = m_w_2;

    Adder adder(
        .current_pc(pc_d_1),
        .current_pc_add4(e_p_1)
    );

    MuxPC mux_next_pc(
        .i1(e_p_1),
        .i2(e_p_2[15:0]),
        .sel(c_1),
        .o(e_p_3)
    );

    Reg_PC reg_pc(
        .clk(clk),
        .rst(rst),
        .stall(c_2),
        .next_pc(e_p_3),
        .current_pc(pc_d_1)        
    );
/*
    SRAM im(
        .clk(clk),
        .w_en(c_41),
        .address(pc_d_1[15:0]),
        .write_data(pc_d_2),                                              
        .read_data(pc_d_3)
    );
*/
    Reg_D reg_d(
        .clk(clk),
        .rst(rst),
        .stall(c_2),
        .jb(c_1),
        .current_pc_in(pc_d_1),
        .inst_in(im_read_data),
        .current_pc_out(d_e_1),
        .inst_out(d_e_2)
    );
    

    Decoder decoder(
        .inst(d_e_2),  
        .dc_out_opcode(c_51),
        .dc_out_func3(c_31),
        .dc_out_func7(c_3),
        .dc_out_rs1_index(d_e_51),
        .dc_out_rs2_index(d_e_52),
        .dc_out_rd_index(d_e_53)
    );


    Controller controller(
        .clk(clk),
        .rst(rst),
        .op_in(c_51),
        .f3_in(c_31),
        .f7_in(c_3),
        .branch_taken(c_4),
        .rs1_index_in(d_e_51),
        .rs2_index_in(d_e_52),
        .rd_index_in(d_e_53),
        .F_im_w_en(im_w_en),
        .M_dm_w_en(dm_w_en),
        .D_rs1_data_sel(c_5),
        .D_rs2_data_sel(c_6),
        .E_rs1_data_sel(c_21),
        .E_rs2_data_sel(c_22),
        .E_jb_op_sel(c_7),
        .E_alu_op1_sel(c_8),
        .E_alu_op2_sel(c_9),
        .E_opcode_out(c_52),
        .E_func3_out(c_32),
        .E_func7_out(c_10),
        .W_wb_en(c_11),
        .W_wb_data_sel(c_12),
        .W_rd_index(c_53),
        .W_f3_out(c_33),
        .stall(c_2),
        .jb(c_1)
    );

    Imme_Ext imme_ext(
        .inst(d_e_2),
        .imme_ext_out(d_e_3)        
    );

    RegFile regfile(
        .clk(clk),
        .rst(rst),
        .wb_en(c_11),
        .wb_data(d_e_4),
        .rd_index(c_53),
        .rs1_index(d_e_51),
        .rs2_index(d_e_52),
        .rs1_data_out(d_e_5),
        .rs2_data_out(d_e_6)
    );

    Mux mux_d_rs1_data(
        .i1(d_e_5),
        .i2(d_e_4),
        .sel(c_5),
        .o(d_e_7)
    );
    Mux mux_d_rs2_data(
        .i1(d_e_6),
        .i2(d_e_4),
        .sel(c_6),
        .o(d_e_8)
    );

    Reg_E reg_e(
        .clk(clk),
        .rst(rst),
        .stall(c_2),
        .jb(c_1),
        .pc_in(d_e_1),
        .rs1_data_in(d_e_7),
        .rs2_data_in(d_e_8),
        .imm_in(d_e_3),
        .pc_out(e_m_1),
        .rs1_data_out(e_m_2),
        .rs2_data_out(e_m_3),
        .imm_out(e_m_4)
    );

    Mux_3to1 mux_newest_rs1_data(
        .i1(d_e_4),
        .i2(e_m_5),
        .i3(e_m_2),
        .sel(c_21),
        .o(e_m_6)
    );

    Mux_3to1 mux_newest_rs2_data(
        .i1(d_e_4),
        .i2(e_m_5),
        .i3(e_m_3),
        .sel(c_22),
        .o(e_m_7)
    );

    Mux mux_alu_oper1(
        .i1(e_m_6),
        .i2({16'b0,e_m_1}),
        .sel(c_8),
        .o(e_m_8)
    );

    Mux mux_alu_oper2(
        .i1(e_m_7),
        .i2(e_m_4),
        .sel(c_9),
        .o(e_m_9)        
    );

    ALU alu(
       .opcode(c_52),
       .func3(c_32),
       .func7(c_10),
       .operand1(e_m_8),
       .operand2(e_m_9),
       .alu_out(e_m_10),                   
       .branch_taken(c_4)
    );


    Mux mux_jb_oper(
        .i1(e_m_6),
        .i2({16'b0,e_m_1}),
        .sel(c_7),
        .o(e_m_11)         
    );

    JB_Unit jb_unit(
        .operand1(e_m_11),
        .operand2(e_m_4),
        .jb_out(e_p_2)
    );

    Reg_M reg_m(
        .clk(clk),
        .rst(rst),
        .pc_in(e_m_1),
        .alu_out_in(e_m_10),
        .rs2_data_in(e_m_7),
        .pc_out(m_w_1),
        .alu_out_out(e_m_5),
        .rs2_data_out(dm_w_data)
    );
/*
    SRAM dm(
        .clk(clk),
        .w_en(c_42),
        .address(e_m_5[15:0]),
        .write_data(m_w_2),
        .read_data(m_w_3)
    );
*/
    Reg_W reg_w(
        .clk(clk),
        .rst(rst),
        .pc_in(m_w_1),
        .alu_out_in(e_m_5),
        .ld_data_in(dm_read_data),
        .alu_out_out(e_p_4),
        .ld_data_out(e_p_5)
    );

    LD_Filter ld_filter(
        .func3(c_33),
        .ld_data(e_p_5),
        .ld_data_f(e_p_6)
    );

    Mux mux_wb(
        .i1(e_p_4),
        .i2(e_p_6),
        .sel(c_12),
        .o(d_e_4)
    );

    
endmodule
