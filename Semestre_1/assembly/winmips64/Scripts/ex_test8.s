    .data
CR:   .word32 0x10000
DR:   .word32 0x10008
A:    .word 0
B:    .word 0
Z:    .word 0
C:    .word 0
MSGPEDEINT: .asciiz "Escreve um inteiro: "

    .text
    lwu  r1, CR(r0)         ; r1 = endereço do CONTROL
    lwu  r2, DR(r0)         ; r2 = endereço do DATA

MAIN:
    ; ---- ler A ----
    daddi r8, r0, MSGPEDEINT
    sd    r8, (r2)
    daddi r9, r0, 4         ; código 4 = mostrar string
    sd    r9, (r1)

    daddi r9, r0, 8         ; código 8 = ler do teclado
    sd    r9, (r1)
    ld    r4, (r2)          ; r4 = A
    sd    r4, A(r0)

    ; ---- ler B ----
    daddi r8, r0, MSGPEDEINT
    sd    r8, (r2)
    daddi r9, r0, 4
    sd    r9, (r1)
    
    daddi r9, r0, 8
    sd    r9, (r1)
    ld    r5, (r2)          ; r5 = B
    sd    r5, B(r0)

    ; ---- ler Z ----
    daddi r8, r0, MSGPEDEINT
    sd    r8, (r2)
    daddi r9, r0, 4
    sd    r9, (r1)
    
    daddi r9, r0, 8
    sd    r9, (r1)
    ld    r6, (r2)          ; r6 = Z
    sd    r6, Z(r0)

    ; ---- C = A + B - Z ----
    dadd  r7, r4, r5
    dsub  r7, r7, r6
    sd    r7, C(r0)

    ; ---- trocar A e B (r3 = auxiliar) ----
    dadd  r3, r4, r0        ; r3 = A
    dadd  r4, r5, r0        ; r4 = B
    dadd  r5, r3, r0        ; r5 = A antigo
    sd    r4, A(r0)         ; A = B antigo
    sd    r5, B(r0)         ; B = A antigo

    ; ---- mostrar C (com sinal) ----
    daddi r9, r0, 2         ; código 2 = inteiro com sinal
    sd    r7, (r2)
    sd    r9, (r1)

    ; ---- mostrar A (já trocado) ----
    sd    r4, (r2)
    sd    r9, (r1)

    ; ---- mostrar B (já trocado) ----
    sd    r5, (r2)
    sd    r9, (r1)

END:
    halt