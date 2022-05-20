.module leer_dim

	teclado  .equ 0xFF02

.globl leer_dim


num1: .byte 0
num2: .byte 0

leer_dim:
	lda teclado
	suba #48
	sta num1
	lda teclado
	suba #48
	sta num2

	ldb #10
	lda num1
	mul
	addb num2
	

	rts	

