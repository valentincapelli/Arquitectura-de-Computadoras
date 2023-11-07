        .data
CONTROL: .word 0x10000
DATA:    .word 0x10008
zero:   .asciiz "cero  "
one:    .asciiz "uno   "
two:    .asciiz "dos   "
three:  .asciiz "tres  "
four:   .asciiz "cuatro"
five:   .asciiz "cinco "
six:    .asciiz "seis  "
seven:  .asciiz "siete "
eight:  .asciiz "ocho  "
nine:   .asciiz "nueve "

        .code
        lwu $s0, CONTROL($zero)    ; $s0 = dirección de CONTROL
        lwu $s1, DATA($zero)       ; $s1 = dirección de DATA

        jal ingreso
        dadd $a0, $zero, $v0 ; me devuelve el numero en cuestion
        dadd $a1, $zero, $v1 ; me devuelve 1 si es efectivamente un numero
        jal muestra
        halt

        ; leer caracter desde teclado
        ingreso: daddi $t0, $zero, 8
        sd $t0, 0($s0)          ; CONTROL = 8

        ; presiona una tecla y guarda el numero en data
        ld $t1, 0($s1)         ; toma el numero en $t1

        ;chequeo si es un numero
        slti $t2, $t1, 9 ; Compara $t1 con el valor inmediato 0x39, dejando $t2 =1 si $t1 es menor que 0x39 (valores signo)
        beqz $t2, noes
        daddi $t3, $zero, 0
        slt $t2, $t3, $t1 ; Compara $t3 con el valor de $t1, dejando $t2 =1 si $t3 es menor que $t1
        beqz $t2, noes
        dadd $v0, $zero, $t1 ; paso el numero por parametro $v0
        noes: dadd $v1, $zero, $t2 ; paso 1 por $v1 si es efectivamente un numero
        jr $ra

        muestra: beqz $a1, fin
        daddi $t0, $zero, 0
        beq $a0, $t0, writezero
        daddi $t0, $zero, 1
        beq $a0, $t0, writeone
        daddi $t0, $zero, 2
        beq $a0, $t0, writetwo
        daddi $t0, $zero, 3
        beq $a0, $t0, writethree
        daddi $t0, $zero, 4
        beq $a0, $t0, writefour
        daddi $t0, $zero, 5
        beq $a0, $t0, writefive
        daddi $t0, $zero, 6
        beq $a0, $t0, writesix
        daddi $t0, $zero, 7
        beq $a0, $t0, writeseven
        daddi $t0, $zero, 8
        beq $a0, $t0, writeeight

        daddi $t0, $zero, nine
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writezero:
        daddi $t0, $zero, zero
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writeone:
        daddi $t0, $zero, one
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writetwo:
        daddi $t0, $zero, two
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writethree:
        daddi $t0, $zero, three
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writefour:
        daddi $t0, $zero, four
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writefive:
        daddi $t0, $zero, five
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writesix:
        daddi $t0, $zero, six
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writeseven:
        daddi $t0, $zero, seven
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writeeight:
        daddi $t0, $zero, eight
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        j fin
        writenine:
        daddi $t0, $zero, nine
        sd $t0, 0($s1)
        daddi $t0, $zero, 4
        sd $t0, 0($s0)  ; control = 4
        fin:
        jr $ra


