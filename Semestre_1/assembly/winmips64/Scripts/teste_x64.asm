; =============================================================================
; teste_x64.asm - o "Hello World" em x64, para o NASM (nao e' MIPS)
;
; O que este programa faz:
;   escreve "teste x64 ok" seguido de uma mudanca de linha na consola do
;   Windows e sai. Nao ha janela nem interface - e' consola a paciencia.
;
; Como executar: a partir desta pasta, run.bat e escolhe o teste_x64.asm.
; O run.bat reconhece que este ficheiro e' x64 (e' o unico com "syscall"),
; assembla com o nasm, liga com o gcc (ou com o ld) e corre o exe.
;
; -----------------------------------------------------------------------------
; ATENCAO: ISTE NAO E' MIPS
; -----------------------------------------------------------------------------
; Todos os outros ficheiros desta pasta sao MIPS64, para o simulador
; winmips64. Este e' x86-64, para o Windows, e assembler-se com o NASM.
; As diferencas nao sao de estilo - mudam coisas de verdade:
;
;   - Nao ha ".data" e ".text" com ponto. Aqui escreve-se "section .text"
;     e "section .data".
;   - Nao ha CR nem DR. Para escrever na consola usa-se uma chamada de
;     sistema: o par (edi, rsi, edx) com eax=1.
;   - Os registos chamam-se rax, rbx, rcx, rdx, rdi, rsi, rsp. Nao ha
;     r0, r1, r2 como no MIPS. O rdi e' o registo do primeiro argumento e
;     o rsi o do segundo - por isso sao sempre estes dois.
;   - O eax=1 aqui NAO tem nada a ver com o "CR = 1" do MIPS. Sao coisas
;     diferentes que por acaso usam o mesmo numero.
; -----------------------------------------------------------------------------
;
; "sub rsp, 40"
;   Baixa o ponteiro da pilha 40 bytes, reservando esse espaco. Aqui nao
;   se usa a pilha para nada, mas e' boa pratica reservar antes de uma
;   chamada: no Windows x64 a pilha tem de estar alinhada a 16 bytes, e
;   e' por isso que se subtraem 40 e nao, por exemplo, 32.
;
; "xor r10, r10"
;   Poe o r10 a zero. Um registo exclusive-or consigo proprio da sempre
;   zero, e' esse o truque classico para limpar um registo. Aqui o r10
;   nao e' usado a seguir - muitos exemplos comecam assim por habito.
;
; "mov edi, 1" - primeiro argumento da chamada: 1 quer dizer "saida
;   padrao", ou seja, a consola (o stdout). E' o destino da escrita.
;
; "lea rsi, [rel msg]" - segundo argumento: o endereco da mensagem.
;   "lea" significa "carrega o endereco" (load effective address) - nao
;   le da memoria, e' so' o calculo de onde a mensagem esta'. O "rel"
;   (relativo) e' preciso porque um executavel pode ser carregado em
;   qualquer sitio da memoria, e por isso o endereco da mensagem so' se
;   sabe a partir da posicao do codigo.
;
; "mov edx, msg_len" - terceiro argumento: o comprimento da mensagem, em
;   bytes. E' preciso porque a consola nao tem como adivinhar ate onde
;   vai o texto - o Windows tem de saber quantos bytes escrever.
;
; "mov eax, 1" - o codigo da chamada de sistema: 1 = "write". E' este
;   numero que diz ao Windows que operacao e' esta. No MIPS quem mandava
;   no que acontecia era o CR; aqui e' o eax.
;
; "syscall" - a chamada propriamente dita. O Windows le o codigo no eax e
;   os argumentos nos outros registos, e escreve na consola.
;
; "mov edi, 3"
; "mov eax, 60"
; "syscall"
;   Segunda chamada: 60 = "exit". O edi passa a ser o codigo de saida
;   do processo, e nao um destino de escrita - ou seja, o 3 e' o numero
;   com que o programa termina, e nao um "saida de erro". E' o
;   equivalente ao halt do MIPS, mas com um codigo de sistema em vez de
;   uma instrucao propria.
;
; -----------------------------------------------------------------------------
; "msg_len equ $ - msg"
;   "equ" vem de "equal": define um nome que vale o que esta a direita.
;   O "$" e' a posicao actual. Portanto esta linha quer dizer "o
;   comprimento de msg e' a posicao desta linha menos a posicao de msg",
;   ou seja, quantos bytes a string ocupa.
;   E' a forma classica de medir o comprimento de um texto sem contar a
;   mao. Se a mensagem mudar, o comprimento muda sozinho - e' a razao de
;   se escrever assim em vez de um "mov edx, 12" escrito a mao, que
;   passava a estar errado mal a frase mudasse.
;
; NOTA sobre "db": aqui a string e' escrita com "db" (define byte) e nao
; com o "asciiz" do MIPS. O "\n" (codigo 10) e' o mesmo "\n" do ex5A.s -
;   e' um caracter universal, nao e' do Windows. A diferenca e' que o
;   "db" NAO acrescenta zero no fim, ao contrario do "asciiz", e por isso
;   o comprimento tem de ser medido a mao - que e' o que o "equ" faz.
; -----------------------------------------------------------------------------

global main
; "global main" diz ao ligador (linker) que a funcao principal se chama
; "main". Sem esta linha o Windows nao saberia onde comecar. No MIPS nao
; ha nada disto: o simulador comeca sempre no inicio do .text.

section .text
main:
    sub rsp, 40
    xor r10, r10
    mov edi, 1
    lea rsi, [rel msg]
    mov edx, msg_len
    mov eax, 1
    syscall

    mov edi, 3
    mov eax, 60
    syscall

section .data
msg:    db 'teste x64 ok', 10
msg_len equ $ - msg
