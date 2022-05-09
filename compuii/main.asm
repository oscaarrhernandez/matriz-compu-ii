.module main
	;Constantes
	fin      .equ 0xFF01
	pantalla .equ 0xFF00
	teclado  .equ 0xFF02
	pilaS	   .equ 0xE000

.globl imprime_cadena
.globl leer_dim
.globl leer_mat

;variables
columnas: .byte 0
filas: .byte 0
matriz: .byte 0

imp_dim:
	.asciz "Introduce filas x columnas\n"
fil:
.asciz "Introduce filas:"

col:
.asciz "\nIntroduce columnas:"

programa:
	;cargamos las pilas en direcciones seguras
	lds #pilaS

	ldx #imp_dim
	jsr imprime_cadena
     ldx #fil
     jsr imprime_cadena
     jsr leer_dim
     std filas 
     ldx #col
     jsr imprime_cadena 
     jsr leer_dim
     std columnas
     


acabar:
			clra
			sta fin
			.area FIJA(ABS)
			.org 0xFFFE ;vector de RESET
			.word programa 

