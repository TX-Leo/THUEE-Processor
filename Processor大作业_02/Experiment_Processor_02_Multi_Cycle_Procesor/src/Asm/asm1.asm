///////////////////////////////////////////////
// Author:TX-Leo
// Target Devices: XILINX xc7A35TCSG324-1
// Tool Versions: Vivado 2019.2
// Create Date: 2022/06/13
// Project Name: multi-cycle processor
// Description: It's TX-Leo's Experiment_Processor_02_02
// File Type: asm
//////////////////////////////////////////////

    addi $a0, $zero, 12123          //$a0 = 12123     (0x00002f5b)
    addiu $a1, $zero, -12345        //$a1 = -12345    (0xffffcfc7)
    sll $a2, $a1, 16                //$a2 = $a1 << 16 (0xcfc70000)
    sra $a3, $a2, 16                //$a3 = $a2 >> 16 (0xffffcfc7)
    beq $a3, $a1, L1                //$a3 == $a1 , jump to L1
    lui $a0, 22222             
L1:
    add $t0, $a2, $a0               //$t0 = $a2 + $a0 (0xcfc72f5b)
    sra $t1, $t0, 8                 //$t1 = $t0 >> 8  (0xffcfc72f)
    addi $t2, $zero, -12123         //$t2 = -12123    (0xffffd0a5)
    slt $v0, $a0, $t2               //$a0 > $t2, $v0 = 0 (signed)
    sltu $v1, $a0, $t2              //$a0 < $t2, $v1 = 1 (unsigned)
Loop:
    j Loop