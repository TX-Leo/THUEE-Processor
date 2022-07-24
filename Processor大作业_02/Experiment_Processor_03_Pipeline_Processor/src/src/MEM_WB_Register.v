///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: MEM_WB_Register
// Function:
//  (1)
//////////////////////////////////////////////

`timescale 1ns / 1ps

module MEM_WB_Register
(
    input wire clk,
    input wire reset,
    input wire i_RegWr,
    input wire [1:0] i_MemtoReg,
    input wire [4:0] i_WriteAddr,
    input wire [31:0] i_ReadData,
    input wire [31:0] i_ALU_result,
    input wire [31:0] i_PC_next
);

    reg RegWr;
    reg [1:0] MemtoReg;
    reg [4:0] WriteAddr;
    reg [31:0] ReadData;
    reg [31:0] ALU_result;
    reg [31:0] PC_next;

    initial begin
        RegWr       <= 0;
        MemtoReg    <= 0;
        WriteAddr   <= 0;
        ReadData    <= 0;
        ALU_result  <= 0;
        PC_next     <= 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            RegWr       <= 0;
            MemtoReg    <= 0;
            WriteAddr   <= 0;
            ReadData    <= 0;
            ALU_result  <= 0;
            PC_next     <= 0;
        end
        else begin
            RegWr           <= i_RegWr;
            MemtoReg        <= i_MemtoReg;
            WriteAddr       <= i_WriteAddr;
            ReadData        <= i_ReadData;
            ALU_result      <= i_ALU_result;
            PC_next         <= i_PC_next;
        end
    end

endmodule
