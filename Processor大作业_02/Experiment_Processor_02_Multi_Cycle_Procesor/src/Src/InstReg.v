///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: InstReg
// Function:
//  (1) decode instruction
//////////////////////////////////////////////

`timescale 1ns / 1ps
module InstReg(reset, clk, IRWrite, Instruction, OpCode, rs, rt, rd, Shamt, Funct);
    //Input Clock Signals
    input reset;
    input clk;
    //Input Control Signals
    input IRWrite;
    //Input Instruction
    input [31:0] Instruction;
    //Output Data
    output reg [5:0]  OpCode;
    output reg [4:0]  rs;
    output reg [4:0]  rt;
    output reg [4:0]  rd;
    output reg [4:0]  Shamt;
    output reg [5:0]  Funct;
    
    reg [31:0] instruction;
    
    always @(posedge reset or posedge clk) begin
        if (reset) begin
            OpCode <= 6'b000000;
            rs <= 5'b00000;
            rt <= 5'b00000;
            rd <= 5'b00000;
            Shamt <= 5'b00000;
            Funct <= 6'b000000;
            instruction <= 32'b0;
        end
        else if (IRWrite) begin
            OpCode <= Instruction[31:26];
            rs <= Instruction[25:21];
            rt <= Instruction[20:16];
            rd <= Instruction[15:11];
            Shamt <= Instruction[10:6];
            Funct <= Instruction[5:0];
            instruction <= Instruction;
        end
        else begin
            OpCode <= OpCode;
            rs <= rs;
            rt <= rt;
            rd <= rd;
            Shamt <= Shamt;
            Funct <= Funct;
            instruction <= instruction;
        end
    end

endmodule