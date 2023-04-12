;=================================================
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 23
; TA: westin and sanchit
; 
;=================================================

.ORIG x3000

	LD R5, DEC_65_PTR					
	LD R6, HEX_41_PTR	
	
	LDR R3, R5, #0							
	LDR R4, R6, #0	
	
	ADD R3, R3, #1						
	ADD R4, R4, #1							
	
	STR R3, R5, #0						
	STR R4, R6, #0							
	
	HALT							
	
	DEC_65_PTR .FILL x4000
	HEX_41_PTR .FILL x4001
	
	.END
	
.ORIG x4000

	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41

.END