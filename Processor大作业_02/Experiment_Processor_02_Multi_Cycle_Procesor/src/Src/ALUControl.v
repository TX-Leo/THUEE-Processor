///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: ALUControl
// Function:
//  (1) to generate ALU control signal
//////////////////////////////////////////////

`timescale 1ns / 1ps
module ALUControl(ALUOp, Funct, ALUConf, Sign);
	//Control Signals
	input [3:0] ALUOp;
	//Inst. Signals
	input [5:0] Funct;
	//Output Control Signals
	output reg [4:0] ALUConf;
	output Sign;

    assign Sign = (ALUOp[3] == 0)?1:(ALUOp[2:0] == 2 && (Funct == 33 || Funct == 35 || Funct == 43))?0:1;
    
    always @(*) begin
        if (ALUOp == 2) begin
            case (Funct)
                32, 33: ALUConf <= 2;   // add & addu
                34, 35: ALUConf <= 6;   // sub & subu
                36: ALUConf <= 0;       // and
                37: ALUConf <= 1;       // or
                38: ALUConf <= 9;       // xor
                39: ALUConf <= 8;       // nor
                42: ALUConf <= 7;       // slt
                0: ALUConf <= 10;       // sll
                2: ALUConf <= 16;       // srl
                3: ALUConf <= 17;       // sra
            endcase
        end
        else if (ALUOp == 0) ALUConf <= 2;
        else if (ALUOp == 1) ALUConf <= 6;
        else if (ALUOp == 3) ALUConf <= 0;
        else if (ALUOp == 4) ALUConf <= 7;
        else ALUConf <= 2;
    end

endmodule
