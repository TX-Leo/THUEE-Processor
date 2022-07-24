main:
    addi $s0, $0, 0 # len_str
    addi $a1, $0, 0x0000 # the address of str: 0x00
    addi $a2, $0, 1

read_str_entry:
    lw $t0, 0($a1)
    addi $t1, $zero, 10 # '10' means '\n'
    beq $t0, $t1, read_str_exit
	addi $a1, $a1, 4
	addi $s0, $s0, 1
	j read_str_entry

read_str_exit:
    addi $a1, $a1, 4
    addi $s2, $a1, 0 # store the begin address of pattern
    addi $a2, $0, 1
    addi $s1, $0, 0 # len_pattern

read_pattern_entry:
    lw $t0, 0($a1)
	addi $t1, $zero, 10 # '10' means '\n'
	beq $t0, $t1, read_pattern_exit
	addi $a1, $a1, 4
	addi $s1, $s1, 1
	j read_pattern_entry

read_pattern_exit:
    # call kmp
    addi $a0, $s0, 0 # len_str
    addi $a1, $0, 0 # str
    addi $a2, $s1, 0 # len_pattern
    add $a3, $0, $s2 # pattern
    jal kmp

    # play the result on device
    addi $s0, $v0, 0 # s0 is the raw result
    sll $s1, $s0, 28
    srl $s1, $s1, 28 # get the first 4 bits
    sll $s2, $s0, 24
    srl $s2, $s2, 28 # 
    sll $s3, $s0, 20
    srl $s3, $s3, 28 #
    sll $s4, $s0, 16 
    srl $s4, $s4, 28 # get the last 4 bits

    # write the BCD
    lui $s6, 0x4000
    addi $s6, $s6, 0x0014
    addi $t5, $0, 10000
    addi $t6, $0, 20000
    addi $t7, $0, 30000

display_1:
    addi $t4, $0, 0x100
    addi $a0, $s1, 0
    jal bcd
    lw $s7, 0($s6) # read the num of sys_clk nums
    sub $t3, $s7, $t5
    bgtz $t3, display_2
    j display_1
display_2:
    addi $t4, $0, 0x200
    addi $a0, $s2, 0
    jal bcd
    lw $s7, 0($s6)
    sub $t3, $s7, $t6
    bgtz $t3, display_3
    j display_2
display_3:
    addi $t4, $0, 0x400
    addi $a0, $s3, 0
    jal bcd
    lw $s7, 0($s6)
    sub $t3, $s7, $t7
    bgtz $t3, display_4 
    j display_3
display_4:
    addi $t4, $0, 0x800
    addi $a0, $s4, 0
    jal bcd
    lw $s7, 0($s6)
    sub $t3, $s7, $t5
    bltz $t3, display_1
    j display_4

kmp:
	##### your code here #####
# * params: $a0 - len_str, $a1 - str, $a2 - len_pattern, $a3 - pattern
# * return: $v0 - result
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    addi $s4, $a0, 0 # save the len_str
    addi $s5, $a2, 0 # save the len_pattern
    addi $s6, $a1, 0 # save the str
    addi $s7, $a3, 0 # save the pattern

	addi $s0, $0, 0x300 # save the address # TODO
	
	addi $a0, $s0, 0 # pass the address
	addi $a1, $a2, 0 # len_pattern
	addi $a2, $a3, 0 # pattern
	jal generate_next

    addi $s0, $0, 0 # i
	addi $s1, $0, 0 # j
	addi $s2, $0, 0 # cnt
	
kmp_loop:
    beq $s0, $s4, kmp_exit
    sll $t0, $s0, 2 # i*4
    sll $t1, $s1, 2 # j*4
    add $t4, $s7, $t1 # pattern+j*4
    add $t5, $s6, $t0 # str+i*4
    lw $t6, 0($t4) # pattern[j]
    lw $t7, 0($t5) # str[i]

    bne $t6, $t7, kmp_branch_1 # if pattern[j] != str[i]
    addi $t3, $s5, -1 # len_pattern - 1
    bne $s1, $t3, kmp_branch_2 # j != len_pattern - 1
    addi $s2, $s2, 1 # cnt++
    addi $t8, $s5, -1 # len_pattern - 1
    sll $t8, $t8, 2 # (len_pattern-1) * 4 
    add $t8, $t8, $s3 # next[len_pattern-1]
    lw $s1, 0($t8) # j = next[len_pattern-1]
    addi $s0, $s0, 1 # i++
    j kmp_end_if

kmp_branch_2:
    addi $s1, $s1, 1 # j++
    addi $s0, $s0, 1 # i++
    j kmp_end_if

kmp_branch_1:
    slt $t9, $0, $s1 # j > 0 1
    beq $t9, $0, kmp_branch_3  # if j < 0
    addi $t8, $s1, -1 # j - 1
    sll $t8, $t8, 2 # (j-1) * 4
    add $t8, $t8, $s3 # next[j-1]
    lw $s1, 0($t8) # j = next[j-1]
    j kmp_end_if

