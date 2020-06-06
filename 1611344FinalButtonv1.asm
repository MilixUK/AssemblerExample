;*********************************************************************************
	list p=16F684			; list directive to define processor
	#include <p16f684.inc>	; processor specific variable definitions
	__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT & _MCLRE_OFF & _CPD_OFF
	radix dec				; default radix is decimal
	errorlevel -302			; suppress warnings when accessing SFRs in bank 1
;****************************** Assignment Statements ****************************
COUNT1 EQU 20h	; Available GPR at address 20h used for storing COUNT1
COUNT2 EQU 21h	; Available GPR at address 21h used for storing COUNT2
;****************************** Variable Definition ****************************
	cblock 0x20
		shadow_PORTA		; shadow copy of PORTA
	endc
;******************************* #define Preprocessor statements *****************
#define TRISA_D0_D1 B'00001111'	; D0 and D1 connected between RA4 and RA5
#define TRISA_D2_D3	B'00101011'	; D2 and D3 connected between RA4 and RA2
#define TRISA_D4_D5 B'00011011'	; D4 and D5 connected between RA5 and RA2
#define TRISA_D6_D7 B'00111001'	; D6 and D7 connected between RA1 and RA2
;************************************************************************************
#define LED_D0_ON	B'00010000'	; Sending HIGH to D0
#define LED_D1_ON	B'00100000'	; Sending HIGH to D1
#define LED_D2_ON	B'00010000'	; Sending HIGH to D2
#define LED_D3_ON	B'00000100'	; Sending HIGH to D3
#define LED_D4_ON	B'00100000'	; Sending HIGH to D4
#define LED_D5_ON	B'00000100'	; Sending HIGH to D5
#define LED_D6_ON	B'00000100'	; Sending HIGH to D6
#define LED_D7_ON	B'00000010'	; Sending HIGH to D7
;****************************** Start of Program ******************************
; Initial configuration - Common for all programs for CIS018-1
	 	org    	0x000		; Processor reset vector
	 	bcf    	STATUS,RP0	; Bank 0 selected
	 	movlw	07h			; Set RA<2:0> to digital and 
	 	movwf  	CMCON0 		; Comparators turned OFF
	 	bsf    	STATUS,RP0	; Bank 1 selected
	 	clrf   	ANSEL 		; Digital I/O selected
	 	movlw	B'00111111'	; Move in W - 0x3F - Set all I/O pins as digital inputs
	 	movwf	TRISA		; Configure I/O ports		
	 	clrf	INTCON		; Disable all interrupts, clear all flags	
	 	bcf    	STATUS,RP0	; Bank 0 selected
	 	clrf	PORTA		; Clear all outputs
;*********************************************************************************
; To preload a count value; 
		
     	movlw  	0xF0
	 	movwf  	COUNT2   	

;*********************************************************************************

		bcf		STATUS,RP0		; Bank 1 selected
		clrf    shadow_PORTA    ; Initialise shadow register
LOOP    btfss   PORTA,3         ; Check if pushbutton is pressed (bit 3 of PORTA)
		goto	PB_ON			; Jump to the location to turn ON the LED
		bsf		STATUS,RP0		;
	 	movlw	TRISA_D6_D7		; Configure LEDs D6 and D7 in TRISA 
	 	movwf	TRISA
;*********************************************************************************

	 	bcf		STATUS, RP0	; Bank 0 selected
		movlw	LED_D6_ON	; Write '1' for D2 into Working Register
 	 	movwf	PORTA		; Send '1' through PORTA to light up LED D2
;*********************************************************************************

		call	DELAY
;*********************************************************************************

	 	clrf	PORTA		; Clear PORTA 
;*********************************************************************************

		call	DELAY
;*********************************************************************************

		bsf		STATUS,RP0 	; Bank 1 selected
		movlw 	TRISA_D0_D1	; Configure LEDs D0 and D1 in TRISA 
		movwf	TRISA
		bcf		STATUS, RP0	; Bank 0 selected
		movlw	LED_D1_ON	; Write '1' for D1 into Working Register
 	 	movwf	PORTA		; Send '1' through PORTA to light up LED D1
		
