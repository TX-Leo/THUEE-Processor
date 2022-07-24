///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: single-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_01
// File Type: asm
//////////////////////////////////////////////

addi $a0, $zero, 5              # $a0 = 5
xor $v0, $zero, $zero           # $v0 = 0
jal sum                         # jump to block "sum"

Loop:
    beq $zero, $zero, Loop      # if (0 == 0) repeat;

sum:
    addi $sp, $sp, -8           # move the stack point
    sw $ra, 4($sp)              # save $ra
    sw $a0, 0($sp)              # save $a0
    slti $t0, $a0, 1            # if ($a0 < 1) $t0 = 1;
    beq $t0, $zero, L1          # if ($t0 == 0) jump to block "L1"
    addi $sp, $sp, 8            # move the stack point back
    jr $ra                      # jump out of sum

L1:
    add $v0, $a0, $v0           # $v0 = $a0 + $v0
    addi $a0, $a0, -1           # $a0 = $a0 - 1
    jal sum                     # jump to block "sum"
    lw $a0, 0($sp)              # reload $a0
    lw $ra, 4($sp)              # reload $ra
    addi $sp, $sp, 8            # reset the stack point
    add $v0, $a0, $v0           # $v0 = $a0 + $v0
    jr $ra                      # return to main