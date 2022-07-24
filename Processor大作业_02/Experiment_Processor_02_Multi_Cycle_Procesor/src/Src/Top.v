///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: Top
// Function:
//  (0) implement a multi-cycle processor
//  (1) Control-Signal Generator
//  (2) PC-Signal Generator
//  (3) MUX of IorD Signal
//  (4) Data Memory
//  (5) Instruction Register
//  (6) Immediate Number and Jump Address
//  (7) Data Register
//  (8) MUX of RegDst Signal
//  (9) MUX of MemtoReg Signal
//  (10) Immediate Process
//  (11) Register File
//  (12) Register for Read data 1 and 2
//  (13) ALU Controller
//  (14) MUX of ALUSrc Signal
//  (15) ALU generator
//  (16) ALUOut Register
//  (17) MUX of PCSrc Signal
//  (18) MUX of Zero & PCWriteCond
///////////////////////////////////

`timescale 1ns / 1ps
module Top (reset, clk, output1, output2);
    input reset;
    input clk;
    output [31:0] output1, output2;
    
    wire [5:0] OpCode,Funct;
    wire [4:0] Rs,Rt,Rd,Shamt;
    wire [15:0] Imm16;
    wire [26:0] Jump_addr;
    wire PCWrite_Cond;
    
    wire PCWrite;
    wire [3:0] ALUOp;
    wire [1:0] PCSrc;
    wire PCWriteCond;
    wire RegWrite;
    wire IorD;
    wire IRWrite;
    wire [1:0] RegDst;
    wire MemRead;
    wire MemWrite;
    wire [1:0] MemtoReg;
    wire [1:0] ALUSrc1, ALUSrc2;
    wire ExtOp;
    wire LuiOp;
    
    // Control-Signal Generator
    Controller controller(.reset(reset),.clk(clk),.OpCode(OpCode),.Funct(Funct),.PCWrite(PCWrite),.PCWriteCond(PCWriteCond),.IorD(IorD),.IRWrite(IRWrite),.PCSource(PCSrc),.RegWrite(RegWrite),.RegDst(RegDst),.MemRead(MemRead),.MemWrite(MemWrite),.MemtoReg(MemtoReg),.ALUSrcA(ALUSrc1),.ALUSrcB(ALUSrc2),.ExtOp(ExtOp),.ALUOp(ALUOp),.LuiOp(LuiOp));
    
    // PC-Signal Generator
    wire [31:0] PC_i;
    wire [31:0] PC_o;
    PC pc(.reset(reset),.clk(clk),.PCWrite(PCWrite_Cond),.PC_i(PC_i),.PC_o(PC_o));
    
    // MUX of IorD Signal
    wire [31:0] Addr;
    wire [31:0] Write_data;
    wire [31:0] Mem_data;
    wire [31:0] ALUOut;
    wire [31:0] ALUOut_reg_data;
    
    assign Addr = (IorD == 0)? PC_o:ALUOut_reg_data;
    
    // instruction fetch and deocde & Data Memory
    //InstAndDataMemory inst_and_data_memory(.reset(reset),.clk(clk),.Address(Addr),.Write_data(Write_data),.MemRead(MemRead),.MemWrite(MemWrite),.Mem_data(Mem_data));
    InstAndDataMemory2 inst_and_data_memory(.reset(reset),.clk(clk),.Address(Addr),.Write_data(Write_data),.MemRead(MemRead),.MemWrite(MemWrite),.Mem_data(Mem_data));

    // Instruction Register
    InstReg inst_reg(.reset(reset),.clk(clk),.IRWrite(IRWrite),.Instruction(Mem_data),.OpCode(OpCode),.rs(Rs),.rt(Rt),.rd(Rd),.Shamt(Shamt),.Funct(Funct));
    
    // Immediate Number and Jump Address
    assign Imm16     = {Rd[4:0], Shamt[4:0], Funct[5:0]};
    assign Jump_addr = {Rs[4:0], Rt[4:0], Imm16[15:0]};
    
    // Data Register
    wire [31:0] Data;
    RegTemp reg_temp_data_register(.reset(reset),.clk(clk),.Data_i(Mem_data),.Data_o(Data));
    
    wire [31:0] Read_data1, Read_data2;
    wire [4:0] Read_reg1, Read_reg2, Wr_reg;
    assign Read_reg1 = Rs;
    assign Read_reg2 = Rt;
    
    // MUX of RegDst Signal
    assign Wr_reg = (RegDst == 0)?Rt:(RegDst == 1)?Rd:31;
    
    // MUX of MemtoReg Signal
    wire [31:0] Wr_reg_data;
    assign Wr_reg_data = (MemtoReg == 0)? Data:(MemtoReg == 1)? ALUOut_reg_data:PC_o;
    
    // Immediate Process
    wire [31:0] ImmExtOut, ImmExtShift;
    ImmProcess imm_process(.ExtOp(ExtOp),.LuiOp(LuiOp),.Immediate(Imm16),.ImmExtOut(ImmExtOut),.ImmExtShift(ImmExtShift));

    // Register File
    RegisterFile register_file(.reset(reset),.clk(clk),.RegWrite(RegWrite),.Read_register1(Read_reg1),.Read_register2(Read_reg2),.Write_register(Wr_reg),.Write_data(Wr_reg_data),.Read_data1(Read_data1),.Read_data2(Read_data2));
    
    // Register for Read data 1 and 2
    wire [31:0] Read_reg_data1, Read_reg_data2;
    RegTemp reg_temp_read_data_register_1(.reset(reset),.clk(clk),.Data_i(Read_data1),.Data_o(Read_reg_data1));
    RegTemp reg_temp_read_data_register_2(.reset(reset),.clk(clk),.Data_i(Read_data2),.Data_o(Read_reg_data2));
    assign Write_data = Read_reg_data2;
    
    // ALU Controller
    wire [4:0] ALUConf;
    wire Sign;
    ALUControl alu_control(.ALUOp(ALUOp),.Funct(Funct),.ALUConf(ALUConf),.Sign(Sign));
    
    // MUX of ALUSrc Signal
    wire [31:0] in1,in2;
    assign in1 = (ALUSrc1 == 0)? PC_o:(ALUSrc1 == 2)? Shamt:Read_reg_data1;
    assign in2 = (ALUSrc2 == 0)? Read_reg_data2:(ALUSrc2 == 1)? 4:(ALUSrc2 == 2)? ImmExtOut:ImmExtShift;
    
    // ALU generator
    wire Zero;
    ALU alu(.ALUConf(ALUConf),.Sign(Sign),.In1(in1),.In2(in2),.Zero(Zero),.Result(ALUOut));
    
    // ALUOut Register
    RegTemp reg_temp_aluout_register(.reset(reset),.clk(clk),.Data_i(ALUOut),.Data_o(ALUOut_reg_data));
    
    // MUX of PCSrc Signal
    assign PC_i = (PCSrc == 0)? ALUOut:(PCSrc == 1)? ALUOut_reg_data:(PCSrc == 2)? {PC_o[31:28],Jump_addr,2'b00}:Read_reg_data1;
    
    // MUX of Zero & PCWriteCond
    assign PCWrite_Cond = ((Zero && PCWriteCond) || PCWrite);
    
    assign output1 = register_file.RF_data[2];
    assign output2 = register_file.RF_data[4];
    
endmodule