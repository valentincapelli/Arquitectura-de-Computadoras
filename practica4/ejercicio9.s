    .data
  a: .word 5
  x: .word 0
  y: .word 3

    .code
    daddi r11, r0, 1

    ld r1, a(r0)
    ld r2, x(r0)
    ld r3, y(r0)

loop: daddi r1, r1, -1
      bnez r1, loop
      dadd r2, r2 ,r3

    halt
