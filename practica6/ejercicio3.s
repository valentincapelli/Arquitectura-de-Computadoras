;3) Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La
;denominada ingreso del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada
;resultado, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de
;los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2).


         .data
CONTROL: .word 0x10000
DATA:    .word 0x10008
one:     .asciiz "uno"
two:     .asciiz "dos"
three:   .asciiz "tres"
four:    .asciiz "cuatro"
five:    .asciiz "cinco"
six:     .asciiz "seis"
seven:   .asciiz "siete"
eight:   .asciiz "ocho"
nine:    .asciiz "nueve"

        .code
        lwu $s0, CONTROL($zero)    ; $s0 = dirección de CONTROL
        lwu $s1, DATA($zero)       ; $s1 = dirección de DATA

        loop: jal ingreso
        dadd $a0, $zero, $v0 ; me devuelve el numero en cuestion
        beqz $v1, loop
        loop1: jal ingreso
        dadd $a1, $zero, $v0 ; me devuelve el numero en cuestion
        beqz $v1, loop1

        jal resultado
        halt


         ; leer caracter desde teclado
        ingreso: daddi $t0, $zero, 8
        sd $t0, 0($s0)          ; CONTROL = 8

        ; presiona una tecla y guarda el numero en data
        ld $t1, 0($s1)         ; toma el numero en $t1

        ;chequeo si es un numero
        slti $t2, $t1, 10 ; Compara $t1 con el valor inmediato 0x39, dejando $t2 =1 si $t1 es menor que 0x39 (valores signo)
        beqz $t2, noes
        daddi $t3, $zero, 0
        slt $t2, $t3, $t1 ; Compara $t3 con el valor de $t1, dejando $t2 =1 si $t3 es menor que $t1
        beqz $t2, noes
        dadd $v0, $zero, $t1 ; paso el numero por parametro $v0
        noes: dadd $v1, $zero, $t2 ; paso 1 por $v1 si es efectivamente un numero
        jr $ra


        resultado:
        dadd $t0, $a1, $a0
        sd $t0, 0($s1)
        daddi $t0, $zero, 1
        sd $t0, 0($s0)  ; control = 1
        jr $ra
