        .data
CR:     .word32 0x10000
DR:     .word32 0x10008
msg:    .asciiz "Ola mundo\n"
pede:   .asciiz "Escreve um inteiro: "

        .text
MAIN:
        lwu   r1, CR(r0)        ; r1 = endereço do CONTROL (global)
        lwu   r2, DR(r0)        ; r2 = endereço do DATA (global)

        ; mostrar string
        daddi r4, r0, 4         ; r4 = tipo (4 = string)
        daddi r5, r0, pede      ; r5 = endereço da string
        jal   IO

        ; ler inteiro
        daddi r4, r0, 8         ; r4 = tipo (8 = ler inteiro)
        jal   IO                ; resultado volta em r6
        dadd  r7, r0, r6        ; guardar o valor lido em r7

        ; mostrar inteiro com sinal
        daddi r4, r0, 2         ; tipo 2 = inteiro com sinal
        dadd  r5, r0, r7        ; valor a mostrar
        jal   IO

        ; mostrar outra string
        daddi r4, r0, 4
        daddi r5, r0, msg
        jal   IO

END:
        halt

; ---------------------------------------------
; IO: função multi-uso
; entrada: r4 = tipo, r5 = valor / endereço
; saída:   r6 = valor lido (só para tipos de leitura)
; usa globais: r1 = CONTROL, r2 = DATA
; ---------------------------------------------
IO:
        sd    r5, 0(r2)         ; DATA = valor/endereço
        sd    r4, 0(r1)         ; CONTROL = tipo (executa a operação)
        ld    r6, 0(r2)         ; DATA = resultado (útil nas leituras)
        jr    r31               ; voltar