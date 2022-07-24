///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/05/20
// Project Name: code_ALU
// Description: It's TX-Leo's Experiment_Processor_01_03
// File Type: src(src/constrain/sim)
// Module Name: Top
// Function:
//  (1) 输入OpCode和Funct字段
//  (2) 输入数据in1 in2
//  (3) 输出数据out
//////////////////////////////////////////////

`timescale 1ns/1ps
module Top (input [5:0] OpCode,
            input [5:0] Funct,
            input [31:0] in1,
            input [31:0] in2,
            output [31:0] out,
            output zero
           );
    
    wire [4:0] ALUCtrl;
    wire Sign;

    ALUController alu_controller(.OpCode(OpCode), .Funct(Funct), .ALUCtrl(ALUCtrl), .Sign(Sign));
    ALU alu(.ALUCtrl(ALUCtrl), .Sign(Sign), .in1(in1), .in2(in2), .out(out), .zero(zero));

endmodule
