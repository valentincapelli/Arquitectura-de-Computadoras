.data
cadena: .asciiz "QUIERO LA SEPTIMA"
res: .word 0

.code
daddi $sp, $zero, 0x400
daddi $a0, $zero, cadena
jal CONTAR_VOC
sd $v0, res($zero)
halt

CONTAR_VOC: daddi $sp, $sp, -24 ; Reserva lugar en la pila -> 3 x 8
sd $ra, 0($sp)
sd $s0, 8($sp)
sd $s1, 16($sp)
DADD $s0, $a0, $zero ; copia la direccion de inicio de la cadena
dadd $s1, $zero, $zero
loop: lbu $a0, 0($s0)
beqz $a0, final
jal ES_VOCAL
beqz $v0, seguir
daddi $s1, $s1, 1
seguir: daddi $s0, $s0, 1
j loop
final: dadd $v0, $zero, $s1
ld $ra, 0($sp)
ld $s0, 8($sp)
ld $s1, 16($sp)
daddi $sp, $sp, 24
jr $ra

ES_VOCAL: dadd $v0, $zero, $zero
daddi $t0, $zero, 0x41
daddi $t1, $zero, 0x45
daddi $t2, $zero, 0x49
daddi $t3, $zero, 0x4F
daddi $t4, $zero, 0x55
daddi $t5, $zero, 0x61
daddi $t6, $zero, 0x65
daddi $t7, $zero, 0x69
daddi $t8, $zero, 0x6F
daddi $t9, $zero, 0x75

;Guardo las vocales en registros

beq $a0, $t0, vocal
beq $a0, $t1, vocal
beq $a0, $t2, vocal
beq $a0, $t3, vocal
beq $a0, $t4, vocal
beq $a0, $t5, vocal
beq $a0, $t6, vocal
beq $a0, $t7, vocal
beq $a0, $t8, vocal
beq $a0, $t9, vocal
j fin
vocal: daddi $v0, $zero, 1
fin: jr $ra
