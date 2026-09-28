    .data
A: .word 10
B: .word 8
C: .word 0
CR: .word 32 0x10000 ; Enderço de registo de controlo
DR: .word 32 0x10008 ; Enderço de registo de dados

    .text ; .code
    lwu r1, CR(r0) ; Coloco em r1 o valor do controlo
    lwu r2, DR(r0) ; Coloco em r2 o valor do data

    ld r4, A(r0)
    ld r5, B(r0)
    dadd r3, r4, r5
    sd r3, C(r0)

    sd r3, (r2) ; Coloco o resultado da soma de r3 no Data register

    daddi r10, r0, 1 ; Coloca o valor 1 em r10 oara depois mostrar o inteiro se

    sd r10, (r1) ; Ativa o controlo e mostra no terminal o valor
    halt