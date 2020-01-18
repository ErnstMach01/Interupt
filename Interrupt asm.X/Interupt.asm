; PIC16F690 Configuration Bit Settings
; ASM source line config statements
#include "p16F690.inc"

; CONFIG
; __config 0xF0D4
 __CONFIG _FOSC_INTRCIO & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF

    
    cblock 0x20
wStore
sStore
    endc
    
    org 0
reset:
	goto		intialize

interrupt:
    org 4
    goto	    isr
    
intialize:
    bsf		    STATUS
    clrf	    TRISC
    movlw	    0xFF
    movwf	    TRISA
    bsf		    IOCA,5
    bcf		    STATUS, RP0
    clrf	    PORTA
    clrf	    PORTC
    movlw	    B'10001000'
    movwf	    INTCON
    
    ;main loop clears LED
    
    main:
    
	clrf	    PORTC
	;more code here
	goto	    main
	
;interrrupt routing, turns on all LEDS
	
isr:
    
	movwf		wStore
	movf		STATUS,w
	movwf		sStore
	
	movlw		0xFF
	movwf		PORTC
	movf		PORTA, 0
	
	movf		sStore,w
	movwf		STATUS
	swapf		wStore,f
	swapf		wStore,w
	bcf		INTCON, RABIF
	retfie