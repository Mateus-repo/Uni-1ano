	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGNUM: .asciiz "Escreva um numero positivo: "
MSGERRO: .asciiz "Tente novamente "

	.text
	lwu r1, CR(r0)
	lwu r2, DR(r0)
MAIN:
	daddi r8, r0, MSGNUM
	sd r8, (r2)
	daddi r9, r0, 4
	sd r9, (r1)

	daddi r9, r0, 8
	sd r9, (r1)
	ld r3, (r2)              ; r3 = n

	slti r4, r3, 1           ; r4 = 1 se n < 1            <-- CORRIGIDO
	bnez r4, ERRO            ; se n <= 0, erro            <-- CORRIGIDO

	daddi r5, r0, 1          ; i = 1 (fora do ciclo)      <-- MOVIDO

FUNCAO:
	slt r6, r3, r5           ; r6 = 1 se n < i            <-- NOVO
	bnez r6, FIM             ; se i > n, acabou           <-- NOVO

	sd r5, (r2)              ; DATA = i
	daddi r9, r0, 2
	sd r9, (r1)              ; mostra i

	daddi r5, r5, 1          ; i = i + 1                  <-- NOVO
	j FUNCAO                 ; volta ao topo              <-- NOVO

ERRO:
	daddi r8, r0, MSGERRO
	sd r8, (r2)
	daddi r9, r0, 4
	sd r9, (r1)
	j MAIN

FIM:
	halt