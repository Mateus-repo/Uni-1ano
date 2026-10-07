; =============================================================================
; ex_test5.s - contar de 1 ate n, com validacao do numero
;
; O que este programa faz:
;   1. pede "um numero positivo"
;   2. se for <= 0, mostra "Tente novamente" e volta a pedir
;   3. se for > 0, conta e mostra 1, 2, 3, ... ate esse numero
;
; Este e' o primeiro programa com um CICLO (loop). A ideia e' a mesma de
; qualquer linguagem: um bloco de codigo que se repete enquanto uma
; condicao for verdadeira. Aqui o "voltar atras" faz-se com o j.
;
; Como executar: a partir desta pasta, run.bat e escolhe o ex_test5.s
;
; -----------------------------------------------------------------------------
; O CONVENIO CR / DR (explicacao completa no ex_test4.s, linhas do topo)
; -----------------------------------------------------------------------------
;   CR = 2  mostra um inteiro com sinal
;   CR = 4  mostra a string cujo endereco esta' em DR
;   CR = 6  limpa o terminal
;   CR = 8  le um numero do teclado para DR
;
; Regra: escreve-se em DR, escreve-se o codigo em CR, e a escrita no CR
; e' que dispara a accao.
; -----------------------------------------------------------------------------
;
; NOTA sobre o loop: o programa mostra cada numero COLADO no seguinte
; (1 2 3 4...), porque ao mostrar um inteiro o simulador nao acrescenta
; automaticamente uma quebra de linha. O "1" gruda no "2", o "2" gruda
; no "3", e assim por diante. Nao e' um bug do codigo - e' o
; comportamento do terminal. Para por cada numero numa linha, era
; preciso mandar um "\n" no sitio certo (por exemplo mostrar uma string
; "\n" com CR=4 entre os numeros, ou usar CR=4 com uma string que
; acabe em \n). Como aqui nao se mostra nenhuma string entre os
; numeros, ficam todos na mesma linha. Nao e' nenhum erro - e' apenas
; a forma como o CR=2 mostra inteiros.

	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGNUM: .asciiz "Escreva um numero positivo: "
MSGERRO: .ascii "Tente novamente"
         .byte 13, 0
	; A MSGERRO e' diferente das outras duas, e vale a pena entender por
	; que. As outras sao .asciiz, que e' o mesmo que .ascii mais um zero
	; no fim. Aqui escrevemos a string com .ascii e depois acrescentamos
	; dois bytes a mao com .byte:
	;     13  - e' o codigo do "carriage return" (CR), o caracter que
	;           manda o cursor voltar ao inicio da linha. Em notacao
	;           normal escreveriamos "\r".
	;      0  - e' o zero que termina a string, o mesmo que o .asciiz
	;           acrescentaria sozinho.
	; Ou seja: .ascii + .byte 13,0 e' equivalente a escrever
	; "Tente novamente\r" com .asciiz. O 13 e' a unica razao de se usar
	; .ascii - para ter o "\r" antes do zero, sem alterar o resto do
	; mecanismo. (O "\n" - newline, codigo 10 - tambem serve; o 13 e' o
	; que se usou aqui.)
	; Se o zero do fim faltasse, o simulador ia continuar a ler a memoria
	; a seguir a seguir a string e mostrar lixo.

	.text
	lwu r1, CR(r0)     ; r1 = endereco do registo CR (0x10000)
	lwu r2, DR(r0)     ; r2 = endereco do registo DR (0x10008)

MAIN:
	daddi r8, r0, MSGNUM   ; r8 = endereco de "Escreva um numero positivo: "
	sd r8, (r2)            ; DR = esse endereco
	daddi r9, r0, 4        ; r9 = 4 -> mostrar string
	sd r9, (r1)            ; CR = 4 -> mostra a pergunta

	daddi r9, r0, 8        ; r9 = 8 -> ler do teclado
	sd r9, (r1)            ; CR = 8 -> espera pela pessoa
	ld r3, (r2)            ; r3 = o numero que escreveu
	; Este MAIN e' um rotulo (um nome para um endereco), e existe
	; precisamente porque o bloco de Erro volta aqui com um j. Sem o
	; rotulo, o j nao teria para onde saltar.

	slti r4, r3, 1         ; r4 = 1 se n < 1
	; slti = set if less than immediate: o mesmo slt mas a comparar com
	; um numero fixo (1) em vez de outro registo. O resultado em r4 e'
	; 1 se n < 1, ou seja, se n for 0 ou negativo.
	bnez r4, ERRO            ; se n <= 0, erro
	; Se o numero for invalido, salta para o bloco ERRO. Se for valido,
	; nao salta e segue em frente. Repara que a comparacao e' com 1 e nao
	; com 0: e' porque queremos apanhar tanto o 0 como os negativos
	; (n < 1), e nao so' o zero.

	daddi r5, r0, 1          ; i = 1 (fora do ciclo)
	; Este i tem de estar inicializado ANTES do ciclo comecar. O i e' o
	; contador, e vai contar 1, 2, 3... Um ciclo precisa sempre de duas
	; coisas definidas antes de comecar: o contador (i) e o limite (r3,
	; o n que a pessoa escreveu). Se o i nao existisse aqui, o programa
	; nao saberia por onde comecar a contar.

