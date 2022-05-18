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
f: .byte 0
c: .byte 0
secumple: .asciz "\nEs matriz Marco\n"
nosecump: .asciz "\nNo es matriz Marco\n"

marco:
	ldy #m
	sta filas
	stb columnas
	deca
	sta filasaux
	decb
	stb columnasaux
	clra 
	clrb
	ldb #0
	stb interior
	stb exterior
	clrb
	ldb #0
	stb f
	ldb #0
	stb c
	clra
	clrb
buclefil:
	ldb f
	cmpb filas
	bhi fin_filas
	ldb #0
	stb c
	buclecolimp:
		ldb c; 0
		cmpb columnas; 8
		bge fin_col; si son iguales salta a fin_col
		clrb
		ldb f
		cmpb #0
		bge sumext
		clrb 
		ldb f
		cmpb filasaux
		bge sumext
		clrb
		ldb c
		cmpb #0
		bge sumext
		clrb 
		ldb c
		cmpb columnasaux
		bge sumext
		
		clrb
		bra sumint
		
		ldd #0
		ldb c
		incb 
		stb c
		bra buclecol
	sumext:
	ldx #0
	ldd #0
	ldd ,y++
	tfr x,d
	ldb exterior
	abx
	stx exterior
	clrb	
	ldd #0
	ldb c
	incb 
	stb c
	bra buclecol
	
	sumint:
	ldx #0
	ldd #0
	ldd ,y++
	tfr x,d
	ldb interior
	abx
	stx interior
	clrb	
	ldd #0
	ldb c
	incb 
	stb c
	bra buclecol

	fin_col:
	ldb f
	incb
	stb f
	bra buclefil
	
	fin_filas:
	ldb #0
	stb f
	ldb #0
	stb c
	
	rts

