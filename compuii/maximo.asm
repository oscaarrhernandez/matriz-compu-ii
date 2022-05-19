.module maximo

	pantalla .equ 0xFF00
	teclado  .equ 0xFF02
	m .equ 0xE000
.globl maximo
.globl imprimir_num
.globl imprime_cadena
filaobj: .byte 0
columnas: .byte 0
inicio: .byte 0
filamenos1: .byte 0
c: .byte 0
maximos: .asciz "\n Maximos: "
maximo:
	ldy #m

	stb filaobj
	subb #1
	stb filamenos1
	sta columnas
	ldx #maximos
	jsr imprime_cadena
	;columnas x 2 x (filaobj-1)
	ldb columnas
	lslb
	lda filamenos1
	mul
	clra
	std inicio
	leay d,y
	clra clrb
	buclefila:
		ldd ,y++
		std maximo
		ldb c
		cmpb columnas
		beq fin
		addb #1
		stb c
		ldd maximo
		jsr imprimir_num
		
		bra buclefila 

fin:
rts
