///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: single-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_01
// File Type: src(src/constrain/sim)
// Module Name: Top
// Function:
//  (1) implement a singel-cycle processor
//  (2) update PC
//  (3) Instruction Fetch and decode
//  (4) Read from Register
//  (5) ALU
//  (6) Write to DataMemory
//  (7) MUX
//  (8) PC_next
//  (9) output
//////////////////////////////////////////////

module Top (input reset,
            input clk, 
            output [31:0] output1, 
            output [31:0] output2
            );
    //parameter definition
    reg [31:0] PC;
    wire [31:0] PC_next;
    wire [31:0] PC_normal;
    wire [1:0] RegDst;
    wire [1:0] PCSrc;
    wire Branch;
    wire MemRead;
    wire [1:0] MemtoReg;
    wire ExtOp;
    wire LuOp;
    wire MemWrite;
    wire ALUSrc1;
    wire ALUSrc2;
    wire RegWrite;
    wire [31:0] Instruction;
    wire [31:0] ReadSrc1, ReadSrc2, WriteSrc;
    wire [4:0] Write_Reg;
    wire [31:0] ext, lu;
    wire [4:0] ALUCtrl;
    wire Sign, Zero;
    wire [31:0] data_in1, data_in2;
    wire [31:0] data_out;
    wire [31:0] data_read;
    wire [31:0] jump_addr, branch_addr;
    
    //update PC
    always @(posedge reset or posedge clk) begin
        if (reset) PC <= 0;
        else PC       <= PC_next;
    end
    assign PC_normal = PC + 4;

    //Instruction Fetch and decode
    //InstructionMemory instruction_memory(.Address(PC), .Instruction(Instruction));
    InstructionMemory2 instruction_memory(.Address(PC), .Instruction(Instruction));
    
    Control control(.OpCode(Instruction[31:26]), .Funct(Instruction[5:0]),.PCSrc(PCSrc), .Branch(Branch), .RegWrite(RegWrite), .RegDst(RegDst),.MemRead(MemRead), .MemWrite(MemWrite), .MemtoReg(MemtoReg),.ALUSrc1(ALUSrc1), .ALUSrc2(ALUSrc2), .ExtOp(ExtOp), .LuOp(LuOp));
    
    //Read from Register
    assign Write_Reg = (RegDst == 0)? Instruction[20:16]: (RegDst == 1)? Instruction[15:11]: 31;
    RegisterFile register_file(.reset(reset), .clk(clk), .RegWrite(RegWrite),.Read_register1(Instruction[25:21]), .Read_register2(Instruction[20:16]),.Write_register(Write_Reg), .Write_data(WriteSrc), .Read_data1(ReadSrc1), .Read_data2(ReadSrc2));
    
    assign ext = {ExtOp ?{16{Instruction[15]}}:16'h0,Instruction[15:0]};
    assign lu  = LuOp?{Instruction[15:0], 16'h0}:ext;
    
    //ALU
    ALUControl alu_control(.OpCode(Instruction[31:26]), .Funct(Instruction[5:0]),.ALUCtrl(ALUCtrl), .Sign(Sign));
    ALU alu(.in1(data_in1), .in2(data_in2), .out(data_out), .ALUCtrl(ALUCtrl),.Sign(Sign), .zero(Zero));
    assign data_in1 = ALUSrc1?{17'h0,Instruction[10:6]}:ReadSrc1;
    assign data_in2 = ALUSrc2? lu:ReadSrc2;
    
   //Write to DataMemory
    DataMemory data_memory(.reset(reset), .clk(clk), .Address(data_out), .Write_data(ReadSrc2),.MemRead(MemRead), .MemWrite(MemWrite), .Read_data(data_read));
    assign WriteSrc = (MemtoReg == 0)?data_out:(MemtoReg == 1)?data_read:PC_normal;
    
   //MUX
    assign jump_addr   = {PC_normal[31:28], Instruction[25:0], 2'b00};
    assign branch_addr = (Branch & Zero) ? PC_normal + {lu[29:0], 2'b00}:PC_normal;
    
    //PC_next
    assign PC_next = (PCSrc == 0)? branch_addr:(PCSrc == 1)? jump_addr:ReadSrc1;
    
    //output
    assign output1 = register_file.RF_data[2];
    assign output2 = register_file.RF_data[4];
endmodule
    
