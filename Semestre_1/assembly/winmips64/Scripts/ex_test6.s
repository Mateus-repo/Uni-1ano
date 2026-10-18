; ==========================================================
; Programa: conta caracteres e espacos de uma string
; ----------------------------------------------------------
; Registos:
;   r1 = endereco do CONTROL      r2 = endereco do DATA
;   r4 = carater lido (1 byte)    r5 = indice na string
;   r6 = contador de caracteres   r7 = contador de espacos
;   r8 = 32 (codigo ASCII do espaco)
;   r9, r10 = auxiliares para mostrar texto/numeros
; ==========================================================

        .data
CR:     .word32 0x10000
DR:     .word32 0x10008
STRING: .asciiz "Ola mundo bom dia"
MSGC:   .asciiz "Caracteres: "
MSGE:   .asciiz " Espacos: "

        .text
        lwu   r1, CR(r0)          ; r1 = endereco do CONTROL
        lwu   r2, DR(r0)          ; r2 = endereco do DATA

        ; --- inicializar (tudo ANTES do ciclo) ---
        daddi r5, r0, 0           ; indice = 0
        daddi r6, r0, 0           ; chars = 0
        daddi r7, r0, 0           ; espacos = 0
        daddi r8, r0, 32          ; r8 = 32 (espaco)

CICLO:
        lbu   r4, STRING(r5)      ; r4 = byte numero r5 da string
        beqz  r4, MOSTRA          ; se for 0 (\0), a string acabou: sai do ciclo

        daddi r6, r6, 1           ; chars = chars + 1

        bne   r4, r8, PROXIMO     ; se NAO e espaco, salta por cima do bloco
        daddi r7, r7, 1           ; e espaco: espacos = espacos + 1

PROXIMO:
        daddi r5, r5, 1           ; indice = indice + 1 (proximo carater)
        j     CICLO               ; volta ao topo do ciclo

MOSTRA:
        ; --- mostrar "Caracteres: " ---
        daddi r9, r0, MSGC        ; r9 = endereco do texto
        sd    r9, (r2)            ; DATA = endereco do texto
        daddi r10, r0, 4          ; codigo 4 = mostrar string
        sd    r10, (r1)           ; CONTROL = 4 -> mostra

        ; --- mostrar o numero de caracteres ---
        sd    r6, (r2)            ; DATA = chars
        daddi r10, r0, 2          ; codigo 2 = inteiro com sinal
        sd    r10, (r1)           ; CONTROL = 2 -> mostra

        ; --- mostrar " Espacos: " ---
        daddi r9, r0, MSGE
        sd    r9, (r2)
        daddi r10, r0, 4
        sd    r10, (r1)

        ; --- mostrar o numero de espacos ---
        sd    r7, (r2)            ; DATA = espacos
        daddi r10, r0, 2
        sd    r10, (r1)

        halt