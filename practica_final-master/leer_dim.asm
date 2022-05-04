.module leer_dim

	pantalla .equ 0xFF00
	teclado  .equ 0xFF02

.globl leer_dim
.globl imprime_cadena

dim: .byte 0

;ERROR DIMENSION > 99
error_dim_99:
	.asciz "\33[31m\nError, la dimension debe ser menor a 99.\n\33[37m"

;PAUSE
pausa:
	.asciz "\33[7m\nPulse cualquier tecla para continuar...\33[0m"

leer_dim:
	ldb teclado
	stb dim
	cmpb #99
	bge error
	rts	
error:
	ldx #error_dim_99
	jsr imprime_cadena
	ldx #pausa
	jsr imprime_cadena
