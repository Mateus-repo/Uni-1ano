    .data
CR:   .word32 0x10000
DR:   .word32 0x10008
P: .word 0
Q: .word 0
R: .word 0
T: .word 0
M: .word 0
N: .word 0
F: .word 0
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
        ld r4, (r2)          ; r4 = P
        sd r4, P(r0)

        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4         ; código 4 = mostrar string
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r5, (r2)          ; r5 = Q
        sd r5, Q(r0)

        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4         ; código 4 = mostrar string
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r6, (r2)          ; r6 = R
        sd r6, R(r0)

        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4         ; código 4 = mostrar string
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r7, (r2)          ; r7 = T
        sd r7, T(r0)

        dadd r3, r4, r5
        sd r3, M(r0)
        dadd r3, r6, r7
        sd r3, N(r0)

        dsub r3, M(r0), N(r0)
        sd r3, F(r0)

        dadd r3, r0, M(r0)
        sd N(r0), M(r0)
        sd r3, N(r0)

        daddi r9, r0, 2         ; código 2 = inteiro com sinal

        ld r8, F(r0)
        sd r8, (r2)
        sd r9, (r1)

        ld r8, M(r0)
        sd r8, (r2)
        sd r9, (r1)

        ld r8, N(r0)
        sd r8, (r2)
        sd r9, (r1)
    END:
        halt