FUNCAO:
	slt r6, r3, r5           ; r6 = 1 se n < i
	; CONDICAO DO CICLO, no topo. "Se n < i, ja acabamos." Como o i
	; comeca em 1 e vai subindo, quando o i passa o n, isto passa a ser
	; verdade e saltamos para fora.
	bnez r6, FIM             ; se i > n, acabou
	; bnez salta se r6 for diferente de zero, ou seja, se n < i. Quando
	; isso acontece saltamos para FIM, que esta' DEPOIS do ciclo - e assim
	; a execucao salta para fora do bloco, como um "break".
	; Este teste esta' NO TOPO do ciclo (testa antes de executar), e nao
	; em baixo - ao contrario do que se faria em C com um while. Em MIPS o
	; "voltar atras" faz-se com o j, que sempre salta para o topo, por
	; isso a forma natural e' testar no topo. (Em C com while, testa-se
	; em cima; com do-while, em baixo.)

	sd r5, (r2)              ; DATA = i
	daddi r9, r0, 2
	sd r9, (r1)              ; mostra i (CR=2, inteiro com sinal)
	; Aqui DR leva o valor em si (o i), nao um endereco, e o CR=2 diz
	; "mostra este inteiro". Repara que como i comeca em 1 e so' cresce,
	; e' sempre positivo, por isso CR=1 tambien funcionaria - mas 2 e'
	; mais seguro e mais correto em geral.

	daddi r5, r5, 1          ; i = i + 1
	; O incremento do contador. E' ESSENCIAL: sem esta linha, o i nunca
	; mudava, a condicao "n < i" nunca passava a ser verdadeira, e o
	; programa entrava em ciclo infinito a mostrar o mesmo numero. E o
	; erro classico de esquecer esta linha.

	j FUNCAO                 ; volta ao topo
	; O j salta para o topo do ciclo (o rotulo FUNCAO). Como o i ja foi
	; incrementado, o teste do topo vai passar um degrau a cada volta.
	; Este j e' o "volta para o inicio do while" em MIPS.
	; (o nome do rotulo e' FUNCAO mas devia chamar-se LOOP ou CICLO -
	;  nao e' uma funcao, e' o inicio de um ciclo. O nome engana.)

ERRO:
	daddi r9, r0, 6
	sd r9, (r1)            ; limpa o terminal (CR=6)
	; Limpa o ecra antes de mostrar o erro, para a pessoa nao ficar com a
	; pergunta antiga por cima. O CR=6 e' "clear terminal".

	daddi r8, r0, MSGERRO
	sd r8, (r2)            ; DR = endereco de "Tente novamente\r"
	daddi r9, r0, 4        ; r9 = 4 -> mostrar string
	sd r9, (r1)            ; CR = 4 -> mostra a mensagem
	; A string termina em \r (o byte 13), por isso depois de mostrar
	; "Tente novamente" o cursor volta ao inicio da linha - a proxima
	; coisa mostrada (a pergunta, quando voltamos a MAIN) vai por cima
	; da anterior, em vez de aparecer numa linha nova e confusa.

	j MAIN                 ; volta a pedir o numero
	; Volta ao topo do programa para tentar de novo. Repara que o
	; utilizador tem de escrever um numero NOVO - o programa nao repete
	; o valor invalido, pede outra vez.

FIM:
	; Chegou aqui quando i passou o n, ou seja, o ciclo terminou porque
	; houve uma volta a mais em vez de ter falhado a condicao.
	halt
	; Para o simulador.
