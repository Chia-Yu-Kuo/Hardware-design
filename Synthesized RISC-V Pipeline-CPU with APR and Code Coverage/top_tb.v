// Copyright (c) 2020 Sonal Pinto
// SPDX-License-Identifier: Apache-2.0

`timescale 1ns/10ps

`define CYCLE 60.0    // Cycle time
`define MAX 100000    // Max cycle number
`define prog_path "./test/progAll/main.hex"                          /////////////////should be updata
`define gold_path "./test/progAll/golden.hex"                        /////////////////should be updata

`define mem_word(addr) \
  {dm.mem[addr+3], \
  dm.mem[addr+2], \
  dm.mem[addr+1], \
  dm.mem[addr]}

`define ANSWER_START 'h9000

`ifdef syn
    `include "./postsim/Top_syn.v"
    `include "./postsim/tsmc18.v"
`else
    `include "./src/Top.v"
`endif 

`include "./src/SRAM.v"

module top_tb;

  reg clk;
  reg rst;
  wire [31:0] pc_d_3,m_w_3;	//top in
  wire [3:0] c_41,c_42;		//top out
  wire [15:0]pc_d_1,e_m_5;       //top out
  wire [31:0] pc_d_2,m_w_2;	 //top out
  
  

  reg [31:0] GOLDEN [0:121];                                                        /////////////////should be updata
  integer gf;                   // pointer of golden file
  integer num=122;               // total golden data                                /////////////////should be updata
  integer err;                  // total number of errors compared to golden data

  integer i;

  Top top (
    .clk(clk),
    .rst(rst),
    .im_read_data(pc_d_3),
    .dm_read_data(m_w_3),
    .im_w_en(c_41),
    .dm_w_en(c_42),
    .im_address(pc_d_1),
    .dm_address(e_m_5),
    .im_w_data(pc_d_2),
    .dm_w_data(m_w_2)
  );
  SRAM im(
        .clk(clk),
        .w_en(c_41),
        .address(pc_d_1),
        .write_data(pc_d_2),                                              
        .read_data(pc_d_3)
    );
  SRAM dm(
        .clk(clk),
        .w_en(c_42),
        .address(e_m_5),
        .write_data(m_w_2),
        .read_data(m_w_3)
    );

  `ifdef SYN
      initial $sdf_annotate("./postsim/Top_syn.sdf", Top);  
  `endif


  always #(`CYCLE/2) clk = ~clk;

  initial begin

    clk = 0; rst = 1;
    #(`CYCLE) rst = 0;


    // Load program and preset data to im & dm 
    $readmemh(`prog_path, im.mem);
    $readmemh(`prog_path, dm.mem);
    $readmemh(`gold_path, GOLDEN);     // GOLDEN num==????????????? set fix=45
    // Load Gloden Data
    /*
    num = 0;
    gf = $fopen(`gold_path, "r");
    while (!$feof(gf)) begin
      $fscanf(gf, "%h\n", GOLDEN[num]);
      num=num+1;
    end
    $fclose(gf);
    */


    // Initialize part of the memory (needed by the test program)
    `mem_word('h9078) = 32'd0;
    `mem_word('h907c) = 32'd0;
    `mem_word('h9080) = 32'd0;
    `mem_word('h9084) = 32'd0;
    `mem_word('hfffc) = 32'd0;


    // Initialize register[0] = 0 (hardwire to ground)
    //top.regfile.registers[0] = 32'd0;							//?????????????




    // Wait until end of execution
    wait(dm.mem[16'hfffc] == 8'hff);
    $display("\nDone\n");


    // Compare result with Golden Data
    err = 0;
    for (i = 0; i < num; i=i+1)
    begin
      if (`mem_word(`ANSWER_START + i*4) !== GOLDEN[i])
      begin
        $display("DM['h%4h] = %h, expect = %h", `ANSWER_START + i*4, `mem_word(`ANSWER_START + i*4), GOLDEN[i]);
        err = err + 1;
      end
      else
      begin
        $display("DM['h%4h] = %h, pass", `ANSWER_START + i*4, `mem_word(`ANSWER_START + i*4));
      end
    end


    // Print result
    result(err, num);
    $finish;

  end

  task result;
    input integer err;
    input integer num;
    begin
      if (err === 0)
      begin
        $display("\n");
        $display("\n");
        $display("                                      `;-.          ___,");
        $display("        ****************************    `.`\\_...._/`.-\"`");
        $display("        **                        **      \\        /      ,");
        $display("        **                        **      /()   () \\   .' `-._");
        $display("        **   Congratulations !!   **     |)  .    ()\\ /   _.'");
        $display("        **                        **     \\  -'-     ,; '. <");
        $display("        **                        **      ;.__     ,;|   > \\");
        $display("        **   Simulation PASS!!    **     / ,    / ,  |.-'.-'");
        $display("        **                        **    (_/    (_/ ,;|.<`");
        $display("        **                        **      \\    ,     ;-`");
        $display("        ****************************       >   \\    /");
        $display("                                          (_,-'`> .'");
        $display("                                               (_,'");
        $display("\n");
      end
      else
      begin
        $display("\n");
        $display("\n");
        $display("        ****************************     /*\\_...._/*^\\");
        $display("        **                        **    (/^\\       / \\)  ,");
        $display("        **                        **      / X   X  \\   .' `-._");
        $display("        **   OOPS!                **     |)  .    ()\\ /   _.'");
        $display("        **                        **     \\   ^     ,; '. <");
        $display("        **                        **      ;.__     ,;|   > \\");
        $display("        **   Simulation Failed!!  **     / ,    / ,  |.-'.-'");
        $display("        **                        **    (_/    (_/ ,;|.<`");
        $display("        **                        **      \\    ,     ;-`");
        $display("        ****************************       >   \\    /");
        $display("                                          (_,-'`> .'");
        $display("                                               (_,'");
        $display("         Totally has %d errors"                     , err);
        $display("\n");
      end
    end
  endtask

    initial
    begin
	    $dumpfile("wave.fsdb");  //your waveform file for nWave
	    $dumpvars;
    end

  initial begin
    #(`CYCLE*`MAX)
    $finish;
  end

endmodule
