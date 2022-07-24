///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: single-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_01
// File Type: src(src/constrain/sim)
// Module Name: InsructionMemory2
// Function:
//  (1) Instruction Fetch
//  (2) MIPS Assembly:
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

module InstructionMemory2 (
    input [31:0] Address,
    output reg [31:0] Instruction
);
    always @(*) begin
        case (Address[9:2])
            // addi $a0, $zero, 5
            4'd0:   Instruction <= {6'h08, 5'd0, 5'd4, 16'h0005};
            // xor $v0, $zero, $zero
            4'd1:   Instruction <= {6'h00, 5'd0, 5'd0, 5'd2, 5'd0, 6'h26};
            // jal sum
            4'd2:   Instruction <= {6'h03, 26'h4};
            // Loop:
            // beq $zero, $zero, Loop
            4'd3:   Instruction <= {6'h04, 5'd0, 5'd0, 16'hffff};
            // sum:
            // addi $sp, $sp, -8
            4'd4:   Instruction <= {6'h08, 5'd29, 5'd29, 16'hfff8};
            // sw $ra, 4($sp)
            5'd5:   Instruction <= {6'h2b, 5'd29, 5'd31, 16'h4};
            // sw $a0, 0($sp)
            5'd6:   Instruction <= {6'h2b, 5'd29, 5'd4, 16'h0};
            // slti $t0, $a0, 1
            5'd7:   Instruction <= {6'h0a, 5'd4, 5'd8, 16'h1};
            // beq $t0, $zero, L1
            5'd8:   Instruction <= {6'h04, 5'd0, 5'd8, 16'h2};
            // addi $sp, $sp, 8
            5'd9:   Instruction <= {6'h08, 5'd29, 5'd29, 16'h8};
            // jr $ra
            5'd10:  Instruction <= {6'h0, 5'd31, 15'h0, 6'h8};
            // L1:
            // add $v0, $a0, $v0
            5'd11:  Instruction <= {6'h0, 5'd4, 5'd2, 5'd2, 5'd0, 6'h20};
            // addi $a0, $a0, -1
            5'd12:  Instruction <= {6'h08, 5'd4, 5'd4, 16'hffff};
            // jal sum
            5'd13:  Instruction <= {6'h03, 26'h4};
            // lw $a0, 0($sp)
            5'd14:  Instruction <= {6'h23, 5'd29, 5'd4, 16'h0};
            // lw $ra, 4($sp)
            5'd15:  Instruction <= {6'h23, 5'd29, 5'd31, 16'h4};
            // addi $sp, $sp, 8
            5'd16:  Instruction <= {6'h08, 5'd29, 5'd29, 16'h8};
            // add $v0, $a0, $v0
            5'd17:  Instruction <= {6'h00, 5'd4, 5'd2, 5'd2, 5'd0, 6'd20};
            // jr $ra
            5'd18:  Instruction <= {6'h00, 5'd31, 15'h0, 6'h8};
        endcase
    end

endmodule //InstMem