kmp_branch_3:
    addi $s0, $s0, 1 # i++

kmp_end_if:
    j kmp_loop

kmp_exit:
    addi $v0, $s2, 0 # return cnt
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

generate_next:
	##### your code here #####
# * params: $a0 - next, $a1 - len_pattern, $a2 - pattern
# * return: 0 or 1
# s0: pattern s1: i s2: j s3: next
    addi $sp, $sp, -12
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)
	addi $s1, $0, 1 # i
	addi $s2, $0, 0 # j
	beq $a1, 0, end_1
	addi $s0, $a2, 0 # pointer of pattern
    addi $s3, $a0, 0 # pointer of next
	sw $zero, 0($s3) # next[0] = 0

next_loop:
	beq $s1, $a1, end_0
    sll $t2, $s1, 2 # 4*i
    sll $t0, $s2, 2 # 4*j
	add $t4, $s0, $t2 # pattern + i
	add $t5, $s0, $t0 # pattern + j
	lw $t4, 0($t4) # pattern[i]
	lw $t5, 0($t5) # pattern[j]
	bne $t4, $t5, next_branch_1
    addi $t0, $s2, 1 # j + 1
    add $t7, $s3, $t2 # next + 4*i
    sw $t0, 0($t7) # next[i] = j + 1
	addi $s2, $s2, 1 # j ++ 
	addi $s1, $s1, 1 # i ++ 
    j next_end_if

next_branch_1:
	slt $t6, $0, $s2 # j > 0
	beq $t6, $zero, next_branch_2
    addi $t7, $s2, -1 # j - 1
    sll $t2, $t7, 2 # 4*(j-1)
    add $t7, $s3, $t2 # next[j-1]
    lw $s2, 0($t7)
    j next_end_if

next_branch_2:
    sll $t2, $s1, 2 # i*4
    add $t7, $s3, $t2 # next + 4*i
	sw $0, 0($t7) # next[i] = 0
	addi $s1, $s1, 1 # i ++ 

next_end_if:
	j next_loop

end_1:
	addi $v0, $0, 1
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    lw $s2, 0($sp)
    addi $sp, $sp, 12
	jr $ra

end_0:
    addi $v0, $0, 0
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    lw $s2, 0($sp)
    addi $sp, $sp, 12
    jr $ra

bcd:
    addi $t0, $0, 0
    beq  $a0, $t0, bcd_0
    addi $t0, $0, 1
    beq  $a0, $t0, bcd_1
    addi $t0, $0, 2
    beq  $a0, $t0, bcd_2
    addi $t0, $0, 3
    beq  $a0, $t0, bcd_3
    addi $t0, $0, 4
    beq  $a0, $t0, bcd_4
    addi $t0, $0, 5
    beq  $a0, $t0, bcd_5
    addi $t0, $0, 6
    beq  $a0, $t0, bcd_6
    addi $t0, $0, 7
    beq  $a0, $t0, bcd_7
    addi $t0, $0, 8
    beq  $a0, $t0, bcd_8
    addi $t0, $0, 9
    beq  $a0, $t0, bcd_9
    addi $t0, $0, 10
    beq  $a0, $t0, bcd_a
    addi $t0, $0, 11
    beq  $a0, $t0, bcd_b
    addi $t0, $0, 12
    beq  $a0, $t0, bcd_c
    addi $t0, $0, 13
    beq  $a0, $t0, bcd_d
    addi $t0, $0, 14
    beq  $a0, $t0, bcd_e
    addi $t0, $0, 15
    beq  $a0, $t0, bcd_f

bcd_0:
    addi $t1, $0, 0x3F
    j write_bcd
bcd_1:
    addi $t1, $0, 0x06
    j write_bcd
bcd_2:
    addi $t1, $0, 0x5B
    j write_bcd
bcd_3:
    addi $t1, $0, 0x4F
    j write_bcd
bcd_4:
    addi $t1, $0, 0x66
    j write_bcd
bcd_5:
    addi $t1, $0, 0x6D
    j write_bcd
bcd_6:
    addi $t1, $0, 0x7D
    j write_bcd
bcd_7:
    addi $t1, $0, 0x07
    j write_bcd
bcd_8:
    addi $t1, $0, 0x7F
    j write_bcd
bcd_9:
    addi $t1, $0, 0x6F
    j write_bcd
bcd_a:
    addi $t1, $0, 0x77
    j write_bcd
bcd_b:
    addi $t1, $0, 0x7C
    j write_bcd
bcd_c:
    addi $t1, $0, 0x39
    j write_bcd
bcd_d:
    addi $t1, $0, 0x5E
    j write_bcd
bcd_e:
    addi $t1, $0, 0x79
    j write_bcd
bcd_f:
    addi $t1, $0, 0x71
    j write_bcd

write_bcd:
    lui $s5, 0x4000
    addi $s5, $s5, 0x0010 # the address of bcd
    add $t1, $t1, $t4
    sw $t1, 0($s5)
    jr $ra
