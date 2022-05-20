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
comp : .byte 0
maximos: .asciz "\n Maximos: "
cadenapos: .asciz "\nFila-Columna-> "
posic: .byte 0 
posif: .byte 0 ; = filaobj

maximo:
	ldy #m

	sta columnas
	stb filaobj
	stb posif
	subb #1
	stb filamenos1
	ldx #maximos
	jsr imprime_cadena
	;columnas x 2 x (filaobj-1)
	ldb columnas
	lslb
	clra
	lda filamenos1	
	mul
	std inicio
	leay d,y
	clra clrb
	ldd ,y
	std maximo
	buclefila:
		ldd ,y++
		std comp
		ldb c
		cmpb columnas
		beq fin_fila
		addb #1
		stb c
		ldd maximo
		cmpd comp
		blo cambiarmaximo
		bra buclefila

cambiarmaximo:
	ldd comp
	std maximo
	ldb c
	subb #1
	stb posic
	bra buclefila 

fin_fila:
ldb #0
stb c
clra clrb
ldd maximo
jsr imprimir_num
;;;; comprobar a partir de aqui
masmaximos:
	ldy #m
	ldd inicio
	leay d,y
	clra clrb
	bfila:
	ldb c	
	cmpb columnas
	beq fin
	ldd ,y++
	std comp
	ldd maximo
	cmpd comp
	beq imppos
	sig:
	ldb c
	addb #1
	stb c
	bra bfila

imppos:
	ldx #cadenapos
	jsr imprime_cadena
	clra clrb
	ldb posif
	jsr imprimir_num
	clra clrb
	ldb c
	jsr imprimir_num
	bra sig

fin:
rts
