///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/07/17
// Project Name: pipeline processor
// Description: It's TX-Leo's Experiment_Processor_03_pipeline_processor
// File Type: src(src/constrain/sim)
// Module Name: Top_Pipeline_Processor
// Function:
/////////////

`timescale 1ns / 1ps

module Top_Pipeline_Processor
(
    input wire sysclk,
    input wire i_clk,
    input wire reset,
    output wire [7:0] leds,
    output wire [3:0] an,
    output wire [7:0] bcd7
);

    wire clk;
    assign clk = i_clk;

    wire [31:0] i_PC;
    wire [31:0] o_PC;
    wire PCWrite;
    wire [31:0] ReadInst;
    wire IF_ID_Flush;
    wire [5:0] OpCode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] Shamt;
    wire [5:0] Funct;
    wire [31:0] PC_Plus_4;
    wire IF_ID_Hold;
    wire [4:0] MEM_WB_WriteAddr;
    wire [31:0] MEM_WB_WriteData;
    wire MEM_WB_RegWr;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] ReadData1Actual;
    wire [31:0] ReadData2Actual;
    wire [1:0] ForwardA;
    wire [1:0] ForwardB;
    wire RegWr;
    wire Branch;
    wire BranchClip;
    wire Jump;
    wire MemRead;
    wire MemWrite;
    wire [1:0] MemtoReg;
    wire JumpSrc;
    wire ALUSrcA;
    wire ALUSrcB;
    wire [3:0] ALUOp;
    wire [1:0] RegDst;
    wire LuiOp;
    wire SignedOp;
    wire [31:0] J_out;
    assign J_out = Jump == 0 ? (o_PC + 4) :JumpSrc == 0 ? {PC_Plus_4[31:28], rs, rt, rd, Shamt, Funct, 2'b00} :ReadData1Actual;
    wire [31:0] out_ext;
    wire ID_EX_Flush;
    wire [31:0] ALU_in1;
    wire [31:0] ALU_in2;
    wire [31:0] ALU_out;
    wire ALU_zero;
    assign ALU_in1 = my_id_ex_register.ALUSrcA == 0 ? my_id_ex_register.ReadData1 :{ 27'h0, my_id_ex_register.Shamt };
    assign ALU_in2 = my_id_ex_register.ALUSrcB == 0 ? my_id_ex_register.ReadData2 :my_id_ex_register.imm_ext;
    wire no_branch;
    assign no_branch = (my_id_ex_register.Branch == 0 || !(ALU_zero ^ my_id_ex_register.BranchClip));
    assign i_PC = no_branch ? J_out :my_id_ex_register.PC_Plus_4 + (my_id_ex_register.imm_ext << 2);
    wire [4:0] EX_WriteAddr;
    assign EX_WriteAddr = my_id_ex_register.RegDst == 2'b00 ? my_id_ex_register.rd :my_id_ex_register.RegDst == 2'b01 ? my_id_ex_register.rt :5'd31;
    wire [31:0] DataMemReadData;
    assign MEM_WB_WriteAddr = my_mem_wb_register.WriteAddr;
    assign MEM_WB_RegWr = my_mem_wb_register.RegWr;
    assign MEM_WB_WriteData =my_mem_wb_register.MemtoReg == 2'b00 ? my_mem_wb_register.ALU_result :my_mem_wb_register.MemtoReg == 2'b01 ? my_mem_wb_register.ReadData :my_mem_wb_register.PC_next;
    wire LW_Stall;
    assign PCWrite = LW_Stall;
    assign IF_ID_Hold = LW_Stall;
    wire Branch_ID_EX_Flush;
    assign ID_EX_Flush = Branch_ID_EX_Flush || LW_Stall;
    assign ReadData1Actual =ForwardA == 2'b01 ? ALU_out :ForwardA == 2'b10 ?(my_ex_mem_register.MemtoReg == 2'b00 ? my_ex_mem_register.ALU_out :my_ex_mem_register.MemtoReg == 2'b01 ? DataMemReadData :my_ex_mem_register.PC_Plus_4):ReadData1;
    assign ReadData2Actual =ForwardB == 2'b01 ? ALU_out :ForwardB == 2'b10 ?(my_ex_mem_register.MemtoReg == 2'b00 ? my_ex_mem_register.ALU_out :my_ex_mem_register.MemtoReg == 2'b01 ? DataMemReadData :my_ex_mem_register.PC_Plus_4) :ReadData2;
    // Debounce my_debounce
    // (
    //         .clk(sysclk),
    //         .key_i(i_clk),
    //         .key_o(clk)
    // );
    PC my_pc
    (
            .clk(clk),
            .reset(reset),
            .i_PCWrite(PCWrite),
            .i_PC(i_PC),
            .o_PC(o_PC)
    );
    Data_Memory my_data_memory
    (
            .clk(clk),
            .reset(reset),
            .i_addr(my_ex_mem_register.i_ALU_out),
            .i_WriteData(my_ex_mem_register.i_WriteData),
            .i_MemRead(my_ex_mem_register.i_MemRead),
            .i_MemWrite(my_ex_mem_register.MemWrite),
            .o_ReadData(DataMemReadData),
            .o_leds(leds),
            .o_an(an),
            .o_bcd7(bcd7)
    );
    Instruction_Memory my_instruction_memory
    (
            .i_address(o_PC),
            .o_instruction(ReadInst)
    );
    Controller my_controller
    (
            .i_OpCode(OpCode),
            .i_Funct(Funct),
            .o_RegWr(RegWr),
            .o_Branch(Branch),
            .o_BranchClip(BranchClip),
            .o_Jump(Jump),
            .o_MemRead(MemRead),
            .o_MemWrite(MemWrite),
            .o_MemtoReg(MemtoReg),
            .o_JumpSrc(JumpSrc),
            .o_ALUSrcA(ALUSrcA),
            .o_ALUSrcB(ALUSrcB),
            .o_ALUOp(ALUOp),
            .o_RegDst(RegDst),
            .o_LuiOp(LuiOp),
            .o_SignedOp(SignedOp)
    );
    ALU my_alu
    (
            .i_In1(ALU_in1),
            .i_In2(ALU_in2),
            .i_ALUOp(my_id_ex_register.ALUOp),
            .o_Result(ALU_out),
            .o_Zero(ALU_zero)
    );
    ImmediateExtend my_immediate_extend
    (
            .i_in({rd, Shamt, Funct}),
            .i_LuiOp(LuiOp),
            .i_SignedOp(SignedOp),
            .o_out_ext(out_ext)
    );
    RegisterFile my_register_file
    (
            .clk(clk),
            .reset(reset),
            .i_Read_register1(rs),
            .i_Read_register2(rt),
            .i_Write_register(MEM_WB_WriteAddr),
            .i_Write_data(MEM_WB_WriteData),
            .i_RegWrite(MEM_WB_RegWr),
            .o_Read_data1(ReadData1),
            .o_Read_data2(ReadData2)
    );
    IF_ID_Register my_if_id_register
    (
            .clk(clk),
            .reset(reset),
            .i_flush(IF_ID_Flush),
            .i_hold(IF_ID_Hold),
            .i_ReadInst(ReadInst),
            .i_IF_PC_Plus_4(o_PC + 4),
            .o_OpCode(OpCode),
            .o_rs(rs),
            .o_rt(rt),
            .o_rd(rd),
            .o_Shamt(Shamt),
            .o_Funct(Funct),
            .o_PC_Plus_4(PC_Plus_4)
    );
    ID_EX_Register my_id_ex_register
    (
            .clk(clk),
            .reset(reset),
            .i_flush(ID_EX_Flush),
            .i_RegWr       (RegWr      ),
            .i_Branch      (Branch     ),
            .i_BranchClip  (BranchClip ),
            .i_MemRead     (MemRead    ),
            .i_MemWrite    (MemWrite   ),
            .i_MemtoReg    (MemtoReg   ),
            .i_ALUSrcA     (ALUSrcA    ),
            .i_ALUSrcB     (ALUSrcB    ),
            .i_ALUOp       (ALUOp      ),
            .i_RegDst      (RegDst     ),
            .i_ReadData1   (ReadData1Actual  ),
            .i_ReadData2   (ReadData2Actual  ),
            .i_imm_ext     (out_ext    ),
            .i_PC_Plus_4   (PC_Plus_4  ),
            .i_Shamt       (Shamt      ),
            .i_rt          (rt         ),
            .i_rd          (rd         )
    );
    EX_MEM_Register my_ex_mem_register
    (
            .clk(clk),
            .reset(reset),
            .i_MemRead  (my_id_ex_register.MemRead  ),
            .i_MemWrite (my_id_ex_register.MemWrite ),
            .i_WriteData(my_id_ex_register.ReadData2),
            .i_WriteAddr(EX_WriteAddr       ),
            .i_MemtoReg (my_id_ex_register.MemtoReg ),
            .i_RegWrite (my_id_ex_register.RegWr    ),
            .i_ALU_out  (ALU_out            ),
            .i_PC_Plus_4(my_id_ex_register.PC_Plus_4)
    );
    MEM_WB_Register my_mem_wb_register
    (
            .clk(clk),
            .reset(reset),
            .i_RegWr(my_ex_mem_register.RegWrite),
            .i_MemtoReg(my_ex_mem_register.MemtoReg),
            .i_WriteAddr(my_ex_mem_register.WriteAddr),
            .i_ReadData(DataMemReadData),
            .i_ALU_result(my_ex_mem_register.ALU_out),
            .i_PC_next(my_ex_mem_register.PC_Plus_4)
    );
    Data_Hazard my_data_hazard
    (
            .i_ID_EX_RegWrite(my_id_ex_register.RegWr),
            .i_ID_EX_WriteAddr(EX_WriteAddr),
            .i_EX_MEM_RegWrite(my_ex_mem_register.RegWrite),
            .i_EX_MEM_WriteAddr(my_ex_mem_register.WriteAddr),
            .i_rs(rs),
            .i_rt(rt),
            .i_ID_EX_MemRead(my_id_ex_register.MemRead),
            .o_ForwardA(ForwardA),
            .o_ForwardB(ForwardB),
            .o_LW_Stall(LW_Stall)
    );
    Control_Hazard my_control_hazard
    (
            .i_Jump(Jump),
            .i_no_branch(no_branch),
            .o_IF_ID_Flush(IF_ID_Flush),
            .o_ID_EX_Flush(Branch_ID_EX_Flush)
    );

endmodule
