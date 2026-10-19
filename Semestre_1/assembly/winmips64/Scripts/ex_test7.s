    .data
CR: .word32 0x10000
DR: .word32 0x10008

    .text
    lwu r1, CR(r0)
    lwu r2, DR(r0)
    MOSTRARSTRING:
    dadd r9, r0, r11
    sd r9, (r2)
    dadd r10, r0, 4 ; tipo = 4 (string) | tipo 8 = pedir inteiro sem sinal | tipo 2 = inteiro com sinal | tipo 1 = caracter
    sd r10, (r1)
    MAIN:

    
    END:
        halt