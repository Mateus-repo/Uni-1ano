	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGNUM: .asciiz "Escreva um numero positivo: "
MSGERRO: .asciiz "Tente novamente \n"

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
		ld r3, (r2)
		
		slti r4, r3, 0
		beqz r4, ERRO
		
	FUNCAO:
		daddi r5, r0, 1
		sd r5, (r2)
		daddi r9, r0, 2
		sd r9, (r1)
		beq r3, r5, FUNCAO
		j FIM
	ERRO:
		daddi r8, r0, MSGERRO
		sd r8, (r2)
		daddi r9, r0, 4
		sd r9, (r1)
		j MAIN
	FIM:
		halt

	