.module main

.globl imprime_cadena
.globl leer_dim
.globl carga_mat
.globl leer_num
.globl imprimir_num
.globl imp_mat
.globl marco
.globl maximo

	;Constantes
	fin      .equ 0xFF01
	pantalla .equ 0xFF00
	teclado  .equ 0xFF02
	pilaS	   .equ 0xFF00
	m .equ 0xE000

;variables
columnas: .byte 0
filas: .byte 0
filmax: .byte 0
elementos: .word 0
imp_dim:
	.asciz "Introduce filas x columnas\n"
fil:
.asciz "Introduce filas:"

col:
.asciz "\nIntroduce columnas:"

imp_intmat:
	.asciz "\nIntroduce elementos a la matriz"
imp_cargamat:
	.asciz "\nMatriz cargada\n"
imp_marco:
	.asciz "\nComprobar si es marco la matriz\n"
imp_max:
	.asciz "\nIntroduce fila para saber su maximo"
					
programa:
	;cargamos las pilas en direcciones seguras
	lds #pilaS

	;leer_dim
	ldx #imp_dim
	jsr imprime_cadena
	;filas
     	ldx #fil
     	jsr imprime_cadena
     	jsr leer_dim
     	stb filas
	;columnas 
     	ldx #col
     	jsr imprime_cadena 
     	jsr leer_dim
     	stb columnas
     
	;cargar_matriz
	lda filas
	ldb columnas
	mul
	std elementos
	ldx #imp_intmat
	jsr imprime_cadena
	jsr carga_mat
	ldx #imp_cargamat
	jsr imprime_cadena
	lda filas
	ldb columnas
	jsr imp_mat
	ldx #imp_marco
	jsr imprime_cadena
	lda filas
	ldb columnas
	jsr marco
	ldx #imp_max
	jsr imprime_cadena
	jsr leer_dim
	
	lda columnas
	stb filmax
	jsr maximo
	
acabar:
			clra
			sta fin
			.area FIJA(ABS)
			.org 0xFFFE ;vector de RESET
			.word programa 

