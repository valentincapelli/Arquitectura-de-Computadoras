          .data
res:      .word 0
caracter: .asciiz "U"

          .code
          ld $a0, caracter($0)
          jal es_vocal
          sd $v0,res($0)
          halt

es_vocal: daddi $t0, $0, 0x41
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
loes:     daddi $v0, $0, 1
fin:      jr $ra
