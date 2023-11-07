            .data
cadena:     .asciiz "holaaaaa"
res:        .word 0

            .code
            daddi $sp, $zero, 0x400
            daddi $a0, $zero, cadena
            jal CONTAR_VOC
            sd $v0,res($zero)
            halt

CONTAR_VOC: daddi $sp, $sp, -24
            sd $ra, 0($sp)
            sd $s0, 8($sp)
            sd $s1, 16($sp)

            dadd $s1, $zero, $zero
            dadd $s0, $a0, $zero
      loop: lbu $a0, 0($s0)
            beqz $a0, fin
            jal es_vocal
            beqz $v0, nosuma
            daddi $s1, $s1, 1
    nosuma: daddi $s0,$s0, 1
            j loop
       fin: dadd $v0, $zero, $s1
            ld $ra, 0($sp)
            ld $s0, 8($sp)
            ld $s1, 16($sp)
            daddi $sp, $sp, 24
            jr $ra

es_vocal:
            daddi $t0, $0, 0x41
            beq $a0, $t0, loes
            daddi $t0, $0, 0x45
            beq $a0, $t0, loes
            daddi $t0, $0, 0x49
            beq $a0, $t0, loes
            daddi $t0, $0, 0x4f
            beq $a0, $t0, loes
            daddi $t0, $0, 0x55
            beq $a0, $t0, loes
            daddi $t0, $0, 0x61
            beq $a0, $t0, loes
            daddi $t0, $0, 0x65
            beq $a0, $t0, loes
            daddi $t0, $0, 0x69
            beq $a0, $t0, loes
            daddi $t0, $0, 0x6f
            beq $a0, $t0, loes
            daddi $t0, $0, 0x75
            beq $a0, $t0, loes
            daddi $v0,$0, 0
            j fin
loes:       daddi $v0, $0, 1
fin:        jr $ra
