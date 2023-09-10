/*
NOP      每個task 中間插
BRANCH   比較相等後跳另一比較
LOAD  
STORE
ADD      *加負數
MULTIPLY   **
COMPLEMENT *轉負數
SHIFT       **
ROTATE     <<(<0)***   ***>>>(>0)  +-32
HALT        ENDING
SUB         1.減法  2. 比較相等==0 *3
J           跳兩個task
JSUB        FIB
RETURN

*/

//input
//1.先用src mem dest mem
//+-
STR MEM[2048]  #10
STR MEM[2049]  #5   
//50 -5
//51 result +
//52 result -
//53 result comp=0


//* <<
STR MEM[2060] #15
STR MEM[2061] #8
STR MEM[2062] #3
STR MEM[2063] #-3
//64 7*8
//65  7<<2  
//66  BRA==0
//67 7<<3  
//68  BRA==1


//rotate
STR MEM[2080] #666
//81
STR MEM[2082] #32
STR MEM[2083] #-32
//84 <<<32
//85 >>>32
//86 comp bra=1


//2.用src immi(+reg)  dest reg
//FIB test input
STR MEM[3000] #5
STR MEM[3001] #6
STR MEM[3002] #7
STR MEM[3003] #8
STR MEM[3004] #9




//main
NOP
NOP
LD   1      2048      //10
LD   2      2049      //5
CMP  3      2      //-5
ADD  3      1      //10+(-5)                               golden
STR  3800   3
SUB  1      2     //10-5                                  golden
STR  3801   2
//LD   2051 3      //reg type     00100000_10000000_00101000_00000011
SUB  3      2      //                                      golden
BRA  200  ZERO


//IR mem =200
LD  0       2060       //15
LD  1       2061       //8
MUL 1       0       //golden 15*8
STR 3802    1
LD  2       2062       //3
LD  3       2063       //-3
LD  4       2060       //reg
LD  5       2060       //reg
SHF 4       2       //>>3       golden
STR 3803    4
SUB 4       1       //comp
BRA 400     ZERO
SHF 5       3       //<<3       golden
STR 3804    5
SUB 5       1       //comp
BRA 400     ZERO


//IR mem=400
LD  0       2080       //666
LD  1       2080       //666
LD  2       2082       //32
LD  3       2083       //-32
ROT 0       2       //golden
STR 3805    0
ROT 1       3       //golden
STR 3806    1
SUB 0       1       //golden
BRA 600     ZERO



//IR mem=600    5
LD  5       3000
JSUB        1100
STR 4000    10
J           700

//IR mem=700    6
LD  5       3001
JSUB        1100
STR 4001    10
J           800

//IR mem=800    7
LD  5       3002
JSUB        1100
STR 4002    10
J           900

//IR mem=900    8
LD  5       3003
JSUB        1100
STR 4003    10
J           1000

//IR mem=1000   9
LD  5       3004
JSUB        1100
STR 4004    10
STR 4095  MAX; //32'hffffffff
HALT



//IR mem=1100   power of 2
//INITIAL
NOP
LD  10   #0              //ans
LD  3    #1
LD  4    #2             //power of 2
//ADD 5    #1   01001000_00000000_00010000_00000101
//power of 2  mem=1104
SUB 5    #1   //-1
BRA 1200 ZERO       //return 1
JSUB 1104   //keep pc+1
MUL 10   4   //  *2            IR=1107
RET                        // 09

//return 1   mem=1200
LD 10   #1
J  1107




