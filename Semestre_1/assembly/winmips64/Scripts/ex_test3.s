	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGB: .asciiz "Introduza B: "
MSGI: .asciiz "Iguais!"
MSGM: .asciiz "O maior e: "
	
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
	
	daddi r8, r0, MSGB
	sd r8, (r2)
	daddi r9, r0, 4
	sd r9, (r1)
	
	daddi r9, r0, 8
	sd r9, (r1)
	ld r4, (r2)
	
	bne r3, r4, Else
		daddi r8, r0, MSGI
		sd r8, (r2)
		daddi r9, r0, 4
		sd r9, (r1)
	j FIM
	Else:
		slt r6, r3, r4
		bezq
		daddi r8, r0, MSGM
		sd r8, (r2)
		daddi r9, r0, 4
		sd r9, (r1)
		
		sd r5, (r2)
		daddi r9, r0, 2
		sd r9, (r1)
	FIM: 
	halt