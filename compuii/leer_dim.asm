.module leer_dim

	pantalla .equ 0xFF00
	teclado  .equ 0xFF02

.globl leer_dim
.globl imprime_cadena

dc: .byte 0
ud: .byte 0
num : .byte 0 

leer_dim:
	lda teclado
	sta dc
	lda teclado
	ldb #10
	mul 
	std num
	lda teclado
	sta ud
	addd ud

	rts	