;*********************************************************************************

		call	DELAY
;*********************************************************************************

	 	clrf	PORTA		; Clear PORTA 
;*********************************************************************************

		call	DELAY
;*********************************************************************************

		movlw	LED_D1_ON	; Write '1' for D3 into Working Register
 	 	movwf	PORTA		; Send '1' through PORTA to light up LED D1
		
;*********************************************************************************
; 
		call	DELAY
;*********************************************************************************

	 	clrf	PORTA		; Clear PORTA 
;*********************************************************************************

		call	DELAY
;*********************************************************************************

		bsf		STATUS,RP0 	; Bank 1 selected
		movlw 	TRISA_D2_D3; Configure LEDs D2 and D3 in TRISA 
		movwf	TRISA
		bcf		STATUS, RP0	; Bank 0 selected
		movlw	LED_D3_ON	; Write '1' for D3 into Working Register
 	 	movwf	PORTA		; Send '1' through PORTA to light up LED D3
;********************************************************************************
		call	DELAY
;*********************************************************************************

	 	clrf	PORTA		; Clear PORTA 
;*********************************************************************************

		call	DELAY
;*********************************************************************************

	 
		bsf		STATUS,RP0 	; Bank 1 selected
		movlw 	TRISA_D0_D1	; Configure LEDs D0 and D1 in TRISA 
		movwf	TRISA
		bcf		STATUS, RP0	; Bank 0 selected
		movlw	LED_D1_ON	; Write '1' for D1 into Working Register
 	 	movwf	PORTA		; Send '1' through PORTA to light up LED D1
;*********************************************************************************

		call	DELAY
;*********************************************************************************

	 	clrf	PORTA		; Clear PORTA 
;********************************************************************************

		call	DELAY
;*********************************************************************************


		bsf		STATUS,RP0 	; Bank 1 selected
		movlw 	TRISA_D2_D3	; Configure LEDs D0 and D1 in TRISA 
		movwf	TRISA
		bcf		STATUS, RP0	; Bank 0 selected
		movlw	LED_D2_ON	; Write '1' for D1 into Working Register
 	 	movwf	PORTA		; Send '1' through PORTA to light up LED D1
;*********************************************************************************

		call	DELAY
;*********************************************************************************

	 	clrf	PORTA		; Clear PORTA 
;*********************************************************************************

		call	DELAY
;*********************************************************************************


		bsf		STATUS,RP0 	; Bank 1 selected
		movlw 	TRISA_D0_D1	; Configure LEDs D0 and D1 in TRISA 
		movwf	TRISA
		bcf		STATUS, RP0	; Bank 0 selected
		movlw	LED_D0_ON	; Write '1' for D1 into Working Register
 	 	movwf	PORTA		; Send '1' through PORTA to light up LED D1
;*********************************************************************************

		call	DELAY
;*********************************************************************************

	 	clrf	PORTA		; Clear PORTA 
;*********************************************************************************

		call	DELAY
		call	DELAY
		call	DELAY		
PB_OFF	movf    shadow_PORTA,w  ; copy shadow to Working register
        movwf   PORTA			; Turn OFF LED when switch is still released
		goto    LOOP			; Loop forever
; Note the construct below: Another way of turning ON LED D1
PB_ON   bsf     PORTA,5         ; Turn ON LED D1
		goto	LOOP
	
;*********************************************************************************


DELAY
LOOP1   decfsz   COUNT1,1  	; Decrement COUNT1 and skip next instruction if zero
     	goto     LOOP1     	; else loop back to LOOP1
	 	decfsz   COUNT2,1  	; Decrement COUNT2 and skip next instruction if zero
     	goto     LOOP1      ; else loop back to LOOP1
;****Both counters are zero at this point ******
	
		movlw	 0xF0	   	; CHANGED TO 1 FROM 	0xF0
		movwf	 COUNT2
		return
;*********************************************************************************
	 	end
;*********************************************************************************




