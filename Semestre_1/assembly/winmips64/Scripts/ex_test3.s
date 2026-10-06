	.data
CR:   .word32 0x10000
DR:   .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGB: .asciiz "Introduza b: "
MSGI: .asciiz "Iguais!"
MSGM: .asciiz "O maior e: "

	.text
	lwu r1, CR(r0)         ; r1 = endereco do CONTROL
	lwu r2, DR(r0)         ; r2 = endereco do DATA

	; --- pedir e ler a ---
	daddi r8, r0, MSGA
	sd r8, (r2)
	daddi r9, r0, 4
	sd r9, (r1)

	daddi r9, r0, 8
	sd r9, (r1)
	ld r3, (r2)            ; r3 = a

	; --- pedir e ler b ---
	daddi r8, r0, MSGB
	sd r8, (r2)
	daddi r9, r0, 4
	sd r9, (r1)

	daddi r9, r0, 8
	sd r9, (r1)
	ld r4, (r2)            ; r4 = b

	; --- if (a == b) ---
	bne r3, r4, Else       ; se a != b, salta para Else
		daddi r8, r0, MSGI     ; bloco "iguais"
		sd r8, (r2)
		daddi r9, r0, 4
		sd r9, (r1)
	j FIM                  ; salta por cima do Else

Else:
		daddi r8, r0, MSGM     ; mostrar "O maior e: "
		sd r8, (r2)
		daddi r9, r0, 4
		sd r9, (r1)

		slt r6, r3, r4         ; r6 = 1 se a < b, senao 0      <-- NOVO
		beqz r6, MaiorA        ; se r6 = 0, a e o maior        <-- NOVO
		dadd r5, r4, r0        ; senao b e o maior: r5 = b     <-- NOVO
		j Mostra               ;                               <-- NOVO
MaiorA:
		dadd r5, r3, r0        ; a e o maior: r5 = a           <-- NOVO
Mostra:
		sd r5, (r2)            ; DATA = o maior
		daddi r9, r0, 2
		sd r9, (r1)            ; CONTROL = 2 -> mostra o numero
FIM:
	halt