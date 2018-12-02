;
; Ejemplo con leds.asm
;
; Created: 14/07/2018 08:44:52 p. m.
; Author : dx_ch
;
; Replace with your application code

//Definiciones de constantes o registros
.def PA= r17
.def PB= r18
.def temp= r16
.def PM= r19

//Definir variables en RAM
.dseg
.org 0x100
Variable:		.byte	 1

//Definir Vectores de interrupcion
.cseg
.org $000 //0x000
rjmp		Reset


Reset:
		
		//Se configura los valores iniciales 
		//o perifericos a utilizar
		ldi temp, low(RAMEND)   //Carga el stack pointer  (INVESTIGAR)
		out SPL, temp			//Parte baja
		ldi temp, high(RAMEND)  //Carga el stack pointer  (INVESTIGAR)
		out SPH, temp			//Parte alta
		
		//Habilita puerto D como salida
		ldi temp, 255 ; 0b11111111; 0xff
		out DDRD, r16
		out PORTD, temp

		lazo_infinito:

				
				ldi temp, 0x01
				out PORTD, temp
				rcall Retardo
				
				ldi temp, 0x02
				out PORTD, temp
				rcall Retardo
				
				ldi temp, 0x04
				out PORTD, temp
				rcall Retardo
				
				ldi temp, 0x08
				out PORTD, temp
				rcall Retardo

				ldi temp, 0x10
				out PORTD, temp
				rcall Retardo
				
				ldi temp, 0x20
				out PORTD, temp
				rcall Retardo

				ldi temp, 0x40
				out PORTD, temp
				rcall Retardo
				
				ldi temp, 0x80
				out PORTD, temp
				rcall Retardo

				ldi temp, 0x40
				out PORTD, temp
				rcall Retardo
				
				ldi temp, 0x20
				out PORTD, temp
				rcall Retardo

				ldi temp, 0x10
				out PORTD, temp
				rcall Retardo
				
				ldi temp, 0x08
				out PORTD, temp
				rcall Retardo

				ldi temp, 0x04
				out PORTD, temp
				rcall Retardo

				ldi temp, 0x02
				out PORTD, temp
				rcall Retardo
					
				rjmp lazo_infinito


		Retardo:

		clr PA
		clr PM
		clr PB
		
		Compara:

		cpi PA, 0x05   ;high(1000)		//0x22
		brne IncrementaPB
		cpi PM, 0x05					//0xA4
		brne IncrementaPB
		cpi PB, 0x05  ;low(1000)		//0x11
		brne Salida
		

		IncrementaPB:

		inc PB
		cpi PB, 0
		brne Compara

		IncrementaPM:

		inc PM
		cpi PM, 0
		brne Compara
		
		IncrementaPA:
		inc PA
		cpi PA, 0
		brne Compara

		Salida:
		nop
		ret

		
