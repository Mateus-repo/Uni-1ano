    .data
CR:    .word32 0x10000
DR:    .word32 0x10008
A:   .word32 0
B:   .word32 0
C:   .word32 0
Z:   .word32 0
MSGPEDEINT:   .asciiz "Escreve um inteiro: "

    .text
    lwu  r1, CR(r0)        ; r1 = endereço do CONTROL (global)
    lwu  r2, DR(r0)        ; r2 = endereço do DATA (global)

    MAIN:
        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, 0, 4
        sd r9, (r1)

        daddi r9, 0, 8
        sd r9, (r1)
        ld r3, (r2) ; A

        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, 0, 4
        sd r9, (r1)

        daddi r9, 0, 8
        sd r9, (r1)
        ld r4, (r2) ; B

        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, 0, 4
        sd r9, (r1)

        daddi r9, 0, 8
        sd r9, (r1)
        ld r5, (r2) ; Z

        dadd r6, r3, r4
        dsub r7, r6, r5
    END:
        halt