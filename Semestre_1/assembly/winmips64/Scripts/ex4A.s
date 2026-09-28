    .data
C:  .word 0
CR: .word32 0x10000 ; Enderço de registo de controlo
DR: .word32 0x10008 ; Enderço de registo de dados

    .text ; .code
    lwu r1, CR(r0) ; Coloco em r1 o valor do controlo
    lwu r2, DR(r0) ; Coloco em r2 o valor do data
    ld r3, C(r0) ; Coloco em r3 o valor de C

    daddi r10, r0, 8 ; Coloca o valor 8 em r10 para obter do teclado

    sd r10, (r1) ; Fica á espera da introducao do valor pelo user
    ld r4, (r2) ; Obtem o valor 1 introduzido pelo teclado

    sd r10, (r1) ; fica á espera do 2 valor
    ld r5, (r2) ; Obtem o valor 2 introduzido

    dadd r3, r4, r5 ; Soma os dois valores introduzidos pelo user

    sd r3, C(r0) ; Coloca o resultado da soma em C
    
    ;Mostrar no ecra
    sd r3, (r2) ; Coloca o resultado da soma de r3 no Data register
    daddi r10, r0, 1 ; Coloca o valor 1 em r10 para depois mostrar o inteiro se
    sd r10, (r1) ; Ativa o controlo e mostra no terminal
    halt