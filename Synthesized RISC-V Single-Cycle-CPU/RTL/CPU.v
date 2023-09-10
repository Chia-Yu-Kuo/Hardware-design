/* ==========================
* Model of RISC without pipeline.
* risc.v
*
* Useful for instruction set simulation.
* Three main tasks - fetch, execute, write.
*/
module CPU (clk,rst,ir,dm_r_data,pc,dm_data_addr,im_w_en,dm_w_en,im_w_data,dm_w_data); 
    /* 
    * Declarations, functions , and tasks
    */
    input clk,rst;
    input [31:0] ir,dm_r_data;
    output im_w_en;
    output reg dm_w_en;
    output reg [11:0] pc,dm_data_addr;
    output [31:0] im_w_data;
    output reg [31:0] dm_w_data;

    // Declare parameters
    parameter CYCLE=10 ; // Cycle Time
    parameter WIDTH=32 ; // Width of data paths
    parameter ADDRSIZE = 12 ; // Size of address field
    parameter MEMSIZE = (1<<ADDRSIZE); // Size of memory
    parameter MAXREGS = 16 ; // Maximum # of registers
    parameter SBITS = 5 ; // Status register bits

    // Declare Registers and Memory
    wire [ADDRSIZE-1:0] next_pc;
    //reg [WIDTH-1:0] MEM[0:MEMSIZE-1];   
    reg [WIDTH-1:0] RFILE[0:15]; // Register File
    //reg [WIDTH-1:0] ir; // Instruction Register
    reg [WIDTH-1:0] src1, src2 ,src3 ; // Alu operation registers
    reg [WIDTH:0] result ; // ALU result register                                          /////////
    reg [WIDTH:0] rotate_result[0:32] ; // ALU result register                                          /////////
    reg [SBITS-1:0] psr; // Processor Status Register
    reg [SBITS-1:0] next_psr; // Processor Status Register
    reg [ADDRSIZE-1:0] j_addr; // Program counter
    reg [3:0] r_data_addr;
    reg next_pc_sel;        //1:j  0:+1
    reg r_w_en;
    reg [ADDRSIZE-1:0] return_addr [0:63] ; 
    reg [5:0] top_ptr ,next_top_ptr;
    reg dir; // rotate direction
    //reg reset; // System Reset
    //integer i; // useful for interactive debugging
    integer j,k,l,m;
    reg signed [ADDRSIZE-1:0] i;



    // General definitions
    `define TRUE 1
    `define FALSE 0 
    `define DEBUG_ON debug = 1
    `define DEBUG_OFF debug = 0
    // Define Instruction fields
    `define OPCODE ir[31:28]
    `define SRC ir[23:12]
    `define DST ir[11:0]
    `define REGADDR_S ir[15:12]
    `define REGADDR_D ir[3:0]
    `define SRCTYPE ir[27] // source type, 0=reg (mem for LD), 1=imm
    `define DSTTYPE ir[26] // destination type, 0=reg, 1=imm
    `define CCODE ir[27:24]
    `define SRCNT ir[23:12] // Shift/rotate count -= left, +=right
    // Operand Types
    `define REGTYPE 0
    `define IMMTYPE 1
    // Define opcodes for each instruction
    `define NOP 4'b0000
    `define BRA 4'b0001
    `define LD 4'b0010
    `define STR 4'b0011
    `define ADD 4'b0100
    `define MUL 4'b0101
    `define CMP 4'b0110
    `define SHF 4'b0111
    `define ROT 4'b1000
    `define HLT 4'b1001
    ///////////////////////////new inst//////////////////////////////
    `define SUB 4'b1010
    `define J   4'b1011  //unciditional jump
    `define JSUB 4'b1100 //unciditional jump with  (with return address PC+4)
    `define RET  4'b1101
    ///////////////////////////new inst//////////////////////////////


    // Define Condition Code fields
    `define CARRY psr[0]
    `define EVEN psr[1]
    `define PARITY psr[2]
    `define ZERO psr[3]
    `define NEG psr[4]
    // Define next Condition Code fields
    `define NEXT_CARRY next_psr[0]
    `define NEXT_EVEN next_psr[1]
    `define NEXT_PARITY next_psr[2]
    `define NEXT_ZERO next_psr[3]
    `define NEXT_NEG next_psr[4]
    // Define Condition Codes
    `define CCC 1 // Result has carry
    `define CCE 2 // Result is even
    `define CCP 3 // Result is odd parity
    `define CCZ 4 // Result is Zero
    `define CCN 5 // Result is Negative
    `define CCA 0 // Always
    `define RIGHT 0 // Rotate/Shift Right
    `define LEFT 1 // Rotate/Shift Left


    assign im_w_data=32'b0; //trash
    assign im_w_en=1'b0; 
    assign next_pc= (next_pc_sel) ? j_addr : pc+12'd1;

    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            pc<=12'b0;
            next_psr<=5'b0;   
            top_ptr<= 10'b0;
            for (m =0 ; m<64; m=m+1 ) 
            begin
                return_addr[m]<=12'b0;
            end
        end
        else 
        begin
            pc<=next_pc;
            next_psr<=psr;
            //if((`OPCODE >= `JSUB) && (`OPCODE <= `RET))
            if(top_ptr!=next_top_ptr)
            begin
                top_ptr<=next_top_ptr; 
                if (`OPCODE==`JSUB) 
                begin
                    return_addr[top_ptr]<=pc+12'd1;
                end
                else if(`OPCODE==`RET)
                begin
                    return_addr[top_ptr]<=12'b0;                   
                end
                else
                begin
                    return_addr[top_ptr]<=return_addr[top_ptr];
                end
            end
            else
            begin
                top_ptr<=top_ptr;
                return_addr[top_ptr]<=return_addr[top_ptr];
            end
        end   
    end

 

    //regfile
    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            for (l =0 ;l<16 ;l=l+1) 
            begin
                RFILE[l]<=32'b0;
            end
        end
        else
        begin
            if (r_w_en) 
            begin
                RFILE[r_data_addr] <= result[31:0];               //next_result??
            end
            else
            begin               //keep need write?
                RFILE[r_data_addr] <= RFILE[r_data_addr] ;     
            end
        end
    end


    // Function for ALU operands and result
    function [WIDTH-1:0] getsrc; 
        input [WIDTH-1:0] in;
        begin
            if (`SRCTYPE == `REGTYPE)
            begin
                getsrc = RFILE[`REGADDR_S] ;
            end 
            else 
            begin
                getsrc = `SRC ; // immediate type end
            end 
        end
    endfunction

    function [WIDTH-1:0] getdst; 
    input [WIDTH-1:0] in;
        begin
            if (`DSTTYPE == `REGTYPE) 
            begin 
                getdst = RFILE[`REGADDR_D];
            end
            else 
            begin // immediate type
                //synopsys translate_off
                $display("Error:Immediate data can't be destination."); 
                //synopsys translate_on
            end
        end
    endfunction
    // Functions / tasks for Condition Codes
    function checkcond; //Returns 1 if condition code is set .
        input [3:0] ccode;
        begin
            case (ccode)
            `CCC : checkcond = `NEXT_CARRY ;
            `CCE : checkcond = `NEXT_EVEN ;
            `CCP : checkcond = `NEXT_PARITY ;
            `CCZ : checkcond = `NEXT_ZERO ;
            `CCN : checkcond = `NEXT_NEG ;
            `CCA : checkcond = 1; 
            //default: checkcond;   //////////   可以不assign value??
            endcase
        end
    endfunction

    task clearcondcode ; // Reset condition codes in PSR
        begin
            psr = 0;
        end
    endtask

    task setcondcode ; // Compute the condition codes and set PSR
        input [WIDTH:0] res; //33 bit result register
        begin
            `CARRY = res[WIDTH];
            `EVEN = ~res[0];
            `PARITY = ^res ;
            `ZERO = ~(|res) ;
            `NEG = res[WIDTH-1];
        end
    endtask

    always @(*)             //rotate_result ,result may cause latch
    begin
        case(`OPCODE)
            `NOP : 
            begin 
                clearcondcode ;     
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            `BRA : 
            begin
                if (checkcond( `CCODE) == 1) 
                begin 
                    j_addr = `DST;
                    next_pc_sel=1'b1;
                end
                else
                begin
                    j_addr = 12'b0;
                    next_pc_sel=1'b0;
                end
                clearcondcode ;     
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            `LD : 
            begin 
                clearcondcode ;     
                if (`SRCTYPE)       //immi
                begin
                    /*
                    RFILE[`DST] = {{20{ir[23]}},`SRC} ;     // ????????? or `SRC only
                    dm_data_addr=12'b0;
                    */
                    dm_data_addr=12'b0;
                    result={{21{ir[23]}},`SRC} ;
                end
                else 
                begin
                    /*
                    dm_data_addr=`SRC;
                    RFILE[`DST]=dm_r_data;
                    */
                    dm_data_addr=`SRC;
                    result={1'b0,dm_r_data};
                end
                setcondcode({1'b0,RFILE[`REGADDR_D]}) ;
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;

            end
            `STR : 
            begin
                clearcondcode ;  
                dm_data_addr= `DST ;          
                if (`SRCTYPE) 
                begin
                    //MEM[`DST] = {{21{ir[23]}},`SRC};      //sign extend
                    dm_w_data = {{20{ir[23]}},`SRC};
                    setcondcode( {{21{ir[23]}},`SRC} );
                end
                else 
                begin
                    //MEM[`DST] = RFILE[`SRC] ;
                    dm_w_data = RFILE[`REGADDR_S];
                    setcondcode ({1'b0,RFILE[`REGADDR_S]});
                end
                dm_w_en=1'b1;
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            `ADD : 
            begin
                clearcondcode ;
                src1   = getsrc(ir);
                src2   = getdst(ir);
                result = src1 + src2;
                setcondcode(result);
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src3   =12'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            `MUL : 
            begin 
                clearcondcode ;
                src1 = getsrc(ir) ;
                src2 = getdst(ir) ;
                result = src1 * src2 ;
                setcondcode(result) ;
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src3   =12'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            `CMP : 
            begin 
                clearcondcode ;
                src1 = getsrc(ir) ;
                result = (~src1)+1 ;
                setcondcode (result) ;
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src3   =12'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            `SHF : 
            begin 
                clearcondcode ;
                src1 = getsrc(ir) ;
                src2 = getdst(ir) ;
                i = src1[ADDRSIZE-1:0] ;
                result = (i>=0) ? (src2 >> i) : (src2 << -i) ;
                setcondcode(result); 
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src3   =12'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            `ROT : 
            begin 
                clearcondcode ;
                src1 = getsrc(ir) ;
                src2 = getdst(ir) ;
                dir = (src1[ADDRSIZE-1] >=0 )? `RIGHT : `LEFT ;
                //i = ( src1[ADDRSIZE-1] >=0)? src1 : -(src1[ADDRSIZE-1:0]) ;
                i = ( src1[ADDRSIZE-1] ) ? -(src1[11:0]) : src1[11:0] ;
                for ( j=0 ;j<=32 ;j=j+1 )   //parallel
                begin
                    src3 =src2;
                   for ( k=0 ;k<j ;k=k+1 )  //implenment each rotate
                    begin
                        if (dir == `RIGHT) 
                        begin 
                            rotate_result[j] = src3 >> 1 ;
                            rotate_result[j][WIDTH-1] = src3 [0] ;
                        end
                        else 
                        begin
                            rotate_result[j] = src3 << 1 ;
                            rotate_result[j][0] =src3[WIDTH-1] ;
                        end
                        src3 = rotate_result[j][31:0];
                    end 
                end      
                result = rotate_result[i[5:0]] ;
                setcondcode(result);
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                next_top_ptr=top_ptr;

            end
            `HLT : 
            begin     
                clearcondcode ;     
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
                //synopsys translate_off
                $display("Halt ... "); 
                $stop ;             //syn vable?
                //synopsys translate_on
            end
            `SUB :
            begin
                clearcondcode ;
                src1 = getsrc(ir);
                src2 = getdst(ir);
                result = src2 -src1 ;
                setcondcode(result);
                next_pc_sel=1'b0;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src3   =12'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            //1011  0 0(reg)/1(immi) 00  src=0    dest
            `J :
            begin
                clearcondcode ;     
                j_addr = `DST;
                next_pc_sel=1'b1;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
            end
            //1100  0(reg)/1(immi)  src=0   dest
            `JSUB:  //have return addr
            begin
                clearcondcode ;     
                next_top_ptr=top_ptr+6'd1;
                //return_addr[next_top_ptr]=pc+12'd1;            //
                j_addr = `DST;    
                next_pc_sel=1'b1;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
            end
            //1101  0000    src=0   dest=fixed=0
            `RET:
            begin
                clearcondcode ;     
                next_top_ptr=top_ptr-6'd1;
                j_addr= return_addr[next_top_ptr];
                //return_addr[top_ptr]=12'b0;
                next_pc_sel=1'b1;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
            end

            default :
            begin
                clearcondcode ;     
                next_pc_sel=1'b1;
                j_addr = 12'b0;
                dm_w_en=1'b0;
                dm_data_addr=12'b0;
                dm_w_data =32'b0;
                src1   =12'b0;
                src2   =12'b0;
                src3   =12'b0;
                result =33'b0;
                dir =1'b0;
                i =12'b0;
                next_top_ptr=top_ptr;
                //synopsys translate_off
                $display ("Error : Illegal Opcode. %b" ,`OPCODE);
                //synopsys translate_on
            end 
        endcase
    end
    //endtask

    // Write the result in register file
    //task write_result ;
    always @(*)         //R type write
    begin
        if (((`OPCODE >= `ADD) && (`OPCODE < `HLT) ) || (`OPCODE==`SUB) || (`OPCODE==`LD)) 
        begin
            r_w_en=1'b1;
            r_data_addr=`REGADDR_D;
        end
        else
        begin
            r_w_en=1'b0;
            r_data_addr=4'b0;
        end
    end
    //endtask 


endmodule

