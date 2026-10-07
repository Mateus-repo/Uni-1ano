; =============================================================================
; ex_test2.s - subtracao de dois numeros que o utilizador introduz
;
; O que este programa faz:
;   1. pede "a" e "b"
;   2. mostra "Resultado: "
;   3. mostra a - b
;
; Como executar: a partir desta pasta, run.bat e escolhe o ex_test2.s
;
; -----------------------------------------------------------------------------
; O CONVENIO CR / DR (explicacao completa no ex_test4.s, linhas do topo)
; -----------------------------------------------------------------------------
; Em resumo, porque e' a unica coisa que este programa usa:
;
;   CR = 1  mostra um inteiro sem sinal
;   CR = 2  mostra um inteiro com sinal
;   CR = 4  mostra a string cujo endereco esta' em DR
;   CR = 8  le um numero do teclado para DR
;
; E a regra de sempre: escreve-se o valor em DR, escreve-se o codigo em CR,
; e e' a escrita no CR que dispara a accao.
; -----------------------------------------------------------------------------
;
; NOTA sobre este programa: ele mostra "Resultado: " e a seguir o numero,
; sem nada entre os dois, por isso no ecra aparece "Resultado: 2" (por
; exemplo, com a=10 e b=8). Nao ha problema nenhum - as strings aqui sao
; .asciiz sem \n no fim. Se se quiser o numero noutra linha, basta
; escrever a string como "Resultado: \n".
;
; NOTA 2, e esta e' a pegadinha deste exercicio: o programa mostra
; a - b, e nao b - a. Se der -2 em vez de 2, o codigo esta' certo e
; foi a conta que se leu ao contrary. Vale a pena trocar os operandos do
; dsub para confirmar.

	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGB: .asciiz "Introduza b: "
MSGR: .asciiz "Resultado: "
; Estas tres strings sao .asciiz porque o simulador precisa do zero no
; fim para saber onde a string acaba. Sem o .asciiz, mostraria lixo a
; seguir.

	.text
	lwu r1, CR(r0)     ; r1 = endereco do registo CR (0x10000)
	lwu r2, DR(r0)     ; r2 = endereco do registo DR (0x10008)
	; Carregamos os dois enderecos uma vez so e ficamos com eles. Daqui
	; para a frente, "escrever no CR" e' "sd para (r1)" e "escrever no
	; DR" e' "sd para (r2)". Se carregassemos os enderecos a cada
	; instrucao, o programa era tres vezes mais longo sem fazer nada de
	; diferente.
	; (o (r0) no fim e' a base do endereco, e o r0 e' sempre 0, portanto
	;  e' o mesmo que escrever so CR(r0))

	; --- mostrar "Introduza a: " ---
	daddi r6, r0, MSGA   ; r6 = endereco da string "Introduza a: "
	sd r6, (r2)          ; DR = esse endereco
	daddi r7, r0, 4      ; r7 = 4 -> "mostrar string"
	sd r7, (r1)          ; CR = 4 -> mostra no terminal
	; Estes quatro passos (endereco -> DR, codigo -> CR) vao-se repetir
	; em cada mensagem. E' o par "DR entao CR" de que o ex_test4.s fala:
	; o DR sozinho nao faz nada visivel, so o CR e' que manda.

	daddi r7, r0, 8      ; r7 = 8 -> "ler do teclado"
	sd r7, (r1)          ; CR = 8 -> o simulador mostra o cursor e espera
	ld r3, (r2)          ; r3 = o numero que o utilizador escreveu
	; Repara que aqui NAO escrevemos nada no DR antes. O codigo 8 nao
	; precisa de preparo nenhum: e' o proprio CR que vai escrever no DR.
	; Por isso e' o unico sitio do programa em que a ordem CR -> DR se
	; inverte; em todo o resto e' sempre DR -> CR.

	; --- mostrar "Introduza b: " ---
	daddi r6, r0, MSGB   ; r6 = endereco da string "Introduza b: "
	sd r6, (r2)          ; DR = esse endereco
	daddi r7, r0, 4      ; r7 = 4 -> "mostrar string"
	sd r7, (r1)          ; CR = 4 -> mostra no terminal

	daddi r7, r0, 8      ; r7 = 8 -> "ler do teclado"
	sd r7, (r1)          ; CR = 8 -> espera pelo segundo numero
	ld r4, (r2)          ; r4 = o numero que o utilizador escreveu
	; a fica em r3 e b em r4. E' a unica vez que o programa precisa de
	; dois registos "ao mesmo tempo", porque e' a unica vez que ha dois
	; numeros em jogo ao mesmo tempo. Nos outros ficheiros desta pasta
	; basta um registo.

	; --- a conta ---
	dsub r5, r3, r4      ; r5 = r3 - r4, ou seja a - b
	; dsub = subtract: r5 = primeiro operando - segundo operando.
	; A ordem importa, e e' esta a que costuma dar confusao: e' a - b
	; e nao b - a. Se o resultado vier ao contrario, basta trocar r3 e r4.
	; Se a conta fosse unsigned, usava-se dsubu - a unica diferenca entre
	; os dois e' como o bit do sinal e' lido. Como o utilizador pode
	; escrever um numero negativo, o certo aqui e' o dsub normal.

	; --- mostrar o resultado ---
	daddi r6, r0, MSGR   ; r6 = endereco da string "Resultado: "
	sd r6, (r2)          ; DR = esse endereco
	daddi r7, r0, 4      ; r7 = 4 -> "mostrar string"
	sd r7, (r1)          ; CR = 4 -> mostra "Resultado: "

	sd r5, (r2)          ; DR = o valor r5 (aqui e' mesmo o numero, nao um endereco)
	daddi r7, r0, 2      ; r7 = 2 -> "mostrar inteiro com sinal"
	sd r7, (r1)          ; CR = 2 -> mostra o numero no terminal
	; Repara na diferenca para o bloco das strings: ali em DR ia o
	; ENDERECO da mensagem, e o CR=4 sabia que aquilo era um endereco.
	; Aqui em DR vai o valor em si, e o CR=2 sabe que e' um numero.
	; O DR nao tem tipo nenhum - o que diz o que ele contem e' sempre
	; o codigo que se escreve no CR a seguir.
	; E' por isso que se usa 2 e nao 1: se o resultado for negativo, o
	; codigo 1 (sem sinal) ia mostrar um numero enorme em vez do -2.
	; Se a e b forem sempre positivos, tanto 1 como 2 servem.

	halt                  ; termina o programa
