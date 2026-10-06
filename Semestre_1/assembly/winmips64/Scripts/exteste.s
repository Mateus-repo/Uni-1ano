    .data
CR: .word32 0x10000
DR: .word32 0x10008
A:  .word 10
B:  .word 8
C:  .word 0

    .text
    lwu r1, CR(r0)
    lwu r2, DR(r0)
    ld r3, A(r0)
    ld r4, B(r0)
    dadd r5, r3, r4
    daddi r6, r5, 5
    sd r6, C(r0)
    sd    r6, (r2)     ; 1. DATA = r6 (o valor a mostrar)
    daddi r7, r0, 2    ; 2. r7 = 2 (codigo: inteiro com sinal)
    sd    r7, (r1)     ; 3. CONTROL = r7 -> dispara a acao

    halt