		.module practicaFinal

		; definimos una constante

pantalla 	.equ 0xFF00
fin     	.equ 0xFF01
teclado	.equ 0xFF02
pilaU	.equ 0xF000
pilaS	.equ 0xFF00
matriz	.equ 0xE000

		; variables del programa

		; cadenas como variables
bienvenida:	.asciz "\nPROGRAMA QUE ADIVINA SI UNA MATRIZ INTRODUCIDA POR TECLADO ES MARCO\n"
separacion:	.asciz "\n===================================================================\n" 
nombres:	.asciz "          Jesus Sanchez Salinero && Alejandro Sanchez Sanchez        \n"
inst_inicial:	.asciz "\nIntroduzca las dimensiones de la matriz:\n"
inst_fil:		.asciz "\n - Introduca el numero de filas de la matriz (xxx) :    "
inst_col:		.asciz "\n - Introduza el numero de columnas de la matriz (xxx) : "
inst_fil_col:	.asciz "\n\nLas dimensiones de la matriz introducidas son:		"
inst_tam:		.asciz "\n\nEl tamagno del vector es:		"
inst_inicio_scan:	.asciz "\nIntroduzca los elementos de la matriz a continuacion: \n"
inst_mostrar:	.asciz "\n\nLa matriz introducida por el usuario es: \n"
sol_si_marco:	.asciz "\n =·= LA MATRIZ INTRODUCIDO SI ES UNA MATRIZ MARCO =·= \n"
sol_no_marco:	.asciz "\n =·= LA MATRIZ INTRODUCIDA NO ES UNA MATRIZ MARCO =·= \n"
inst_scan:	.asciz "\n    Introduzca el elemento ("




nFil:		.byte 0
nCol:		.byte 0
tam:			.word 0
numero_dos_cifras:	.byte 0
numero_tres_cifras: .word 0
contador_fil:		.byte 0
contador_col:		.byte 0
sumaTotal:		.word 0

		.globl programa
		.globl imprime_cadena
		.globl imprime_numero_dos_cifras
		.globl imprime_numero_tres_cifras
		.globl leer_numero_dos_cifras
		.globl leer_numero_tres_cifras

		; comenzamos el programa principal
programa:
        	lds #pilaS			
		

		ldx #bienvenida	; cargamos cadena de bienvenida en x
		jsr imprime_cadena	; llamamos a la subrutina para que imprima la cadena
		ldx #separacion	; cargamos cadena de separacion en x
		jsr imprime_cadena	; llamamos a la subrutina para que imprima la cadena
		ldx #nombres		; cargamos la cadena de nombres en x
		jsr imprime_cadena	; llamamos a la subrutina para que imprima la cadena	
		ldx #separacion	; cargamos cadena de separacion en x
		jsr imprime_cadena	; llamamos a la subrutina para que imprima la cadena

		ldx #inst_inicial	; cargamos la cadena de instruccion inicial en x
		jsr imprime_cadena	; llamamos a la subrutina para que imprima la cadena




		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FILAS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		ldx #inst_fil		; cargamos cadena de instruccion filas en x
		jsr imprime_cadena	; llamamos a la subrutina para que imprima la cadena

		
		jsr leer_numero_tres_cifras	; llamamos a subrutina para que lea numero de 3 cifras (fil)
		stb nFil	; cargamos n_Fil desde b
		jsr imprime_numero_tres_cifras
		
		
		

		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;COLUMNAS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		ldx #inst_col		; cargamos cadena de instruccion filas en x
		jsr imprime_cadena	; llamamos a la subrutina para que imprima la cadena

		
		jsr leer_numero_tres_cifras	; llamamos a subrutina para que lea numero de 3 cifras (fil)
		stb nCol	; cargamos nCol desde b
		jsr imprime_numero_tres_cifras

		
		;;;;; MOSTRAMOS POR PANTALLA LAS DIMENSIONES INTRODUCIDAS Y EL TAMAÑO DEL VECTOR;;;
		
		ldx #inst_fil_col
		jsr imprime_cadena
		
		ldd #0
		ldb nFil
		jsr imprime_numero_tres_cifras
		ldb #'x
		stb pantalla
		ldd #0
		ldb nCol
		jsr imprime_numero_tres_cifras
		
		ldx #inst_tam
		jsr imprime_cadena
		
		
		lda nFil
		ldb nCol
		mul
		std tam
		ldd tam
		jsr imprime_numero_tres_cifras
		
		ldb #'\n
		stb pantalla
		
		
		;;;; CARGA DE LA MATRIZ ;;;;
		ldx #inst_inicio_scan
		jsr imprime_cadena

		ldy #matriz
