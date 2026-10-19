    .data
CR: .word32 0x10000
DR: .word32 0x10008

    .text
    lwu r1, CR(r0)         ; r1 = endereço do CONTROL
    lwu r2, DR(r0)         ; r2 = endereço do DATA
    MAIN:

    sd r3, (r1)
    ld r6, (r2)             ; r6 = P


    Diferentes:

    daddi r3, r0, 4
    daddi r4, r0, MsgOMaior
    sd r4, (r2)
    sd r3, (r1)

    dadd r7, r5, r0
    slt r3, r5, r6
    beq r3, r0, MaxA
    dadd r7, r6, r0

    MaxA:

        dadd r3, r0, 2
        sd r7, (r2)
        sd r3, (r1)
    END:
        halt
