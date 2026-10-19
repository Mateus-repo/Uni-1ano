    .data
CR: .word32 0x10000
DR: .word32 0x10008
X: .word 0
Y: .word 0
W: .word 0
S: .word 0
D: .word 0
MSGPEDEINT: .asciiz "Escreve um inteiro: "

    .text
    lwu r1, CR(r0)         ; r1 = endereço do CONTROL
    lwu r2, DR(r0)         ; r2 = endereço do DATA
    MAIN: 
        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4         ; código 4 = mostrar string
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r4, (r2)          ; r4 = X
        sd r4, X(r0)

        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r5, (r2)          ; r5 = Y
        sd r5, Y(r0)

        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r6, (r2)          ; r6 = W
        sd r6, W(r0)

        dadd r7, r4, r5
        dadd r7, r7, r6
        sd r7, S(r0)

        dsub r7, r4, r6
        sd r7, D(r0)

        dadd r3, r4, r0 ; r3 = X
        dadd r4, r5, r0 ; r4 = Y
        dadd r5, r6, r0 ; r5 = W
        dadd r6, r3, r0 ; r6 = X
        sd r4, X(r0)
        sd r5, Y(r0)
        sd r6, W(r0)

        ; ---- mostrar S (sem sinal, código 1) ----
        ld    r8, S(r0)
        sd    r8, (r2)
        daddi r9, r0, 1 ; código 1 = inteiro sem sinal
        sd    r9, (r1)

        ; ---- mostrar D (com sinal, código 2) ----
        ld    r8, D(r0)
        sd    r8, (r2)
        daddi r9, r0, 2 ; código 2 = inteiro com sinal
        sd    r9, (r1)

        ; ---- mostrar X (já rodado) ----
        ld    r8, X(r0)
        sd    r8, (r2)
        sd    r9, (r1)          ; r9 continua a ser 2

        ; ---- mostrar Y ----
        ld    r8, Y(r0)
        sd    r8, (r2)
        sd    r9, (r1)

        ; ---- mostrar W ----
        ld    r8, W(r0)
        sd    r8, (r2)
        sd    r9, (r1)
    END:
        halt