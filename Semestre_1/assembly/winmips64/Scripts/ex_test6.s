    .data
CR: .word32 0x10000
DR: .word32 0x10008
STRING: .asciiz "Ola mundo bom dia"

    .text
    lwu r1, CR(r0)     ; r1 = endereco do registo CR (0x10000)
    lwu r2, DR(r0)     ; r2 = endereco do registo
    MAIN:
        daddi r8, r0, STRING   ; r8 = endereco da string
        daddi r5, r0, 0           ; r5 = indice (comeca em 0)
        lbu   r4, STRING(r5)      ; r4 = byte numero r5 da string