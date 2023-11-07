          .data
peso:     .double 75.0
estatura: .double 1.74
IMC:      .double 0.0
estado:   .word 4

infrapeso: .double 18.5
normal:   .double 25.0
sobrepeso: .double 30.0

          .code
          l.d f1, peso(r0)
          l.d f2, estatura(r0)
          mul.d f3, f2, f2
          div.d f3, f1, f3
          s.d f3, IMC(r0)

          l.d f10, infrapeso(r0)
          c.lt.d f3, f10
          bc1t infra

          l.d f10, normal(r0)
          c.lt.d f3, f10
          bc1t nor

          l.d f10, sobrepeso(r0)
          c.lt.d f3, f10
          bc1t sobre

          j fintotal

   sobre: daddi r1, r0, 3
          j fin
     nor: daddi r1, r0, 2
          j fin
   infra: daddi r1, r0, 1
     fin: sd r1, estado(r0)
fintotal: halt
