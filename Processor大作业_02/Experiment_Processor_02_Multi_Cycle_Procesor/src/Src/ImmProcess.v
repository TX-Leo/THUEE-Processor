///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: ImmProcess
// Function:
//  (1) process immediate numbers for signed extension or zero extension 
//////////////////////////////////////////////

`timescale 1ns / 1ps
module ImmProcess(ExtOp, LuiOp, Immediate, ImmExtOut, ImmExtShift); 
    //Input Control Signals
    input ExtOp; //'0'-zero extension, '1'-signed extension
    input LuiOp; //for lui instruction
    //Input
    input [15:0] Immediate;
    //Output
    output [31:0] ImmExtOut;
    output [31:0] ImmExtShift;

    wire [31:0] ImmExt;
    
    assign ImmExt = {ExtOp? {16{Immediate[15]}}: 16'h0000, Immediate};
    assign ImmExtShift = ImmExt << 2;
    assign ImmExtOut = LuiOp? {Immediate, 16'h0000}: ImmExt;

endmodule
