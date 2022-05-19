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
aux: .byte 0
cont: .byte 0
salto: .byte 0
marco:
	std sumaExt
	sta filas
	stb columnas
	ldy #m
	ldb #columnas
	lslb
	incb
	incb
	clra
	leay d,y; en y tenemos ya la mat[1][1]
	clrb
	ldb filas
	decb
	decb
	stb aux
	ldb columnas
	decb
	decb
	stb salto
	bucle:
	ldb cont
	cmpb aux
	bhs exit
	
	ldd #0
	ldd ,y++
	addd sumaInt
	std sumaInt
	
	ldb salto
	clra
	leay d,y
	clrb	
	
	ldd #0
	ldb cont
	incb
	std cont
	bra bucle
	
	
exit:
	ldd sumaExt
	subd sumaInt
	std sumaExt
	jsr imprimir_num
	ldd sumaInt
	jsr imprimir_num
	

rts 
