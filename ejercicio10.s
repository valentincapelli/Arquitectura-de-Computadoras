
    .data
     cadena: .asciiz "adbdcdedfdgdhdid"
     car: .asciiz "d"
     cant: .word 0
     long: .word 16

     .code
     dadd r3, r0, r0
     dadd r4, r0, r0
     ld r6, long(r0)

     lbu r2, car(r0)

     loop:
     lbu r1, cadena(r3)

     beqz r6, fin
     daddi r6, r6, -1
     bne r1, r2, loop
     daddi r3, r3, 1

     daddi r4, r4, 1
     j loop


    fin:
    sd r4, cant(r0)
    halt
