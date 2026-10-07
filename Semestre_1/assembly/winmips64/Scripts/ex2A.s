; =============================================================================
; ex2A.s - trocar os valores de duas variaveis
;
; O que este programa faz:
;   A tem 10 e B tem 8 no inicio.
;   No fim, A tem 8 e B tem 10. Os dois valores trocaram de lugar.
;
; Como executar: a partir desta pasta, run.bat e escolhe o ex2A.s
;
; -----------------------------------------------------------------------------
; PORQUE E' QUE ISTO E' MAIS COMPLICADO DO QUE PARECE
; -----------------------------------------------------------------------------
; A grande diferenca entre assembly e o resto das linguagens: aqui nao ha
; variaveis. Nao se pode escrever "A = B" e pronto, a troca acontece,
; porque A e' um ENDERECO na memoria, e nao um nome que o computador
; conheca. O que o computador faz e' copiar o valor que esta' num sitio
; para outro sitio.
;
; E' o problema classico da troca. Se se fizesse assim:
;
;     sd r4, B(r0)     ; B passa a valer 10 (o antigo valor de A)
;     sd r5, A(r0)     ; A passa a valer 8 (o antigo valor de B)
;
; a segunda linha copia o valor de r5 para A. Mas o r5 foi posto para o
; registo ANTES, e se escrever-mos em B antes, o valor de A original
; ja nao esta' la - ja foi sobrescrito. O resultado seria A=8 e B=8:
; o 10 desapareceu.
;
; A solucao e' o que este programa faz: guardar um dos valores num
; registo que nao seja A nem B antes de mexer em qualquer um deles.
; Como os registos sao tres (r3, r4, r5) e os valores sao dois, ha
; sempre um registo de sobra para servir de "caixa temporaria".
; -----------------------------------------------------------------------------

	.data
A:  .word 10
B:  .word 8
	; A e' 10, B e' 8. No fim deste programa, A tem de passar a ter 8 e
	; B tem de passar a ter 10.

	.text
main:
	ld r4, A(r0)     ; r4 = 10 (valor inicial de A)
	ld r5, B(r0)     ; r5 = 8  (valor inicial de B)
	; ld = load doubleword: le 64 bits da memoria para um registo.
	; Os valores 10 e 8 sao copiados para r4 e r5 ANTES de mexer em
	; qualquer coisa na memoria. E' este o ponto do programa.

	dadd r3, r4, r0  ; r3 = r4 + 0 = 10 (guarda A numa "caixa" a parte)
	dadd r4, r5, r0  ; r4 = r5 + 0 = 8  (prepara o valor de B)
	dadd r5, r3, r0  ; r5 = r3 + 0 = 10 (o valor de A, tirado da caixa)
	; Estas tres linhas sao o coracao do programa. Repara que nenhuma toca
	; na memoria - sao apenas registos a passar valores uns para os
	; outros.
	; dadd r3, r4, r0 quer dizer "r3 = r4 + r0", e como o r0 e' sempre 0
	; o resultado e' simplesmente r4. Traduzindo para C, cada uma destas
	; linhas seria "int r3 = r4;", "int r4 = r5;" e "int r5 = r3;".
	; Somar o r0 e' a forma de "copiar" um registo. Existe o "move" como
	; pseudo-instrucao em MIPS, mas o winmips64 nao a lista no ISET.TXT,
	; e somar o zero resulta sempre e resulta em todo o lado.
	; O truque do r3 e' o seguinte: r3 e' a "caixa temporaria". Copia-se
	; A para la, para se ter o valor do A seguro, e depois usa-se essa
	; copia para repor o valor de A no fim. Sem o r3 a troca nao
	; funcionaria, como se explica no bloco de comentacao de cima.

	sd r4, B(r0)     ; guarda r4 (8) em B. Agora B = 8, que ja era o valor.
	sd r5, A(r0)     ; guarda r5 (10) em A. Agora A = 10, que era o de B.
	; Estes sd sao as duas ultimas instrucoes que mexem na memoria. E so
	; agora e' seguro escrever: os dois valores estao salvos nos registos,
	; portanto pode-se sobrescrever A e B sem perder nada.
	; (o sd e' store doubleword: copia um registo para a memoria, o
	;  inverso do ld)

	halt              ; acaba o programa
	; Para verificar que a troca funcionou, no simulador ver os valores
	; de A e B depois desta linha - A tem de ser 8 e B tem de ser 10.
