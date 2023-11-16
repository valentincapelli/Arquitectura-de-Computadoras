;6) El siguiente programa produce una salida estableciendo el color de un punto de la pantalla gráfica (en la ventana
;Terminal del simulador WinMIPS64). Modifique el programa de modo que las coordenadas y color del punto sean
;ingresados por teclado.

         .data
coorX:   .byte 0 ; coordenada X de un punto
coorY:   .byte 0 ; coordenada Y de un punto
color:   .byte 0 ; color: máximo rojo + máximo azul => magenta
CONTROL: .word32 0x10000
DATA:    .word32 0x10008

         .text
         lwu $s6, CONTROL($zero)    ; $s6 = dirección de CONTROL
         lwu $s7, DATA($zero)       ; $s7 = dirección de DATA
         daddi $t0, $zero, 7        ; $t0 = 7 -> función 7: limpiar pantalla gráfica
         sd $t0, 0($s6)             ; CONTROL recibe 7 y limpia la pantalla gráfica

         daddi $t0, $zero, 8        ; le mando el 8 a $t0 

         sd $t0, 0($s6)             ; control = 8
         lbu $s0, 0($s7)            ; tomo el valor en $s0 (coordenadaX)
         
         sd $t0, 0($s6)             ; control = 8
         lbu $s1, 0($s7)            ; tomo el valor en $s1

        
         dadd $t1, $zero, $zero     ; contador de las 4 posiciones en 0
         daddi $t4, $zero, 4        ; guardo 4 en $t4 para comparar si llego al final
         loop: sd $t0, 0($s6)          ; control = 8
           lbu $s2, 0($s7)            ; tomo el valor en $s2
           sb $s2, color($t1)         ; guardo el valor con el corrimiento correspondiente
           daddi $t1, $t1, 1          ; sumo 1 al contador
           beq $t1, $t4, segui        ; si $t1 llego a 4 termino
           j loop
         segui:

         sb $s0, 5($s7)             ; DATA+5 recibe el valor de coordenada X
         sb $s1, 4($s7)             ; DATA+4 recibe el valor de coordenada Y

         lwu $s2, color($zero)      ; $s2 = valor de color a pintar
         sw $s2, 0($s7)             ; DATA recibe el valor del color a pintar
         
         daddi $t0, $zero, 5        ; $t0 = 5 -> función 5: salida gráfica
         sd $t0, 0($s6)             ; CONTROL recibe 5 y produce el dibujo del punto
         halt