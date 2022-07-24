///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: Contoller
// Function:
/////////////

`timescale 1ns / 1ps

module Controller
(
    input wire [5:0] i_OpCode,
    input wire [5:0] i_Funct,
    output reg o_RegWr,
    output reg o_Branch,
    output reg o_BranchClip,
    output reg o_Jump,
    output reg o_MemRead,
    output reg o_MemWrite,
    output reg [1:0] o_MemtoReg,
    output reg o_JumpSrc,
    output reg o_ALUSrcA,
    output reg o_ALUSrcB,
    output reg [3:0] o_ALUOp,
    output reg [1:0] o_RegDst,
    output reg o_LuiOp,
    output reg o_SignedOp
);

    always @(*) begin
        // o_RegWr
        if (i_OpCode == 0)begin
            if (i_Funct == 6'h08)    // jr
                o_RegWr <= 0;
            else
                o_RegWr <= 1;
        end
        else begin
            case (i_OpCode)
            6'hf, 6'h08, 6'h09, 6'h0c, 6'h0b, 6'h23, 6'h03:
                o_RegWr <= 1;
            default:
                o_RegWr <= 0;
            endcase
        end
        // Brach and o_BranchClip
        case (i_OpCode)
            6'h04, 6'h06:      // beq, blez
                begin
                    o_Branch <= 1;
                    o_BranchClip <= 0;
                end
            6'h05, 6'h07, 6'h01:   // bne, bgtz, bltz
                begin
                    o_Branch <= 1;
                    o_BranchClip <= 1;
                end
            default:
                begin
                    o_Branch <= 0;
                    o_BranchClip <= 0;
                end
        endcase
        // o_Jump
        if ((i_OpCode == 0 && (i_Funct == 6'h08 || i_Funct == 6'h09))|| (i_OpCode == 6'h02 || i_OpCode == 6'h03)) 
            o_Jump <= 1;
        else
            o_Jump <= 0;
        // o_MemRead
        o_MemRead <= i_OpCode == 6'h23;
        // o_MemWrite
        o_MemWrite <= i_OpCode == 6'h2b;
        // o_MemtoReg: 00-ALUResult, 01-Data-Mem, 10-PC+4 
        if (i_OpCode == 6'h23) 
            o_MemtoReg <= 2'b01; // lw
        else if (i_OpCode == 6'h03 || (i_OpCode == 0 && i_Funct == 6'h09)) // jal, jalr
            o_MemtoReg <= 2'b10;
        else
            o_MemtoReg <= 2'b00;
        // o_JumpSrc: 0-Imm, 1-reg1
        o_JumpSrc <= i_OpCode == 0;
        // o_ALUSrcA: 0-ReadData1, 1-Shamt
        if (i_OpCode == 0 &&(i_Funct == 6'h0 || i_Funct == 6'h02 || i_Funct == 6'h03))
            o_ALUSrcA <= 1;
        else
            o_ALUSrcA <= 0;
        // o_ALUSrcB: 0-ReadData2, 1-imm
        case (i_OpCode)
            6'h0f, 6'h08, 6'h09, 6'h0c, 6'h0b, 6'h23, 6'h2b:
                o_ALUSrcB <= 1;
            default:
                o_ALUSrcB <= 0;
        endcase
        // o_RegDst: 00-rd, 01-rt, 10-%ra
        case (i_OpCode)
            6'h0f, 6'h08, 6'h09, 6'h0c, 6'h0b, 6'h23: 
                o_RegDst <= 2'b01; // I and lw
            6'h03: 
                o_RegDst <= 2'b10;    // jal
            default: begin
                if (i_Funct == 6'h09) 
                    o_RegDst <= 2'b10;
                else 
                    o_RegDst <= 2'b00;
            end
        endcase
        // o_LuiOp
        o_LuiOp <= (i_OpCode == 6'h0f);
        // o_SignedOp
        o_SignedOp <= (i_OpCode == 6'h0c ? 0 : 1);
    end
    // o_ALUOp
    parameter add_op        = 4'h0;     // add
    parameter sub_op        = 4'h1;     // sub
    parameter and_op        = 4'h3;     // and
    parameter or_op         = 4'h4;     // or
    parameter xor_op        = 4'h5;     // xor
    parameter nor_op        = 4'h6;     // nor
    parameter u_cmp_op      = 4'h7;     // unsigned cmp
    parameter s_cmp_op      = 4'h8;     // signed cmp
    parameter sll_op        = 4'h9;     // sll
    parameter srl_op        = 4'hA;     // srl
    parameter sra_op        = 4'hB;     // sra
    parameter gtz_op        = 4'hC;     // gtz, greater than zero
    always @(*) begin
        case (i_OpCode)
            6'h0: begin
                case (i_Funct)
                    6'h20, 6'h21: o_ALUOp <= add_op;
                    6'h22, 6'h23: o_ALUOp <= sub_op;
                    6'h24: o_ALUOp <= and_op;
                    6'h25: o_ALUOp <= or_op;
                    6'h26: o_ALUOp <= xor_op;
                    6'h27: o_ALUOp <= nor_op;
                    6'h2a: o_ALUOp <= s_cmp_op;
                    6'h2b: o_ALUOp <= u_cmp_op;
                    6'h00: o_ALUOp <= sll_op;
                    6'h02: o_ALUOp <= srl_op;
                    6'h03: o_ALUOp <= sra_op;
                    default: o_ALUOp <= add_op;
                endcase
            end
            6'h0f, 6'h08, 6'h09, 6'h23, 6'h2b: o_ALUOp <= add_op;
            6'h0c: o_ALUOp <= and_op;
            6'h0b: o_ALUOp <= u_cmp_op;
            6'h04, 6'h05: o_ALUOp <= sub_op;
            6'h06, 6'h07: o_ALUOp <= gtz_op;
            6'h01: o_ALUOp <= s_cmp_op;
            default: o_ALUOp <= add_op;
        endcase
    end

endmodule
