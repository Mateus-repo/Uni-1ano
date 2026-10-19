    .data
CR: .word32 0x10000
DR: .word32 0x10008
X: .word 0
Y: .word 0
W: .word 0
S: .word 0
D: .word 0

    .text
    lwu r1, CR(r0)         ; r1 = endereço do CONTROL
    lwu r2, DR(r0)         ; r2 = endereço do DATA
    MAIN: 

    END:
        halt