.module maximo

	pantalla .equ 0xFF00
	teclado  .equ 0xFF02
	m .equ 0xE000
.globl maximo

filaobj: .byte 0
columnas: .byte 0
inicio: .byte 0
c: .byte 0
caux: .byte 0
max: .byte 0
maximo:
	ldy #m

	stb filaobj
	sta columnas

	lda columnas
	ldb filaobj
	mul
	std inicio
	clra
	clrb

	
	ldb #0
	stb c
	
	buclecol:
		ldb c
		cmpb columnas
		beq fincol
		ldd inicio
		std caux
		
	
	
	

fincol:

	clra
	clrb
rts
