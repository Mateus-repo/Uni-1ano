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
        ; ---- ler P ----
        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4         ; código 4 = mostrar string
        sd r9, (r1)

        daddi r9, r0, 8         ; código 8 = ler do teclado
        sd r9, (r1)
        ld r4, (r2)             ; r4 = P
        sd r4, P(r0)

        ; ---- ler Q ----
        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r5, (r2)             ; r5 = Q
        sd r5, Q(r0)

        ; ---- ler R ----
        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r6, (r2)             ; r6 = R
        sd r6, R(r0)

        ; ---- ler T ----
        daddi r8, r0, MSGPEDEINT
        sd r8, (r2)
        daddi r9, r0, 4
        sd r9, (r1)

        daddi r9, r0, 8
        sd r9, (r1)
        ld r7, (r2)             ; r7 = T
        sd r7, T(r0)

        ; ---- M = P + Q ; N = R + T ----
        dadd  r10, r4, r5       ; r10 = M
        sd    r10, M(r0)
        dadd  r11, r6, r7       ; r11 = N
        sd    r11, N(r0)

        ; ---- F = M - N ----
        dsub  r12, r10, r11
        sd    r12, F(r0)

        ; ---- trocar M e N (r3 = auxiliar) ----
        dadd  r3, r10, r0       ; r3 = M
        dadd  r10, r11, r0      ; r10 = N
        dadd  r11, r3, r0       ; r11 = M antigo
        sd    r10, M(r0)        ; M = N antigo
        sd    r11, N(r0)        ; N = M antigo

        ; ---- mostrar F, M, N (código 2) ----
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