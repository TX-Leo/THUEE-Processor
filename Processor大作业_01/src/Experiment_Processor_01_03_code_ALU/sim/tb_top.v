///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_ALU
// Description: It's TX-Leo's Experiment_Processor_01_03
// File Type: sim(src/constrain/sim)
// Module Name: TbTop
// Function:
//  (1) lw
//  (2) sw
//  (3) lui
//  (4) add
//  (5) addi
//  (6) addu
//  (7) addiu
//  (8) sub
//  (9) subu
//  (10) and
//  (11) andi
//  (12) or
//  (13) xor
//  (14) nor
//  (15) sll
//  (16) srl
//  (17) sra
//  (18) slt
//  (19) slti
//  (20) sltu
//  (21) sltui
//  (22) beq

//////////////////////////////////////////////

`timescale 1ns/1ps
module TbTop ();
    reg [5:0] OpCode;
    reg [5:0] Funct;
    reg [31:0] in1;
    reg [31:0] in2;
    wire [31:0] out;
    wire zero;

    Top top(.OpCode(OpCode), .Funct(Funct), .in1(in1), .in2(in2), .out(out), .zero(zero));

    initial begin
        // lw
       OpCode = 35;
       Funct = 37;
       in1 = 12;
       in2 = 200;
        // sw
       OpCode = 43;
       Funct = 0;
       in1 = 20;
       in2 = 303;
        // lui
       OpCode = 15;
       Funct = 0;
       in1 = 6664;
       in2 = 0;
        // add
       OpCode = 0;
       Funct = 32;
       in1 = -29;
       in2 = 11;
        // addi
       OpCode = 8;
       Funct = 0;
       in1 = -29;
       in2 = 11;
        // addu
       OpCode = 0;
       Funct = 33;
       in1 = 23;
       in2 = 34;
        // addiu
       OpCode = 9;
       Funct = 0;
       in1 = 23;
       in2 = 34;      
        // sub
       OpCode = 0;
       Funct = 34;
       in1 = 10;
       in2 = 10;
        // subu
       OpCode = 0;
       Funct = 35;
       in1 = 1000;
       in2 = 20;
        // and
       OpCode = 0;
       Funct = 36;
       in1 = 44;
       in2 = 23;
        // andi
       OpCode = 12;
       Funct = 0;
       in1 = 44;
       in2 = 23;
        // or
       OpCode = 0;
       Funct = 37;
       in1 = 44;
       in2 = 23;
        // xor
       OpCode = 0;
       Funct = 38;
       in1 = 44;
       in2 = 23;
        // nor
       OpCode = 0;
       Funct = 39;
       in1 = 44;
       in2 = 23;
        // sll
       OpCode = 0;
       Funct = 0;
       in1 = 22;
       in2 = 128128;
        // srl
       OpCode = 0;
       Funct = 2;
       in1 = 2222;
       in2 = 128;
        // sra
       OpCode = 0;
       Funct = 3;
       in1 = -2222;
       in2 = 128;
        // slt
       OpCode = 0;
       Funct = 42;
       in1 = 2;
       in2 = 3;
        // slti
       OpCode = 10;
       Funct = 0;
       in1 = 2;
       in2 = 3;
        // sltiu
       OpCode = 11;
       Funct = 0;
       in1 = 3;
       in2 = 2;
        // beq
        OpCode = 4;
        Funct = 0;
        in1 = 11;
        in2 = 11;
        #(20)
        $finish;
    end
endmodule //tb_top