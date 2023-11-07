        .data
base:   .double 5.85
altura: .double 13.47
res:    .double 0.0

     .code
     l.d f1, base(r0)
     l.d f2, altura(r0)
     mul.d f3, f1, f2
     daddi r1, r0, 2
     mtc1 r1,f4
     cvt.d.l f4,f4
     div.d f5, f3, f4
     s.d f5, res(r0)
     halt
