	.data
A:	.word 10
B:	.word 8
C:	.word 0
	.text
	
main:
	ld r4, A(R0)
	ld r5, B(R0)
	dadd r3, r4, r5
	sd r3, C(R0)
	halt