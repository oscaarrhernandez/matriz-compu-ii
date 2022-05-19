.module marco

	pantalla .equ 0xFF00
	m .equ 0xE000
	
.globl marco
.globl imprime_cadena
.globl imprimir_num

sumaExt: .word 0
sumaInt: .word 0
filas: .byte 0
columnas: .byte 0
filimp: .byte 0
colimp: .byte 0
f: .byte 0
c: .byte 0
marco:
	std sumaExt
	sta filas
	clra
	stb columnas
	ldy #m
	ldb columnas
	lslb
	incb
	incb
	clra
	leay d,y; en y tenemos ya la mat[1][1]
	ldb filas
	decb
	decb
	stb filimp
	clrb
	ldb columnas
	decb
	decb
	stb colimp
	
	buclefil:
		ldb f
		cmpb filimp
		bge fin_filas
		ldb #0
		stb c
		buclecol:
		ldb c
		cmpb colimp
		bge fin_col
		ldd #0
		ldd ,y++
		addd sumaInt
		std sumaInt
		jsr imprimir_num
		;ldd #0
		ldb c
		incb
		std c
		bra buclecol
	fin_col:
		clra
		ldb #0
		stb c
		ldb f
		incb 
		stb f
		ldd ,y++
		ldd ,y++
		clra clrb
		bra buclefil
	fin_filas:
		clra clrb
		ldd sumaExt
		subd sumaInt
		std sumaExt
		jsr imprimir_num
		ldd sumaInt
		jsr imprimir_num
		
	

rts 
