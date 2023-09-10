`timescale 1ns/10ps

`include "Memory.v"
`ifdef syn
    `include "CPU_syn.v"
    `include "tsmc18.v"
`else
    `include "CPU.v"
`endif 

`define period 70

module testbench();
    reg clk;
    reg rst;

    reg [31:0] golden [0:11];

    wire [31:0] w11,w12;
    wire [11:0] w21,w22;
    wire w31,w32;
    wire [31:0] w41,w42;

    integer i,j,error;

    CPU cpu(
        .rst (rst),
        .clk (clk),
        .ir(w11),
        .dm_r_data(w12),
        .pc(w21),
        .dm_data_addr(w22),
        .im_w_en(w31),
        .dm_w_en(w32),
        .im_w_data(w41),
        .dm_w_data(w42)  
    );

    RAM im(                                         // MEMORY  //0~2047 IR
        .clk(clk),
        .w_en(w31),
        .address(w21),
        .write_data(w41),
        .read_data(w11)
    );

    RAM dm(                                     //2048~4095 data(2048~3072 input ,3072~4095 output)      
        .clk(clk),
        .w_en(w32),
        .address(w22),
        .write_data(w42),
        .read_data(w12)
    );

    `ifdef SYN
        initial $sdf_annotate("CPU_syn.sdf", CPU);  
    `endif

    

    always #(`period/2) clk=~clk;


    // Initial and always blocks
    initial 
    begin : prog_load
        $readmemb("ir.prog",im.mem);
        $readmemb("data.prog",dm.mem);
        $readmemb("golden.bin",golden);     //12 answer
        $monitor("%d %d",$time,cpu.pc);  
        //apply_reset ;
                    clk=0 ;rst=1;
        #(`period*2)  rst=0;

        wait(dm.mem[4095]== 32'hffffffff);        //auto sign extension ??
        $display("\nDone\n");

        error = 0;
        for (i = 0; i < 7; i=i+1)      //3800~3806
        begin
            if ( dm.mem[3800+i]!== golden[i])
            begin
                $display("DM[%d] = %h, expect = %h", 3800+i, dm.mem[3800+i], golden[i]);
                error = error + 1;
            end
            else
            begin
                $display("DM[%d] = %h, pass", 3800+i ,dm.mem[3800+i]);
            end
        end

        for (j = 0; j < 5; j=j+1)      //3800~3806
        begin
            if ( dm.mem[4000+j] !== golden[j+7])
            begin
                $display("DM[%d] = %h, expect = %h", 4000+j, dm.mem[4000+j], golden[j+7]);
                error = error + 1;
            end
            else
            begin
                $display("DM[%d] = %h, pass", 4000+j, dm.mem[4000+j]);
            end
        end


        result(error);
        $finish;
    end

    task result;
    input integer error;
    begin
      if (error === 0)
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
        $display("         Totally has %d errors"                     , error);
        $display("\n");
      end
    end
    endtask

    
    initial
    begin
	    $dumpfile("wave.fsdb");  //your waveform file for nWave
	    $dumpvars;
    end
  

endmodule
