.module imprimir_cadena

	pantalla .equ 0xFF00

.globl imprime_cadena

imprime_cadena:
	pshs a

	recorrer_cadena:
      lda ,x+
		beq fin_recorrer_cadena
		
		sta pantalla
		;volvemos al principio del bucle
		bra recorrer_cadena
		fin_recorrer_cadena:
			;return
			puls a,PC
rts
