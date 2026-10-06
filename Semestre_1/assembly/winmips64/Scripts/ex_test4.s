	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGPAR:	.asciiz "Par"
MSGIMPAR:	.asciiz "Impar"

	.text
	lwu r1, CR(r0)
	lwu r2, DR(r0)
	
	daddi r8, r0, MSGA
	sd r8, (r2)
	daddi r9, r0, 4
	sd r9, (r1)
	
	daddi r9, r0, 8
	sd r9, (r1)
	ld r3, (r2)
	
	andi r4, r3, 1	
	bnez r4, IMPAR
	PAR:
		daddi r8, r0, MSGPAR
		sd r8, (r2)
		daddi r9, r0, 4
		sd r9, (r1)
		j FIM
	IMPAR:
		daddi r8, r0, MSGIMPAR
		sd r8, (r2)
		daddi r9, r0, 4
		sd r9, (r1)
		
	FIM:
		halt