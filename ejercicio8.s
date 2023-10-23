   .data
A: .word 6
B: .word 6
C: .word 0
   .code
   ld r1, A(r0)
   ld r2, B(r0)
   daddi r2, r2, -1
   dadd r3, r0, r1
loop: daddi r2, r2, -1
      bne r2, r0, loop
      dadd r3, r3, r1
   sd r3, C(r0)
   halt
