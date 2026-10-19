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

        daddi r8, r0, S
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r8, r0, D
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r8, r0, X
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r8, r0, Y
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r8, r0, W
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)
    END:
        halt