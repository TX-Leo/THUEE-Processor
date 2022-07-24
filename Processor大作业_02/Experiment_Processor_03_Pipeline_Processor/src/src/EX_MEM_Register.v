///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: EX_MEM_Register
// Function:
//  (1) 
//////////////////////////////////////////////

`timescale 1ns / 1ps

module EX_MEM_Register
(


);
    input wire clk,
    input wire reset,
    input wire          i_MemRead          ,
    input wire          i_MemWrite         ,
    input wire [31:0]   i_WriteData        ,
    input wire [4:0]    i_WriteAddr        ,
    input wire [1:0]    i_MemtoReg         ,
    input wire          i_RegWrite         ,
    input wire [31:0]   i_ALU_out          ,
    input wire [31:0]   i_PC_Plus_4
    reg         MemRead     ;
    reg         MemWrite    ;
    reg [31:0]  WriteData   ;
    reg [4:0]   WriteAddr   ;
    reg [1:0]   MemtoReg    ;
    reg         RegWrite    ;
    reg [31:0]  ALU_out     ;
    reg [31:0]  PC_Plus_4   ;

    initial begin
        MemRead     <= 0;
        MemWrite    <= 0;
        WriteData   <= 0;
        WriteAddr   <= 0;
        MemtoReg    <= 0;
        RegWrite    <= 0;
        ALU_out     <= 0;
        PC_Plus_4   <= 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            MemRead         <= 0;
            MemWrite        <= 0;
            WriteData       <= 0;
            WriteAddr       <= 0;
            MemtoReg        <= 0;
            RegWrite        <= 0;
            ALU_out         <= 0;
            PC_Plus_4       <= 0;
        end
        else begin
            MemRead         <= i_MemRead   ;
            MemWrite        <= i_MemWrite  ;
            WriteData       <= i_WriteData ;
            WriteAddr       <= i_WriteAddr ;
            MemtoReg        <= i_MemtoReg  ;
            RegWrite        <= i_RegWrite  ;
            ALU_out         <= i_ALU_out   ;
            PC_Plus_4       <= i_PC_Plus_4 ;
        end
    end

endmodule
