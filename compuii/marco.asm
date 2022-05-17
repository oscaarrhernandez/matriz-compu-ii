.module marco

	pantalla .equ 0xFF00
	m .equ 0xE000
	
.globl marco
.globl imprime_cadena
.globl imprimir_num

interior: .word 0
exterior: .word 0
columnas: .byte 0
filas: .byte 0
filasaux: .byte 0
columnasaux: .byte 0
contfilas: .byte 0
contcol: .byte 0
secumple: .asciz "\nEs matriz Marco\n"
nosecump: .asciz "\nNo es matriz Marco\n"

marco:
; 3  5  7  9  8
; 4  9  1  2  4
; 2  3  5  1  3
; 8  2  4  1  6
; 9  1  5  7  2
	ldy #m
	sta filas
	stb columnas
	deca
	sta filasaux
	decb
	stb columnasaux
	clra
	clrb
	buclefil:
	ldb contfilas
	cmpb filas
	bge fin_marco
	buclecol:
		ldb contcol
		cmpb columnas
		bge fin_col
		lda contfilas
		cmpa #0
		beq sumint
		cmpa filasaux
		beq sumint
		cmpb #0
		beq sumint
		cmpb columnasaux
		beq sumint
		ldd #0
		ldd ,y++
		addd exterior
		std exterior
		
		ldd #0
		ldb contcol
		incb 
		stb contcol
		bra buclecol
	fin_col:
		clrb
		ldb contfilas
		incb
		stb contfilas
		bra buclefil

sumint:
	ldd #0
	ldd ,y++
	addd interior
	std interior
		

	
fin_marco:
	ldb interior
	jsr imprimir_num
	ldb exterior
	jsr imprimir_num
	lda interior
	cmpa #exterior
	bgt nosecumple
	ldx #secumple
	jsr imprime_cadena
	rts
	
nosecumple:
	ldx #nosecump
	jsr imprime_cadena
rts

