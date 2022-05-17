.module leer_num

	teclado  .equ 0xFF02

temp: .word 0


.globl leer_num



leer_num:
	lda teclado
	suba #'0
	ldb #100
	mul
	std temp
	lda teclado
	suba #'0
	ldb #10
	mul
	addd temp
	std temp
	ldb teclado
	subb #'0
	clra
	addd temp
	std temp
	
	rts	

