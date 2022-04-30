.module leer_dim

	pantalla .equ 0xFF00
	teclado  .equ 0xFF02

.globl leer_dim

dim .byte 0

leer_dim:
	ldb teclado
	stb dim
	cmpa #99
	bge error
	rts	
error:
	ldx #error_dim_99
	jsr imprime_cadena
	ldx #pausa
	jsr imprime_cadena
