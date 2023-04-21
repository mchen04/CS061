;=================================================
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Lab: lab 3. ex 4
; Lab section: 23
; TA: westin and sanchit
; 
;=================================================

.ORIG x3000

    LD R2, ARRAY_PTR
    LD R3, DEC_100
    
    LEA R0, PROMPT
    PUTS
    
    DO_WHILE
        LD R5, NEG_SENTINEL
        GETC
        OUT
        STR R0, R2, #0
        ADD R2, R2, #1
    
        ADD R5, R5, R0
        BRnp END_SENTINEL_CONDITION
    
        SENTINEL_CONDITION
            AND R3, R3, x0
        END_SENTINEL_CONDITION
        
        ADD R3, R3, #-1
        BRp DO_WHILE
    END_DO_WHILE
    
    LD R2, ARRAY_PTR
    LD R3, DEC_100
    
    DO_WHILE_2
        LD R5, NEG_SENTINEL
        LDR R0, R2, #0
        OUT
        ADD R2, R2, #1
    
        ADD R5, R5, R0
        BRnp END_SENTINEL_CONDITION_2
    
        SENTINEL_CONDITION_2
            AND R3, R3, x0
        END_SENTINEL_CONDITION_2
    
        ADD R3, R3, #-1
        BRp DO_WHILE_2
    END_DO_WHILE_2
    
    HALT
    
    PROMPT .STRINGZ "Enter a string (less than 100 characters) and end with '&':\n"
    DEC_100 .FILL #100
    ARRAY_PTR .FILL x4000
    NEG_SENTINEL .FILL #-38
    
.END
    
.ORIG x4000
    ARRAY_1 .BLKW #100
.END
