    .data
CR: .word32 0x10000
DR: .word32 0x10008
msg:    .asciiz "Hello World\n"

    .text
    lwu r1, CR(r0)    
    lwu r2, DR(r0)  

    daddi r4, r0, msg   
    sd r4, (r2)            
    daddi r3, r0, 4
    sd r3, (r1)          
    halt