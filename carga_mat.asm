.module carga_mat

	pantalla .equ 0xFF00
	teclado  .equ 0xFF02
	m .equ 0xE000

.globl carga_mat
.globl leer_num
.globl imprimir_num
.globl imprime_cadena
.globl imp_mat

tempb : .word 0
tam: .word 0
contador: .word 0
contfilas: .word 0
contcol: .word 0
numero: .word 0
columnas: .byte 0
filas: .byte 0
dato: .asciz"\nDato: "

carga_mat:
	ldy #m
	std tam
	ldd #0
	std contador
	;mientras contador != tam	
buclecarga:
	ldx #dato
	jsr imprime_cadena
	jsr leer_num
	std ,y++
	
	ldd contador
	addd #1
	std contador						
	cmpd tam
	bne buclecarga					
rts

imp_mat:
	ldy #m
	sta filas
	stb columnas
	clra
	clrb
buclefilimp:
	ldb contfilas
	cmpb filas
	bge fin_filas
	ldb #0
	stb contcol
	buclecolimp:
		ldb contcol
		cmpb columnas
		bge fin_col
		clrb
		ldb #'\t
		stb pantalla
		ldd #0
		ldd ,y++
		jsr imprimir_num
		ldd #0
		ldb contcol
		incb 
		stb contcol
		bra buclecolimp
	fin_col:
	clrb
	ldb #'\n
	stb pantalla
	
	ldb contfilas
	incb
	stb contfilas
	bra buclefilimp
	fin_filas:
	ldb #0
	stb contfilas
	ldb #0
	stb contcol

	
rts	
	
