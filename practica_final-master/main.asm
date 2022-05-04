.module main
	;Constantes
	fin      .equ 0xFF01
	pantalla .equ 0xFF00
	teclado  .equ 0xFF02
	;pilaU	   .equ 0xF000
	pilaS	   .equ 0xE000

.globl imprime_cadena
.globl leer_dim
.globl leer_mat

;VACIAR PANTALLA
limpiar_pantalla:
	.asciz "\33[2J"

;MENU PRINCIPAL
imp_menu_principal:
	.ascii "\33[36m\n"
	.ascii "*-----------------------------------------*\n"
	.ascii "* Manejo de una matriz de N x M elementos *\n"
	.ascii "*-----------------------------------------*\n"
	.ascii "\n"
	.ascii "0) Introducir dimensiones de la matriz\n"
	.ascii "1) Leer el contenido de la matriz(Numeros de 3 cifras)\n"
	.ascii "2) Mostrar la matriz por pantalla\n"
	.ascii "3) Salir\33[37m\n"

	.asciz "Elige opcion: "

imp_menu_dim:
	.ascii "\33[36m\n"
	.ascii "Introducir dimensiones\n"
	.asciz "Filas x Columnas\33[37m\n"
imp_intr_fil:
	.asciz "Filas: "
imp_intr_col:
	.asciz "Columnas: "
;ERROR ELECCION NO VALIDA
error_seleccion_imprimir:
	.asciz "\33[31m\nError:Valor no permitido\n\33[37m"

;ERROR MATRIZ VACIA
error_mat_vacia:
	.asciz "\33[31m\nError, matriz vacia.\n\33[37m"

;ERROR NUMERO > 999
error_numero_999:
	.asciz "\33[31m\nError, numero mayor a 999.\n\33[37m"

;PAUSE
pausa:
	.asciz "\33[7m\nPulse cualquier tecla para continuar...\33[0m"


;variables
columnas: .byte 0
filas: .byte 0
matriz: .byte 0

programa:
	;cargamos las pilas en direcciones seguras
	;ldu #pilaU
	lds #pilaS
	;imprimimos menu
menu:
	ldx #limpiar_pantalla
	jsr imprime_cadena
	ldx #imp_menu_principal
	jsr imprime_cadena
	lda teclado
	cmpa #0 ;introducir dimensiones
		beq intr_dimensiones
	cmpa #1 ;rellenar matriz
		beq	rellenar_matriz
	cmpa #2 ;mostrar matriz
		beq mostrar_matriz
	cmpa #3 ; salir
		beq acabar

	error_menu_seleccion:
	ldx #error_seleccion_imprimir
	jsr imprime_cadena
	ldx #pausa
	jsr imprime_cadena
	lda teclado

		bra menu

;INTRODUCIR DIMENSIONES
intr_dimensiones:
	ldx #limpiar_pantalla
	jsr imprime_cadena
	ldx #imp_menu_dim
	jsr imprime_cadena
	ldx #imp_intr_fil	
	jsr imprime_cadena
	jsr leer_dim
	stb filas
	ldx #imp_intr_fil
	jsr imprime_cadena
	jsr leer_dim
	stb columnas

	bra menu
;RELLENAR MATRIZ
rellenar_matriz:
	ldx #limpiar_pantalla
	jsr imprime_cadena
	jsr leer_dim

	bra menu

;MOSTRAR MATRIZ
mostrar_matriz:
	ldx #limpiar_pantalla
	jsr imprime_cadena

	bra menu
acabar:
			clra
			sta fin
			.area FIJA(ABS)
			.org 0xFFFE ;vector de RESET
			.word programa 

;COLORES
;Para el color rojo: \33[31m
;Para el color verde: \33[32m
;Para el color amarillo: \33[33m
;Para el color azul: \33[34m
;Para el color magenta: \33[35m
;Para el color cyan: \33[36m
;Para el color blanco: \33[37m
;EFECTOS
;Para la negrita: \33[1m
;Para el subrayado: \33[4m
;Para deshacer negrita y subrayado: \33[0m