buc_scan_fil:
		ldb contador_fil
		cmpb nFil
		bge fin_scan ; si es mayor que nFil salto a fin_scan
		; principio cuerpo del bucle_scan_fil

		ldb #0			; por cada iteración del bucle de las filas pongo el variable del
		stb contador_col	; bucle de columnas a cero

		buc_scan_col:
				ldb contador_col
				cmpb nCol
				bge fin_buc_scan_col	; si es mayor que nCol salto a fin_buc_scan_col
				; principio cuerpo del bucle_scan_col
				; \nIntroduzca el elemento (fff,ccc):\t
				ldx #inst_scan					; "\n Introduzca el elemento ("
				jsr imprime_cadena
				ldd #0
				ldb contador_fil				; "fff"
				jsr imprime_numero_tres_cifras
				clrb
				ldb #',						
				stb pantalla					; ","
				ldd #0
				ldb contador_col				; "ccc"
				jsr imprime_numero_tres_cifras
				clrb
				ldb #')						
				stb pantalla					; ")"
				ldb #':						
				stb pantalla					; ":"
				ldb #'\t						
				stb pantalla					; "\t"

				; almaceno el número leido
				ldd #0
				jsr leer_numero_tres_cifras
				std ,y++

				; sumo los números y los almaceno en sumaTotal
				addd sumaTotal
				std sumaTotal


				ldd #0

				; fin cuerpo del bucle_scan_col
				ldb contador_col
				incb
				stb contador_col
				bra buc_scan_col
		fin_buc_scan_col:

		; fin cuerpo del bucle_scan_fil
		ldb contador_fil
		incb
		stb contador_fil
		bra buc_scan_fil

fin_scan:	
		; reinicio las variables	
		ldb #0
		stb contador_fil
		ldb #0
		stb contador_col
		bra mostrar_matriz

mostrar_matriz:
		;;;; MOSTRAR LA MATRIZ ;;;;
		ldx #inst_mostrar
		jsr imprime_cadena

		ldy #matriz
buc_print_fil:
		ldb contador_fil
		cmpb nFil
		bge fin_print ; si es mayor que nFil salto a fin_scan
		; principio cuerpo del bucle_scan_fil

		ldb #0			; por cada iteración del bucle de las filas pongo el variable del
		stb contador_col	; bucle de columnas a cero

		buc_print_col:
				ldb contador_col
				cmpb nCol
				bge fin_buc_print_col	; si es mayor que nCol salto a fin_buc_scan_col
				; principio cuerpo del bucle_scan_col
				
				clrb
				ldb #'\t						
				stb pantalla					; "\t"

				; muestro el número leido
				ldd #0
				ldd ,y++
				jsr imprime_numero_tres_cifras
				ldd #0
				
				; fin cuerpo del bucle_scan_col
				ldb contador_col
				incb
				stb contador_col
				bra buc_print_col
		fin_buc_print_col:

		clrb
		ldb #'\n						
		stb pantalla					; "\n"

		; fin cuerpo del bucle_scan_fil
		ldb contador_fil
		incb
		stb contador_fil
		;ldd #0
		bra buc_print_fil

fin_print:	
		; reinicio las variables	
		ldb #0
		stb contador_fil
		ldb #0
		stb contador_col






		ldb #'\n
        	stb pantalla
		ldd sumaTotal
		jsr imprime_numero_tres_cifras
















acabar:
        	; imprimimos un salto de lInea
       	ldb #'\n
        	stb pantalla

        	; el programa acaba
       	clra
       	clrb
       	ldd #'0
		sta fin
		
		
		.area FIJA (ABS)
		.org 0xFFFE	; vector de RESET
		.word programa
