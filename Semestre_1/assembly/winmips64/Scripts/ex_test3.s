; =============================================================================
; ex_test3.s - comparar dois numeros: iguais, ou qual e' o maior
;
; O que este programa faz:
;   1. pede a e b
;   2. se forem iguais, mostra "Iguais!"
;   3. se nao, mostra "O maior e: " seguido do maior dos dois
;
; Este e' o primeiro programa com uma decisao a serio, e por isso e' o
; ficheiro onde se ve melhor o if/else do MIPS. Em MIPS nao existe
; instrucao de "se" com bloco de codigo: existem apenas saltos
; condicionais. O if/else e' construido com eles.
;
; Como executar: a partir desta pasta, run.bat e escolhe o ex_test3.s
;
; -----------------------------------------------------------------------------
; O CONVENIO CR / DR (explicacao completa no ex_test4.s, linhas do topo)
; -----------------------------------------------------------------------------
;   CR = 2  mostra um inteiro com sinal
;   CR = 4  mostra a string cujo endereco esta' em DR
;   CR = 8  le um numero do teclado para DR
;
; Regra: escreve-se em DR, escreve-se o codigo em CR, e a escrita no CR
; e' que dispara a accao.
; -----------------------------------------------------------------------------

	.data
CR:   .word32 0x10000
DR:   .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGB: .asciiz "Introduza b: "
MSGI: .asciiz "Iguais!"
MSGM: .asciiz "O maior e: "

	.text
	lwu r1, CR(r0)         ; r1 = endereco do registo CR (0x10000)
	lwu r2, DR(r0)         ; r2 = endereco do registo DR (0x10008)

	; --- pedir e ler a ---
	daddi r8, r0, MSGA     ; r8 = endereco de "Introduza a: "
	sd r8, (r2)            ; DR = esse endereco
	daddi r9, r0, 4        ; r9 = 4 -> mostrar string
	sd r9, (r1)            ; CR = 4 -> mostra no terminal

	daddi r9, r0, 8        ; r9 = 8 -> ler do teclado
	sd r9, (r1)            ; CR = 8 -> espera pela pessoa
	ld r3, (r2)            ; r3 = a

	; --- pedir e ler b ---
	daddi r8, r0, MSGB     ; r8 = endereco de "Introduza b: "
	sd r8, (r2)            ; DR = esse endereco
	daddi r9, r0, 4        ; r9 = 4 -> mostrar string
	sd r9, (r1)            ; CR = 4 -> mostra no terminal

	daddi r9, r0, 8        ; r9 = 8 -> ler do teclado
	sd r9, (r1)            ; CR = 8 -> espera pela pessoa
	ld r4, (r2)            ; r4 = b
	; r3 fica com a, r4 com b. Sao dois registos porque sao dois numeros
	; que tem de estar disponiveis ao mesmo tempo para a comparacao.

	; --- if (a == b) ---
	bne r3, r4, Else       ; se a != b, salta para Else
	; bne = branch if not equal. Traduzido para C:
	;     if (r3 != r4) goto Else;
	; Repara na logica: o salto acontece quando a condicao do IF e'
	; FALSA. Ou seja, saltamos para o else precisamente quando a != b.
	; Se a == b, o bne nao salta e a execucao cai no bloco seguinte, que
	; e' o "then". Invertendo a leitura parece estranha, mas e' a forma
	; mais comum de escrever: "se a condicao e' falsa, salta para o
	; else, e se nao, segue em frente para o then".
	;
	; Uma alternativa seria beq r3, r4, Igual (saltar para o then), mas
	; ai era preciso um salto no fim do then para passar por cima do
	; else - dois jumps em vez de um.

		daddi r8, r0, MSGI     ; bloco "iguais"
		sd r8, (r2)            ; DR = endereco de "Iguais!"
		daddi r9, r0, 4        ; r9 = 4 -> mostrar string
		sd r9, (r1)            ; CR = 4 -> mostra "Iguais!"
	j FIM                  ; salta por cima do Else
	; Este j e' obrigatorio. Sem ele, a execucao acabava aqui, caia no
	; bloco Else e imprimia "Iguais!O maior e: ..." - os dois textos
	; seguidos. Em assembly um ramo tem sempre de saltar por cima do
	; outro, senao os doisexecutam.

Else:
	daddi r8, r0, MSGM     ; mostrar "O maior e: "
	sd r8, (r2)            ; DR = endereco da string
	daddi r9, r0, 4        ; r9 = 4 -> mostrar string
	sd r9, (r1)            ; CR = 4 -> mostra a string

	slt r6, r3, r4         ; r6 = 1 se a < b, senao 0
	; slt = set if less than. O nome e' enganador: nao salta nada, apenas
	; ESCREVE o resultado da comparacao num registo - 1 se a condicao e'
	; verdadeira, 0 se for falsa. Em C seria "int r6 = (a < b);".
	; Nao existe um "if" no MIPS, por isso a comparacao tem sempre de
	; ser separada do salto: primeiro calcula-se a resposta, depois
	; decide-se com ela.
	beqz r6, MaiorA        ; se r6 = 0, a e' o maior
	; beqz = branch if equal to zero, ou seja, salta se o registo for 0.
	; Se r6 for 0, isso significa que a condicao "a < b" era falsa, logo
	; a >= b. Como a e b sao diferentes (ja sabemos, o bne de cima
	; descartou a igualdade), a > b. Portanto a e' o maior.
	; Se r6 nao for 0, nao ha salto e a execucao cai na linha a seguir.
	dadd r5, r4, r0        ; senao b e' o maior: r5 = b
	j Mostra               ; e vai mostrar
	; dadd = soma de 64 bits. dadd r5, r4, r0 e' r0 + r4, ou seja, uma
	; forma de "copiar" r4 para r5 somando o zero. Existe o "move"
	; como pseudo-instrucao, mas o winmips64 nao a lista no ISET.TXT, e
	; somar o r0 resulta sempre.
	MaiorA:
	dadd r5, r3, r0        ; a e' o maior: r5 = a
	; Este e' o "then" da segunda decisao. Repara que o bnez de cima
	; saltou para MaiorA, por isso este bloco so e' alcancado quando a
	; nao e' menor que b. E o oposto do bloco anterior, que ficou logo
	; abaixo do salto. Entre os dois da para usar qualquer um dos dois
	; estilos - "salta para o then" ou "salta para o else" - mas num
	; programa so se usa um, para nao ficar confuso.
	; (os rotulos "MaiorA:" e "Mostra:" nao ocupam espaco nem fazem nada,
	;  sao nomes que o assembler transforma em enderecos para o salto)

Mostra:
	sd r5, (r2)            ; DATA = o maior
	daddi r9, r0, 2
	sd r9, (r1)            ; CONTROL = 2 -> mostra o numero
	; CR=2 e' "inteiro com sinal" e nao 1, porque o maior pode ser
	; negativo. Com CR=1 um valor negativo apareceria como um numero
	; enorme - e' o erro mais comum nesta parte.
	; Repara que o Show/Mostra e' um rotulo sem um j a la: a execucao
	; chega aqui de duas maneiras (saltando de MaiorA ou caindo do
	; dadd de b) e por isso o rotulo marca o ponto de encontro.

FIM:
	; Este e' o ponto de saida dos dois caminhos: o "iguais" salta para
	; aqui para nao cair no else, e o "maior" chega aqui naturalmente.
	halt
	; halt para o simulador. Todo o programa tem de acabar em halt, senao
	; continua a ler a memoria a seguir sem parar.
