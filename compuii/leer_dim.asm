.module leer_dim

	pantalla .equ 0xFF00
	teclado  .equ 0xFF02

.globl leer_dim
.globl imprime_cadena

dc: .byte 0
ud: .byte 0
;ERROR DIMENSION > 99
error_dim_99:
	.asciz "\33[31m\nError, la dimension debe ser menor a 99.\n\33[37m"

;PAUSE
pausa:
	.asciz "\33[7m\nPulse cualquier tecla para continuar...\33[0m"

leer_dim:
	ldb teclado
	stb dc
	lda #10
	mul 
	ldb teclado
	stb ud

	rts	

