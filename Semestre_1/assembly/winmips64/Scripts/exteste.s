; =============================================================================
; exteste.s - o menor programa com saida: soma dois numeros e mostra
;
; O que este programa faz:
;   soma A (10) com B (8), e mostra 18 no terminal.
;   Nao pede nada a ninguem - os numeros estao escritos no proprio codigo.
;
; Como executar: a partir desta pasta, run.bat e escolhe o exteste.s
;
; Este ficheiro e' uma versao curta do ex3A.s, feita para se ver que
; e' o essencial: sem CR/DR nao ha ecra, e o minimo para mostrar e' um
; par de linhas - o valor no DR e o codigo no CR.
;
; -----------------------------------------------------------------------------
; O CONVENIO CR / DR (explicacao completa no ex_test4.s, linhas do topo)
; -----------------------------------------------------------------------------
;   CR = 2  mostra um inteiro COM sinal
;
; Regra: escreve-se o valor em DR, escreve-se o codigo em CR, e e' a
; escrita no CR que dispara a accao. Escrever no DR, sozinho, nao
; produz nada visivel.
; -----------------------------------------------------------------------------
;
; NOTA: este programa escreve linhas numeradas de comentario (1. DATA = o valor a
; mostrar; 2. o codigo; 3. o gatilho) em vez de um comentario ao
; lado. Serve para mostrar que a ordem tem de ser DR -> CR -> DR -> CR
; e que cada par produz UMA accao no ecra. As tres ultimas linhas
; numeradas sao o par completo; o resto e' a preparacao.

	.data
CR: .word32 0x10000
DR: .word32 0x10008
A:  .word 10
B:  .word 8
C:  .word 0
	; Tres numeros: 10, 8 e 0 (espaco para o resultado). CR e DR sao os
	; enderecos dos dois registos de hardware do simulador (0x10000 e
	; 0x10008).

	.text
	lwu r1, CR(r0)     ; r1 = endereco de CR
	lwu r2, DR(r0)     ; r2 = endereco de DR
	; lwu = load word unsigned. Carrega uma so vez; os registos r1 e r2
	; ficam com os enderecos durante o resto do programa.

	ld r3, A(r0)      ; r3 = 10
	ld r4, B(r0)      ; r4 = 8
	; ld = load doubleword: le os dois numeros da memoria.

	dadd r5, r3, r4   ; r5 = 10 + 8 = 18
	; dadd = soma de 64 bits.

	daddi r6, r5, 5   ; r6 = r5 + 5 = 23
	; Esta soma nao e' do enunciado do problema; serve so' para mostrar
	; que o daddi (soma com um numero fixo) tambem funciona com um
	; registo como primeiro operando. Se quizessemos mesmo a soma de 5,
	; este era o sitio.

	sd r6, C(r0)      ; guarda o resultado (23) na variavel C
	; sd = store doubleword: o resultado vai para a memoria, para ficar
	; guardado. Repara que isto nao mostra nada no ecra.

	sd    r6, (r2)     ; 1. DATA = r6 (o valor a mostrar)
	daddi r7, r0, 2    ; 2. r7 = 2 (codigo: inteiro com sinal)
	sd    r7, (r1)     ; 3. CONTROL = r7 -> dispara a acao

	; Estas sao as tres linhas que fazem aparecer o numero no ecra, e
	; resumem todo o protocolo:
	;
	;   1. escreve-se o valor a mostrar no DR
	;   2. escreve-se em CR o codigo que diz o que fazer com ele
	;   3. (ao escrever no CR, o passo 2, e' que a accao acontece)
	;
	; O codigo 2 quer dizer "inteiro com sinal". O codigo 1 tambem
	; serviria, porque 23 e' positivo, mas o 2 e' mais seguro: se o
	; resultado fosse negativo, o 1 ia mostrar um numero enorme em vez
	; do sinal menos.
	;
	; Sem estas tres ultimas linhas o programa nao mostrava nada, por
	; muito que fizesse a conta. Sem CR/DR nao ha ecra.

	halt              ; acaba o programa
