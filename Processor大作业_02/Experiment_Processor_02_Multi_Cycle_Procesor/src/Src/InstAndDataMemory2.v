///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: src(src/constrain/sim)
// Module Name: InstAndDataMemory2
// Function:
//  (1) generate data memory which can write and read
//  (2) instruction Fetch
//  (3) MIPS Assembly
        // 0 addi $a0, $zero, 5
        // 1 xor $v0, $zero, $zero2 jal sum
        // Loop:
        // 3 beq $zero, $zero, Loop
        // sum:
        // 4 addi $sp, $sp, -8
        // 5 sw $ra, 4($sp)
        // 6 sw $a0, 0($sp)
        // 7 slti $t0, $a0, 1
        // 8 beq $t0, $zero, L1
        // 9 addi $sp, $sp, 8
        // 10 jr $ra
        // L1:
        // 11 add $v0, $a0, $v0
        // 12 addi $a0, $a0, -1
        // 13 jal sum
        // 14 lw $a0, 0($sp)
        // 15 lw $ra, 4($sp)
        // 16 addi $sp, $sp, 8
        // 17 add $v0, $a0, $v0
        // 18 jr $ra
//////////////////////////////////////////////

`timescale 1ns / 1ps
module InstAndDataMemory2(reset, clk, Address, Write_data, MemRead, MemWrite, Mem_data);
	//Input Clock Signals
	input reset;
	input clk;
	//Input Data Signals
	input [31:0] Address;
	input [31:0] Write_data;
	//Input Control Signals
	input MemRead;
	input MemWrite;
	//Output Data
	output [31:0] Mem_data;
	
	parameter RAM_SIZE = 256;
	parameter RAM_SIZE_BIT = 8;
	parameter RAM_INST_SIZE = 32;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];

	//read data
	assign Mem_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	//write data
	integer i;
	always @(posedge reset or posedge clk) begin
		if (reset) begin
		    // init instruction memory
            // addi $a0, $zero, 5
            RAM_data[8'd0] <= {6'h08, 5'd0, 5'd4, 16'h0005};
            // xor $v0, $zero, $zero
            RAM_data[8'd1] <= {6'h00, 5'd0, 5'd0, 5'd2, 5'd0, 6'h26};
            // jal sum
            RAM_data[8'd2] <= {6'h03, 26'h4};
            // Loop:
            // beq $zero, $zero, Loop
            RAM_data[8'd3] <= {6'h04, 5'd0, 5'd0, 16'hffff};
            // sum:
            // addi $sp, $sp, -8
            RAM_data[8'd4] <= {6'h08, 5'd29, 5'd29, 16'hfff8};
            // sw $ra, 4($sp)
            RAM_data[8'd5] <= {6'h2b, 5'd29, 5'd31, 16'h4};
            // sw $a0, 0($sp)
            RAM_data[8'd6] <= {6'h2b, 5'd29, 5'd4, 16'h0};
            // slti $t0, $a0, 1
            RAM_data[8'd7] <= {6'h0a, 5'd4, 5'd8, 16'h1};
            // beq $t0, $zero, L1
            RAM_data[8'd8] <= {6'h04, 5'd0, 5'd8, 16'h2};
            // addi $sp, $sp, 8
            RAM_data[8'd9] <= {6'h08, 5'd29, 5'd29, 16'h8};
            // jr $ra
            RAM_data[8'd10] <= {6'h0, 5'd31, 15'h0, 6'h8};
            // L1:
            // add $v0, $a0, $v0
            RAM_data[8'd11] <= {6'h0, 5'd4, 5'd2, 5'd2, 5'd0, 6'h20};
            // addi $a0, $a0, -1
            RAM_data[8'd12] <= {6'h08, 5'd4, 5'd4, 16'hffff};
            // jal sum
            RAM_data[8'd13] <= {6'h03, 26'h4};
            // lw $a0, 0($sp)
            RAM_data[8'd14] <= {6'h23, 5'd29, 5'd4, 16'h0};
            // lw $ra, 4($sp)
            RAM_data[8'd15] <= {6'h23, 5'd29, 5'd31, 16'h4};
            // addi $sp, $sp, 8
            RAM_data[8'd16] <= {6'h08, 5'd29, 5'd29, 16'h8};
            // add $v0, $a0, $v0
            RAM_data[8'd17] <= {6'h00, 5'd4, 5'd2, 5'd2, 5'd0, 6'd20};
            // jr $ra
            RAM_data[8'd18] <= {6'h00, 5'd31, 15'h0, 6'h8};
            //init instruction memory
            //reset data memory		  
			for (i = RAM_INST_SIZE; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
		end else if (MemWrite) begin
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
		end
	end

endmodule
