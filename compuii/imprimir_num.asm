.module	imprimir_num

teclado	.equ	0xFF02
pantalla	.equ	0xFF00

	.globl	imprimir_num


imprimir_num:
	pshs	x,y	

	ldx	#0x0000		; para almacenar d
	ldy	#0x0000		; para almacenar d

	; se mete la variable primera en la pila de usuario
	
	; METERLO EN UN BUCLE

	; TERCERA CIFRA	; le resta 100 en 100 hasta dar C 
primera_cifra:
	subd	#100
	bcs	imprime_primera_cifra
	exg	d,x
	incb	
	exg	d,x	
	bra	primera_cifra
imprime_primera_cifra:
	exg	d,x
	tstb	
	bne	imprime_primera
	; es 0	
	exg	d,y	
	tstb
	exg	d,y
	beq	primera_cero; si es 0 es no ha habido una cifra
imprime_primera:
	addb	#'0
	stb	pantalla
	exg	d,y
	incb
	exg	d,y
primera_cero:
	exg	d,x

	; se le añade lo que no debio de ser restado	
	addd	#100
	; contador a 0
	exg	d,x
	ldd	#0
	exg	d,x

	; CUARTA CIFRA	; le resta 10 en 10 hasta dar C 
segunda_cifra:
	subd	#10
	bcs	imprime_segunda_cifra
	exg	d,x
	incb	
	exg	d,x	
	bra	segunda_cifra
imprime_segunda_cifra:
	exg	d,x
	tstb	
	bne	imprime_segunda
	; es 0	
	exg	d,y	
	tstb
	exg	d,y
	beq	segunda_cero; si es 0 es no ha habido una cifra
imprime_segunda:
	addb	#'0
	stb	pantalla
	exg	d,y
	incb
	exg	d,y
segunda_cero:
	exg	d,x

	; se le añade lo que no debio de ser restado	
	addd	#10
	; contador a 0
	exg	d,x
	ldd	#0
	exg	d,x

	; QUINTA CIFRA	ESTARIA DIRECTAMENTE PERO POR SEGUIR
tercera_cifra:
	subd	#1
	bcs	imprime_tercera_cifra
	exg	d,x
	incb	
	exg	d,x
	bra	tercera_cifra
imprime_tercera_cifra:
	exg	d,x
	addb	#'0
	stb	pantalla
	exg	d,x
	
	
	; RETORNO
	puls 	x,y
	rts
