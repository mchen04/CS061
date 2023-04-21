;=================================================
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Lab: lab 3. ex 3
; Lab section: 23
; TA: westin and sanchit
; 
;=================================================

.ORIG x3000

    ARRAY_1 .BLKW #10
	
	LD R1, ARRAY_PTR
    LD R2, DEC_10

    LEA R0, PROMPT
    PUTS
    
    DO_WHILE
        GETC
        STR R0, R1, #0
        ADD R1, R1, #1
        ADD R2, R2, #-1
        BRp DO_WHILE
    END_DO_WHILE
    
    LEA R1, ARRAY_1
    LD R2, DEC_10
    
    DO_WHILE_2
        LDR R0, R1, #0
        OUT 
        ADD R1, R1, #1
        ADD R2, R2, #-1
        LEA R0, NEWLINE
        PUTS 
        BRp DO_WHILE_2
    END_DO_WHILE_2
		
	HALT						
	
	PROMPT .STRINGZ "Please enter 10 characters:\n"
	DEC_10 .FILL #10
	ARRAY_PTR .FILL ARRAY_1
	
	NEWLINE .FILL x0A
	
.END