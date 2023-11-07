.data
tabla: .word 8,8,8,8,8,6,7,8,9,10
x: .word 5
cant: .word 0
res: .word 0

.code
daddi r11, r0,1
daddi r1, r0, 10
dadd r6, r0, r0

ld r3, x(r0)
dadd r4, r0, r0

loop: ld r2, tabla(r4)
slt r5, r3, r2
bne r5, r11, sigue
daddi r6, r6, 1

sigue: sd r5, res(r4)
daddi r4, r4, 8
daddi r1, r1, -1
bne r1, r0, loop
sd r6, cant(r0)
halt

