///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: single-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_01
// File Type: src(src/constrain/sim)
// Module Name: Control
// Function:
//  (1) decode instruction which is from instrution memory to generate control signal such as PCSrc,Branch
//////////////////////////////////////////////

module Control(OpCode, Funct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp);
	input [5:0] OpCode;
	input [5:0] Funct;
	output [1:0] PCSrc;
	output Branch;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;
	
    //PCSrc
	assign PCSrc = (OpCode == 2 || OpCode == 3)?1:(OpCode == 0 && (Funct == 8 || Funct == 9))?2:0;
    //Brach
    assign Branch = (OpCode == 4);
    //RegWrite
    assign RegWrite = (OpCode == 43 || OpCode == 4 || OpCode == 2)?0:(OpCode == 0 && Funct == 8)?0:1;
	//RegDst
    assign RegDst = (OpCode == 3)?2:(OpCode == 35 || OpCode == 15 || OpCode == 8 || OpCode == 9 || OpCode == 12 || OpCode == 10 || OpCode == 11)?0:1;
    //MemRead
    assign MemRead = (OpCode == 35);
    //MemWrite
    assign MemWrite = (OpCode == 43);
    //MemtoReg
    assign MemtoReg = (OpCode == 3 || (OpCode == 0 && Funct == 9))?2:(OpCode == 35)?1:0;
	//ALUSrc1
    assign ALUSrc1 = (OpCode == 0 && (Funct == 0 || Funct == 2 || Funct == 3));
    //ALUSrc2
    assign ALUSrc2 = (OpCode == 43 || OpCode == 35 || OpCode == 15 || OpCode == 8 || OpCode == 9 || OpCode == 12 || OpCode == 10 || OpCode == 11);
    //ExtOp
    assign ExtOp = (OpCode == 12)?0:1;
    //LuOp
    assign LuOp = (OpCode == 15);

	
endmodule