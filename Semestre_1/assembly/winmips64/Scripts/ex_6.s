    .data
CR:   .word32 0x10000
DR:   .word32 0x10008
MsgTentativa: .asciiz "Tentativa: "
MsgParabens: .asciiz "Parabéns! Acertou!"
MsgMaior: .asciiz "O segredo é maior. Tente de novo. \n\n"
MsgMenor: .asciiz "O segredo é menor. Tente de novo. \n\n"
MsgPedeSegredo: .asciiz "Jogador 1, introduza o numero secreto: "
MsgJogador2: .asciiz "Jogador 2, tente adivinhar o numero secreto: "

; Index de registros
; R1 : CR
; R2 : DR
; R3 : NTENTATIVAS
; R4 : SEGREDO
; R5 : TENTATIVA
; R6 : ACERTOU
; R7 : TEMP
; R10 ; VALOR PARA O CR
; R11 ; ENDEREÇO DA STRING PARA I/O

    .text
    lwu r1, CR(r0)         ; r1 = endereço do CONTROL
    lwu r2, DR(r0)         ; r2 = endereço do DATA

    MAIN:
        ; obter segredo
        ; ler e guardar o segredo
        ; limpar o terminal
        ; pedir ao user 2 para começar a tentar adivinhar o segredo

        ; ---- ler segredo ----
        daddi r8, r0, MsgPedeSegredo
        sd r8, (r2)
        daddi r9, r0, 4         ; código 4 = mostrar string
        sd r9, (r1)

        daddi r9, r0, 8         ; código 8 = ler do teclado
        sd r9, (r1)
        ld r4, (r2)             ; r4 = segredo
        sd r4, Segredo(r0)
    END:
        halt