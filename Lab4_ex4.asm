;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Assignment name: Lab 4 ex1
; Lab section: 23
; TA: Goal, Sanchi     Montano, Westlin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================
.ORIG x3000

    AND R0, R0, #0          ; set R0 to 0
    LD R1, COUNTER         ; load address of array into R1
    LD R2, SUB_FILL_ARRAY_3200
    LD R3, DATA_PTR 
    JSRR R2     ; call subroutine to fill array
    LD R1, COUNTER         
    LD R2, SUB_CONVERT_ARRAY_3400
    LD R3, DATA_PTR 
    JSRR R2
    LD R1, COUNTER         
    LD R2, SUB_PRINT_ARRAY_3600
    LD R3, DATA_PTR 
    JSRR R2
    LD R1, COUNTER         
    LD R2, SUB_PRETTY_PRINT_ARRAY_3800
    LD R3, DATA_PTR 
    JSRR R2
    HALT
    
    DATA_PTR .FILL x4000
    COUNTER .FILL #10
    SUB_FILL_ARRAY_3200 .FILL x3200
    SUB_CONVERT_ARRAY_3400 .FILL x3400
    SUB_PRINT_ARRAY_3600 .FILL x3600
    SUB_PRETTY_PRINT_ARRAY_3800 .FILL x3800

.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3200
    FILL_LOOP
		ADD R1, R1, #-1
		BRn END_FILL_LOOP
    		STR R0, R3, #0
    		ADD R0, R0, #1
    		ADD R3, R3, #1
	    BR FILL_LOOP
    END_FILL_LOOP
    RET
.END

;------------------------------------------------------------------------
; Subroutine: SUB_CONVERT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (number) in the array should be represented as a character. E.g. 0 -> ‘0’
; Return Value (None)
;-------------------------------------------------------------------------


.ORIG x3400
    CONVERT_LOOP
		ADD R1, R1, #-1
		BRn END_CONVERT_LOOP
		    
		    LDR R0, R3, #0
		
            ADD R0, R0, #12
            ADD R0, R0, #12
            ADD R0, R0, #12
            ADD R0, R0, #12
                
            STR R0, R3, #0 
            ADD R3, R3, #1
	    BR CONVERT_LOOP
    END_CONVERT_LOOP
    RET
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (character) in the array is printed out to the console.
; Return Value (None)
;-------------------------------------------------------------------------


.ORIG x3600
    PRINT_LOOP
		ADD R1, R1, #-1
		BRn END_PRINT_LOOP
            LDR R0, R3, #0
            OUT
            ADD R3, R3, #1
	    BR PRINT_LOOP
    END_PRINT_LOOP
    RET
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRETTY_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Prints out “=====” (5 equal signs), prints out the array, and after prints out “=====” again.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3800
    LD R2, SUB_PRINT_ARRAY_PTR
    ST R7, R7BACK
    LEA R0, equal_signs
    
    PUTS
    JSRR R2
    
    LEA R0, equal_signs
    PUTS
    
    LD R7, R7BACK
    RET
    
    R7BACK   .fill #0
    
    SUB_PRINT_ARRAY_PTR .FILL x3600
    equal_signs .STRINGZ "====="
.END


.ORIG x4000
    REMOTEARR .BLKW #10 
.END
