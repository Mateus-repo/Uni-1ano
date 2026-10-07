	.data
CR: .word32 0x10000
DR: .word32 0x10008
MSGA: .asciiz "Introduza a: "
MSGPAR:	.asciiz "Par"
MSGIMPAR:	.asciiz "Impar"

	.text
	lwu r1, CR(r0) ; registo 1 é CR
	lwu r2, DR(r0) ; registo 2 é DR
	
	daddi r8, r0, MSGA ; Carrega a mensagem para o registo 8
	; para contexto, daddi é adicção com constante, ou seja, 
	;daddi preciso de um registo, o valor da soma 
	;(neste caso 0, porque o registo 0 é sempre E SEMPRE 0) 
	;e constante é a mensagem MSGA
	sd r8, (r2) ; Carrega a mensagem que já tá dentro do registo 8 para o endereço do registo 2, que é o DR
	; obtence o endereço de um registo ao por lo dentro de ()
	
	daddi r9, r0, 4 ; Carrega para dentro do registo 9 a soma de 0, com a constante 4
	; para CR, este valor "4" é o tipo de dados a mostrar ou pedir, 2 era num ou .word32, n tenho a certeza
	; 4 é string (.asciiz)
	; 8 pede um valor ao user pelo terminal
	sd r9, (r1) ; aqui damos store do tipo no registo 1 que é o CR, que dá trigger nele e faz aparecer no monitor o que estava dentro de DR
	
	; Vamos imaginar que DR é uma caixa onde guardamos o que queremos mostrar no terminal 
	;(assim "daddi r8, r0, MSGA | sd r8, (r2)"), já CR é uma especie de sinal, damos lhe 
	;um número especifico que define o tipo de informação dentro de DR, e ao o fazermos, 
	;é nesse momento que aparece no monitor algo, ou seja ao guardarmos em CR o tipo, é desencadeado 
	;o "print" no monitor (assim "daddi r9, r0, 4 | sd r9, (r1);")
	
	
	
	; Neste caso muda a estrutura, já que vamos pedir dado ao user, agora apenas precisamos de CR
	daddi r9, r0, 8 ; Carregamos o tipo 8 para o registo 9, o tipo 8 é pedir algo ao user pelo terminal
	sd r9, (r1) ; damos trigger ao CR, e da display do cursor a piscar a pedir algo no terminal
	ld r3, (r2) ; guardamos o dado inserido pelo user que foi guardado em DR, e o pomos no registo r3
	
	andi r4, r3, 1	; aqui comparamos se r3 é impar ou par, se for impar, r4 é 1, se não, é 0
	bnez r4, IMPAR  ; se r4 for 1, dá jump para IMPAR
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