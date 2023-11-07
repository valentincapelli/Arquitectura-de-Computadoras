         .data
CONTROL: .word 0x10000
DATA:    .word 0x10008
CARACTER: .byte 0

         .text
          lwu $s0, CONTROL($zero)    ; $s0 = dirección de CONTROL
          lwu $s1, DATA($zero) ; $s1 = dirección de DATA

          daddi $s4, $zero, 13 ; $s4 = ascci del enter (13)

          ; leer caracter desde teclado
          loop: daddi $t0, $zero, 9
            sd $t0, 0($s0)          ; CONTROL = 9

            ; presiona una tecla y guarda el caracter en data
            lbu $t1, 0($s1)         ; toma el caracter en $t1

            ; comparo con el ascii del enter
            beq $t1, $s4, fin

            ; guardo en variable
            sd $t1, CARACTER($zero)

            ; tomo direccion de caracter y la pongo en $s3
            daddi $s3,$zero, CARACTER

            ; mando direccion de caracter a data
            sd $s3, 0($s1)

            ; imprimimos caracter
            daddi $t1, $zero, 4
            sd $t1, 0($s0)      ; control = 4

          j loop
          fin:
          halt
