///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: DataHazard
// Function:
/////////////

`timescale 1ns / 1ps

module Data_Hazard
(
    input wire i_ID_EX_RegWrite,
    input wire [4:0] i_ID_EX_WriteAddr,
    input wire i_EX_MEM_RegWrite,
    input wire [4:0] i_EX_MEM_WriteAddr,
    input wire [4:0] i_rs,
    input wire [4:0] i_rt,
    input wire i_ID_EX_MemRead,
    output wire [1:0] o_ForwardA,     // 00: no hazard, 01: 1-step, 10: 2_step
    output wire [1:0] o_ForwardB,
    output wire o_LW_Stall
);

    assign o_ForwardA = (i_ID_EX_RegWrite && i_ID_EX_WriteAddr != 0 && i_ID_EX_WriteAddr == i_rs) ? 2'b01 : (i_EX_MEM_RegWrite && i_EX_MEM_WriteAddr != 0 && i_EX_MEM_WriteAddr == i_rs) ? 2'b10 : 2'b00;
    assign o_ForwardB = (i_ID_EX_RegWrite && i_ID_EX_WriteAddr != 0 && i_ID_EX_WriteAddr == i_rt) ? 2'b01 : (i_EX_MEM_RegWrite && i_EX_MEM_WriteAddr != 0 && i_EX_MEM_WriteAddr == i_rt) ? 2'b10 : 2'b00;
    assign o_LW_Stall = i_ID_EX_MemRead && (i_ID_EX_WriteAddr != 0) && (i_ID_EX_WriteAddr == i_rs || i_ID_EX_WriteAddr == i_rt);

endmodule
