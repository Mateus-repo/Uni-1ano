; =============================================================================
; ex_test4.s - par ou impar
;
; O que este programa faz:
;   1. mostra "Introduza a: " no terminal
;   2. le um numero inteiro que o utilizador escreva
;   3. descobre se esse numero e' par ou impar
;   4. imprime "Par" ou "Impar" (sem ponto final, para se ver que a
;      string e' a mesma nos dois ramos)
;
; Como executar: a partir desta pasta, run.bat e escolhe o ex_test4.s.
; (o run.bat monta com asm.exe e abre o winmips64 sem argumentos)
;
; -----------------------------------------------------------------------------
; O CONVENIO CR / DR - le isto uma vez, vale para todos os ficheiros
; -----------------------------------------------------------------------------
; O simulador nao tem chamadas ao sistema. Nao existe "print" nem "scanf".
; Em vez disso existem dois registos de hardware com nomes proprios, que se
; escrevem como se fossem memoria normal:
;
;   CR (CONTROL, 0x10000) - o "gatilho". E' o registo que manda.
;   DR (DATA,    0x10008) - a "caixa de carga". E' o registo que transporta.
;
; A regra e' sempre a mesma, e tem duas partes:
;
;   1) escreve-se o valor em DR
;   2) escreve-se em CR um numero que diz O QUE fazer com o que esta' em DR
;
; E' o passo 2 que dispara a accao. Ou seja: escrever em DR nao produz nada
; visivel sozinho; so quando se escreve em CR e' que o terminal reage. E por
; isso que CR tem de ficar sempre em CR e DR em DR - se trocares os dois, o
; programa "funciona", o assembler nao complains, e nao aparece nada.
;
; Os codigos do CR (a lista completa esta' no ISET.TXT, na pasta de cima):
;
;   CR = 1  mostra em DR um inteiro SEM sinal
;   CR = 2  mostra em DR um inteiro COM sinal (serve para numeros negativos)
;   CR = 3  mostra em DR um real (double)
;   CR = 4  mostra a string cujo ENDERECO esta' em DR
;   CR = 5  desenha um pixel (cor em DATA, x em DATA+5, y em DATA+4)
;   CR = 6  limpa o terminal
;   CR = 7  limpa o ecra' grafico
;   CR = 8  le um numero do teclado para DR
;   CR = 9  le um byte do teclado, sem eco
;
; Repara na diferenca entre o 1 e o 2: os dois mostram um inteiro, o 1
; interpreta os 64 bits como "de 0 a 2^64-1" e o 2 como "de -2^63 a 2^63-1".
; Como o que lemos do teclado pode ser negativo, o 2 e' o certo para
; numeros e o 1 da' resultados esquisitos em valores grandes.
;
; E' o 4 que tem a armadilha: em DR nao vai o texto, vai o ENDERECO do
; texto. E' a diferenca entre "o que mostrar" e "onde esta' o que mostrar".
; Para os numeros (1, 2, 3) em DR vai mesmo o numero.
; -----------------------------------------------------------------------------

	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGPAR:	.asciiz "Par"
MSGIMPAR:	.asciiz "Impar"

; -----------------------------------------------------------------------------
; As tres mensagens sao .asciiz, e nao .ascii, por causa do zero no fim.
; O simulador precisa de saber onde acaba a string, e esse zero e' o que
; marca o fim. Sem ele, ao mostrar a string ele continua a ler memoria a
; seguir e imprime lixo ate encontrar um zero por acaso.
; (o .ascii existe para casos em que se quer controlar os bytes a mao,
;  como no ex_test5.s, em que o \r e' escrito a parte com .byte)
; -----------------------------------------------------------------------------

	.text
; r1 vai guardar o endereco do CR e r2 o do DR, e ficam assim para sempre.
; Nao vale a pena voltar a carrega-los. E' a mesma logica do "guarda o
; rato de uma vez" - carrega-se o endereco, e usa-se o registo.
; O (r0) no fim e' o endereco base: em MIPS os enderecos sao "endereco +
; deslocamento", e o r0 vale sempre 0, portanto (r0) e' o endereco e ponto.
;
; lwu = load word unsigned. Traz 32 bits (por isso "w" e nao "d"), e
; unsigned (por isso o "u"), para nao dar problemas com o bit do sinal.
; Nao usamos lw porque os enderecos 0x10000 e 0x10008, lidos como 32 bits
; com sinal, seriam negativos e davam a volta.
	lwu r1, CR(r0) ; registo 1 e' CR
	lwu r2, DR(r0) ; registo 2 e' DR

	daddi r8, r0, MSGA ; Carrega a mensagem para o registo 8
	; para contexto, daddi e' adiccao com constante, ou seja,
	;daddi preciso de um registo, o valor da soma
	;(neste caso 0, porque o registo 0 e' sempre E SEMPRE 0)
	;e constante e' a mensagem MSGA
	; o nome "daddi" diz as tres coisas: d = 64 bits (doubleword),
	; add = soma, i = imediato (o segundo operando e' um numero, nao um
	; registo). E' "somar r0 com o endereco da mensagem", que da' o
	; endereco. Podia usar lui + ori mas aqui o numero cabe em 16 bits.
	sd r8, (r2) ; Carrega a mensagem que ja ta dentro do registo 8 para o endereco do registo 2, que e' o DR
	; obtence o endereco de um registo ao por lo dentro de ()
	; o nome "sd" e' store doubleword: guarda os 64 bits de r8 no
	; endereco que esta' dentro de r2. Repara que o endereco da string
	; NAO vai para a memoria - vai para o registo de hardware DR.
	; O texto em si continua parado em MSGA, na .data.

	daddi r9, r0, 4 ; Carrega para dentro do registo 9 a soma de 0, com a constante 4
	; para CR, este valor "4" e' o tipo de dados a mostrar ou pedir.
	; a lista completa esta' no ISET.TXT, e o que interessa aqui:
	; 2 mostra um inteiro com sinal (o que vale para numeros negativos)
	; 4 mostra a string cujo endereco esta' em DR (.asciiz)
	; 8 pede um valor ao utilizador pelo terminal
	; (1 seria inteiro sem sinal, 3 real, 6 limpar terminal,
	;  9 ler um caracter sem eco - nenhum destes serve aqui)
	sd r9, (r1) ; aqui damos store do tipo no registo 1 que e' o CR, que da trigger nele e faz aparecer no monitor o que estava dentro de DR

	; Vamos imaginar que DR e' uma caixa onde guardamos o que queremos mostrar no terminal
	;(assim "daddi r8, r0, MSGA | sd r8, (r2)"), ja CR e' uma especie de sinal, damos lhe
	;um numero especifico que define o tipo de informacao dentro de DR, e ao o fazermos,
	;e' nesse momento que aparece no monitor algo, ou seja ao guardarmos em CR o tipo, e' desencadeado
	;o "print" no monitor (assim "daddi r9, r0, 4 | sd r9, (r1);")
	; so para deixar isto bem assente: e' por isso que a ordem conta.
	;DR primeiro, CR depois. Se inverter, o CR dispara com o que estivesse
	;em DR de uma operacao anterior, e o que acabamos de escrever em DR
	;fica a espera do proximo gatilho. E' um bug que nao dá erro nenhum.

	; Neste caso muda a estrutura, ja que vamos pedir dado ao user, agora apenas precisamos de CR
	; e por isso que nao ha "sd" a escrever nada em DR: o DR nao precisa de
	;preparacao nenhuma. O CR sozinho, com o codigo 8, ja faz o trabalho todo -
	;e' o simulador que escreve o que o utilizador teclar directamente no DR.
	daddi r9, r0, 8 ; Carregamos o tipo 8 para o registo 9, o tipo 8 e' pedir algo ao user pelo terminal
	sd r9, (r1) ; damos trigger ao CR, e da display do cursor a piscar a pedir algo no terminal
	ld r3, (r2) ; guardamos o dado inserido pelo user que foi guardado em DR, e o pomos no registo r3
	; ld = load doubleword, o inverso do sd: agora em vez de guardar,
	;vamos buscar. E' o "ld r3, (r2)" que vai buscar a 0x10008 e traz o
	;que o utilizador escreveu.
	; Repara no par CR=8 seguido de ld: este e' o unico sitio do programa
	;onde a ordem CR -> DR se inverte, porque aqui o CR e' que escreve no
	;DR. Nos outros casos o CR so le o que lhe pomos no DR.

	; --- agora a parte de verdade: descobrir se o numero e' par ou impar ---
	;
	; A ideia e' olhar so para o ultimo bit do numero, o das unidades.
	; Qualquer numero em binario acaba em 0 ou em 1:
	;   0 1  1 0 1 0   -> as unidades sao 0, logo e' par
	;   1 1  1 0 1 1   -> as unidades sao 1, logo e' impar
	; Como 1 e' o unico bit que sobrevive a um "and com 1", a conta e'
	; o suficiente: nao precisamos de comparar o numero todo.
	andi r4, r3, 1	; aqui comparamos se r3 e' impar ou par, se for impar, r4 e' 1, se nao, e' 0
	; andi = and immediate: um "e" bit a bit, com a constante 1.
	; r4 fica a zero se o ultimo bit de r3 for 0, e a 1 se for 1.
	; Nota: e' um "e" e nao um "e' igual a": nao estamos a comparar r3 com 1,
	; estamos a ver que bits de r3 sobrevivem. Por isso funciona para
	; qualquer r3, e nao so para 0 e 1.
	bnez r4, IMPAR  ; se r4 for 1, da jump para IMPAR
	; bnez = branch if not equal to zero. E um salto condicional: se r4
	; for diferente de zero, salta para IMPAR; se for zero, segue em
	; frente. Traduzido para C seria "if (r4 != 0) goto IMPAR;".
	; (e o mesmo mecanismo que o if/else do ex_test3.s, so que aqui o
	;  "if" e' o caminho que salta e o "else" e' a queda natural - e
	;  por isso que o bloco PAR esta' logo a seguir, sem nenhum jump)

	PAR:
	; Este bloco so e' alcancado quando r4 == 0, ou seja, quando o numero
	; e' par. E' o "else" do if, escrito como queda natural.
	daddi r8, r0, MSGPAR
	sd r8, (r2)         ; DATA = endereco da string "Par"
	daddi r9, r0, 4     ; CR = 4 (mostrar string)
	sd r9, (r1)         ; dispara a saida
	j FIM               ; salta para o fim, para nao cair no bloco de baixo
	; Este j e' obrigatorio. Sem ele, a execucao acabava o bloco PAR,
	; caia no bloco IMPAR, e imprimia "ParImpar" - os dois textos sempre
	; juntos. E' o mesmo cuidado que o "j FIM" do if/else no ex_test3.s:
	; um ramo tem sempre de saltar por cima do outro.

	IMPAR:
	; Este bloco so e' alcancado pelo bnez de cima, ou seja, quando o
	; numero e' impar. Repara que NAO ha um j a seguir - a proxima
	; instrucao ja e' o FIM, por isso nao ha nada para saltar.
	daddi r8, r0, MSGIMPAR
	sd r8, (r2)         ; DATA = endereco da string "Impar"
	daddi r9, r0, 4     ; CR = 4 (mostrar string)
	sd r9, (r1)         ; dispara a saida
	; Repara que o codigo e' igual ao do bloco PAR, so muda a string.
	; Em assembly acaba por ser assim: nao ha funcoes nem variaveis, entao
	; repetir as tres linhas e' a forma normal de escrever. Se os blocos
	; ficassem enormes, ai sim valia a pena fazer uma subroutine.

	FIM:
	; Os rotulos (PAR:, IMPAR:, FIM:) nao ocupam espaco nem fazem nada:
	; sao apenas nomes que o assembler transforma em enderecos, para o
	; bnez e o j poderem saltar para ca. E' assim que se faz "if/else"
	; em MIPS - nao ha instrucao de "se" com bloco, so ha saltos.
	halt                ; termina o programa
	; halt para o simulador. Sem isto, depois da ultima instrucao o
	; programa continuava a ler o que estivesse a seguir na memoria,
	; a correr sem parar. E' o equivalente ao return final do C.

; -----------------------------------------------------------------------------
; Porque e' que este ficheiro e' o mais comentado dos outros:
; ele e' o unico que tem o enunciado completo do CR/DR em comentacao, e
; os restantes ficheiros desta pasta remetem para ca em vez de repetir.
; Se um dia apagares este ficheiro, os outros perdem a explicacao - por
; isso convem nao mexer nesta secao sem a levar com o resto.
; -----------------------------------------------------------------------------
