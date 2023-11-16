.data
data:    .word 0x10008
control: .word 0x10000
base:    .double 0.0
exp:     .word 0
uno:     .double 1.0
cero:    .double 0.0

         .code
         ld $s0, control($zero)  ; cargo direccion de control en $s0
         ld $s1, data($zero)     ; cargo la direccion de data en $s1
         daddi $t0, $zero, 8     ; cargo 8 en $t0
         sd $t0, 0($s0)          ; control = 8 para solicitar el ingreso de un numero flotante o entero
         l.d f0, 0($s1)          ; tomo el valor en punto flotante
         sd $t0, 0($s0)          ; control = 8
         ld $t2, 0($s1)          ; tomo el valor entero

         s.d f0, base($zero)     ; guardo la base en su variable
         sd $t2, exp($zero)      ; guardo el exponente en su variable
         
         ld $a1, exp($zero)      ; cargo el exponente entero en el registro $a1
         jal a_la_potencia       ; llamo a la subrutina que hace la potencia
         halt

         a_la_potencia: beqz $a1, imprime_uno  ; si $a1 es 0,imprimir 1
         l.d f4, cero($zero)       ;me guardo el valor 0.0 en f4
         add.d f2, f4, f0          ;me guardo el valor de la base en f2  
         loop: daddi $a1, $a1, -1        ;resto uno al exponente
         beqz $a1, imprimir        ; si es cero tengo que imprimir lo que tengo en f2
         mul.d f2, f2, f0          ; multiplico f2 por f0
         j loop

         imprime_uno: l.d f2, uno($zero)
         imprimir: ld $t6, control($zero)
         ld $t7, data($zero)
         s.d f2, 0($t7)
         daddi $t1, $zero, 3
         sd $t1, 0($t6)
         jr $ra