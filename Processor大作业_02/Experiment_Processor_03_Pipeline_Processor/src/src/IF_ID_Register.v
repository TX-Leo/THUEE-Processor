///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: IF_ID_Register
// Function:
//  (1) =
//////////////////////////////////////////////

`timescale 1ns / 1ps

module IF_ID_Register
(
    input wire clk,
    input wire reset,
    input wire i_flush,
    input wire i_hold,
    input wire [31:0] i_ReadInst,
    input wire [31:0] i_IF_PC_Plus_4,
    output reg [5:0] o_OpCode,
    output reg [4:0] o_rs,
    output reg [4:0] o_rt,
    output reg [4:0] o_rd,
    output reg [4:0] o_Shamt,
    output reg [5:0] o_Funct,
    output reg [31:0] o_PC_Plus_4
);

    initial begin
        o_OpCode <= 0;
        o_rs <= 0;
        o_rt <= 0;
        o_rd <= 0;
        o_Shamt <= 0;
        o_Funct <= 0;
        o_PC_Plus_4 <= 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset || (i_flush && !i_hold)) begin
            o_OpCode <= 0;
            o_rs <= 0;
            o_rt <= 0;
            o_rd <= 0;
            o_Shamt <= 0;
            o_Funct <= 0;
            o_PC_Plus_4 <= 0;
        end
        else begin
            if (!i_hold) begin
                o_OpCode <= i_ReadInst[31:26];
                o_rs <= i_ReadInst[25:21];
                o_rt <= i_ReadInst[20:16];
                o_rd <= i_ReadInst[15:11];
                o_Shamt <= i_ReadInst[10:6];
                o_Funct <= i_ReadInst[5:0];
                o_PC_Plus_4 <= i_IF_PC_Plus_4;
            end
        end
    end

endmodule
