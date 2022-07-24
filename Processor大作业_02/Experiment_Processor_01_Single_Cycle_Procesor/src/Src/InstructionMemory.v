///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: single-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_01
// File Type: src(src/constrain/sim)
// Module Name: InsructionMemory
// Function:
//  (1) Instruction Fetch
//  (2) MIPS Assembly:
        // 0 addi $a0, $zero, 12123
        // 1 addiu $a1, $zero, -12345
        // 2 sll $a2, $a1, 16
        // 3 sra $a3, $a2, 16
        // 4 beq $a3, $a1, L1
        // 5 lui $a0, 22222
        // L1:
        // 6 add $t0, $a2, $a0
        // 7 sra $t1, $t0, 8
        // 8 addi $t2, $zero, -12123
        // 9 slt $v0, $a0, $t2
        // 10 sltu $v1, $a0, $t2
        // Loop:
        // 11 j Loop
//////////////////////////////////////////////

module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			// addi $a0, $zero, 12123 #(0x2f5b)
			8'd0:    Instruction <= {6'h08, 5'd0 , 5'd4 , 16'h2f5b};
			// addiu $a1, $zero, -12345 #(0xcfc7)
			8'd1:    Instruction <= {6'h09, 5'd0 , 5'd5 , 16'hcfc7};
			// sll $a2, $a1, 16
			8'd2:    Instruction <= {6'h00, 5'd0 , 5'd5 , 5'd6 , 5'd16 , 6'h00};
			// sra $a3, $a2, 16
			8'd3:    Instruction <= {6'h00, 5'd0 , 5'd6 , 5'd7 , 5'd16 , 6'h03};
			// beq $a3, $a1, L1
			8'd4:    Instruction <= {6'h04, 5'd7 , 5'd5 , 16'h0001};
			// lui $a0, 22222 #(0x56ce)
			8'd5:    Instruction <= {6'h0f, 5'd0 , 5'd4 , 16'h56ce};
			// L1:
			// add $t0, $a2, $a0
			8'd6:    Instruction <= {6'h00, 5'd6 , 5'd4 , 5'd8 , 5'd0 , 6'h20};
			// sra $t1, $t0, 8
			8'd7:    Instruction <= {6'h00, 5'd0 , 5'd8 , 5'd9 , 5'd8 , 6'h03};
			// addi $t2, $zero, -12123 #(0xd0a5)
			8'd8:    Instruction <= {6'h08, 5'd0 , 5'd10, 16'hd0a5};
			// slt $v0, $a0, $t2
			8'd9:    Instruction <= {6'h00, 5'd4 , 5'd10 , 5'd2 , 5'd0 , 6'h2a};
			// sltu $v1, $a0, $t2
			8'd10:   Instruction <= {6'h00, 5'd4 , 5'd10 , 5'd3 , 5'd0 , 6'h2b};
			// Loop:
			// j Loop
			8'd11:   Instruction <= {6'h02, 26'd11};
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
