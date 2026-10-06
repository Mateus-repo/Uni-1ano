    .data
CR: .word32 0x10000
DR: .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGB: .asciiz "Introduza b: "
MSGR: .asciiz "Resultado: "

    .text
	lwu r1, CR(r0)
	lwu r2, DR(r0)
	daddi r6, r0, MSGA
	sd r6, (r2)
	daddi r7, r0, 4
	sd r7, (r1)
	daddi r7, r0, 8
	sd r7, (r1)
	ld r3, (r2)
	daddi r6, r0, MSGB
	sd r6, (r2)
	daddi r7, r0, 4
	sd r7, (r1)
	daddi r7, r0, 8
	sd r7, (r1)
	ld r4, (r2)
	
	dsub r5, r3, r4
	daddi r6, r0, MSGR
	sd r6, (r2)
	daddi r7, r0, 4
	sd r7, (r1)
	
	sd r5, (r2)
	daddi r7, r0, 2
	sd r7, (r1)
	halt