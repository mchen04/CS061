
;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Assignment name: Lab 3 ex1
; Lab section: 23
; TA: Goal, Sanchi     Montano, Westlin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000

	LD R5, DATA_PTR
	
	LDR R3, R5, #0							
	LDR R4, R5, #1	
	
	ADD R3, R3, #1						
	ADD R4, R4, #1							
	
	STR R3, R5, #0						
	STR R4, R5, #1							
	
	HALT							
	
	DATA_PTR .FILL x4000
	
	.END
	
.ORIG x4000

	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41

.END
