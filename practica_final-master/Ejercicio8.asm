.area PROG (ABS)

        ; definimos una constante
fin     .equ 0xFF01
pantalla .equ 0xFF00

	.org 0x100
tempb :.byte 0x0000
	

	.globl programa
programa:
        ldd #468 ; un numero como cualquier otro, para probar
        
        tfr d,x
        cmpd #800
        blo Menor800
        clrb
        incb
        stb tempb
        tfr x,d
        subd #800
        tfr d,x
        
        
Menor800:ldb tempb
	lslb
	stb tempb
	tfr x,d
        cmpd #400
        blo Menor400
        ldb tempb
        incb
        stb tempb
        tfr x,d
        subd #400
        tfr d,x
        
        
Menor400:ldb tempb
	lslb
	stb tempb
	tfr x,d
        cmpd #200
        blo Menor200
        ldb tempb
        incb
        stb tempb
        tfr x,d
        subd #200
        tfr d,x
        
        
Menor200:ldb tempb
	lslb
	stb tempb
	tfr x,d
        cmpd #100
        blo Menor100
        ldb tempb
        incb
        stb tempb
        tfr x,d
        subd #100
        tfr d,x
        
        
Menor100:
	ldb tempb
	addb #'0
        stb pantalla
        
        
        
        
        ; segunda cifra.
        tfr x,d
        tfr b,a
        clrb
        cmpa #80
        blo Menor80
        incb
        suba #80
Menor80:lslb
        cmpa #40
        blo Menor40
        incb
        suba #40
Menor40:lslb
        cmpa #20
        blo Menor20
        incb
        suba #20
Menor20:lslb
        cmpa #10
        blo Menor10
        incb
        suba #10
Menor10:addb #'0
        stb pantalla
        adda #'0
        sta pantalla

        ; imprimimos un salto de lInea
        ldb #'\n
        stb pantalla

        ; imprimimos un salto de lInea
        ldb #'\n
        stb pantalla

        ; el programa acaba
        clra
	sta fin

	.org 0xFFFE	; vector de RESET
	.word programa