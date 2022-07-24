///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: ID_EX_Register
// Function:
/////////////

`timescale 1ns / 1ps

module ID_EX_Register
(
    input wire clk,
    input wire reset,
    input wire i_flush,
    input wire i_RegWr,
    input wire i_Branch,
    input wire i_BranchClip,
    input wire i_MemRead,
    input wire i_MemWrite,
    input wire [1:0] i_MemtoReg,
    input wire i_ALUSrcA,
    input wire i_ALUSrcB,
    input wire [3:0] i_ALUOp,
    input wire [1:0] i_RegDst,
    input wire [31:0] i_ReadData1,
    input wire [31:0] i_ReadData2,
    input wire [31:0] i_imm_ext,
    input wire [31:0] i_PC_Plus_4,
    input wire [4:0] i_Shamt,
    input wire [4:0] i_rt,
    input wire [4:0] i_rd
);

    reg RegWr;
    reg Branch;
    reg BranchClip;
    reg MemRead;
    reg MemWrite;
    reg [1:0] MemtoReg;
    reg ALUSrcA;
    reg ALUSrcB;
    reg [3:0] ALUOp;
    reg [1:0] RegDst;

    reg [31:0] ReadData1;
    reg [31:0] ReadData2;
    reg [31:0] imm_ext;

    reg [31:0] PC_Plus_4;
    reg [4:0] Shamt;
    reg [4:0] rt;
    reg [4:0] rd;

    initial begin
        RegWr           <= 0;
        Branch          <= 0;
        BranchClip      <= 0;
        MemRead         <= 0;
        MemWrite        <= 0;
        MemtoReg        <= 0;
        ALUSrcA         <= 0;
        ALUSrcB         <= 0;
        ALUOp           <= 0;
        RegDst          <= 0;

        ReadData1       <= 0;
        ReadData2       <= 0;
        imm_ext         <= 0;

        PC_Plus_4       <= 0;
        Shamt           <= 0;
        rt              <= 0;
        rd              <= 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset || i_flush) begin
            RegWr           <= 0;
            Branch          <= 0;
            BranchClip      <= 0;
            MemRead         <= 0;
            MemWrite        <= 0;
            MemtoReg        <= 0;
            ALUSrcA         <= 0;
            ALUSrcB         <= 0;
            ALUOp           <= 0;
            RegDst          <= 0;
            ReadData1       <= 0;
            ReadData2       <= 0;
            imm_ext         <= 0;
            PC_Plus_4       <= 0;
            Shamt           <= 0;
            rt              <= 0;
            rd              <= 0;
        end
        else begin
            RegWr       <= i_RegWr         ;
            Branch      <= i_Branch        ;
            BranchClip  <= i_BranchClip    ;
            MemRead     <= i_MemRead       ;
            MemWrite    <= i_MemWrite      ;
            MemtoReg    <= i_MemtoReg      ;
            ALUSrcA     <= i_ALUSrcA       ;
            ALUSrcB     <= i_ALUSrcB       ;
            ALUOp       <= i_ALUOp         ;
            RegDst      <= i_RegDst        ;
            ReadData1   <= i_ReadData1     ;
            ReadData2   <= i_ReadData2     ;
            imm_ext     <= i_imm_ext       ;
            PC_Plus_4   <= i_PC_Plus_4     ;
            Shamt       <= i_Shamt         ;
            rt          <= i_rt            ;
            rd          <= i_rd            ;
        end
    end

endmodule
