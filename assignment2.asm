;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: 23
; TA: Goal, Sanchi     Montano, Westlin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here

; Instructions

; Output prompt
LEA R0, intro			; Get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

; Get first input
GETC
OUT

AND R2, R2, #0
ADD R2, R0, #0

LEA R0, newline_char
PUTS

; Get second input
GETC
OUT

AND R3, R3, #0
ADD R3, R0, #0

LEA R0, newline_char
PUTS

; Output first number
AND R0, R0, #0
ADD R0, R2, #0
OUT

LEA R0, subtract_operator
PUTS

; Output second number
AND R0, R0, #0
ADD R0, R3, #0
OUT

LEA R0, equals_sign
PUTS

; Calculate difference
ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12

ADD R3, R3, #-12
ADD R3, R3, #-12
ADD R3, R3, #-12
ADD R3, R3, #-12

NOT R3, R3
ADD R3, R3, #1
AND R4, R4, #0
ADD R4, R2, R3

; Output result
BRzp output_num

LEA R0, negative_sign
PUTS

NOT R4, R4
ADD R4, R4, #1

output_num
ADD R0, R4, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

LEA R0, newline_char
PUTS

HALT				; Stop execution of program

; Data

; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
subtract_operator .STRINGZ " - "
negative_sign .STRINGZ "-"
equals_sign .STRINGZ " = "
newline_char .FILL x0A

;---------------	
;END of PROGRAM
;---------------	

.END