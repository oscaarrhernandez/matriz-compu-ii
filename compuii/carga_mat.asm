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
tam: .word 0;12
contador: .word 0;0
numero: .word 0
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
	ldd #0
	std contador
bucleimp:
	ldx #dato
	jsr imprime_cadena
	ldd ,y++
	jsr imprimir_num
	ldd contador
	addd #1
	std contador
	cmpd tam
	bne bucleimp	
rts	
	
