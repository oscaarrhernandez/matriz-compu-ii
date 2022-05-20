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
tam: .word 0
filimp: .byte 0
colimp: .byte 0
f: .byte 0
c: .byte 0
contador: .byte 0
sext: .asciz "\n SUMA EXTERIOR->  "
sint: .asciz "\n SUMA INTERIOR->  "
simarco: .asciz "\n Es matriz marco"
nomarco: .asciz "\n No es matriz marco"

marco:
	ldy #m
	sta filas
	stb columnas
	mul
	std tam
	ldd #0
	std contador
	;mientras contador != tam	
buclecarga:
	ldd #0
	ldd ,y++
	
	addd sumaExt
	std sumaExt
	
	ldd contador
	addd #1
	std contador						
	cmpd tam
	bne buclecarga					
;;;;;;;;;;;;
	
	
	ldy #m
	ldb columnas
	lslb
	incb
	incb
	clra
	leay d,y; en y tenemos ya la mat[1][1]
	ldb filas
	subb #2
	stb filimp
	clrb
	ldb columnas
	subb #2
	stb colimp
	clra clrb
	ldb #0
	buclefil:
		ldb f
		cmpb filimp
		beq fin_filas
		addb #1
		stb f 
		buclecol:
		ldb c
		cmpb colimp
		beq fin_col
		addb #1
		stb c
		ldd ,y++
		addd sumaInt
		std sumaInt
		bra buclecol
	fin_col:
		
		leay 4,y
		
		bra buclefil
	fin_filas:
		clra clrb
		ldd sumaExt
		subd sumaInt
		ldx #sext
		jsr imprime_cadena
		std sumaExt
		jsr imprimir_num
		ldx #sint
		jsr imprime_cadena
		ldd sumaInt
		jsr imprimir_num
		
		ldd sumaExt
		cmpd sumaInt
		bgt esmarco
		ldx #nomarco
		jsr imprime_cadena
		bra salir
		esmarco: 
		ldx #simarco
		jsr imprime_cadena
		salir:
		rts 
