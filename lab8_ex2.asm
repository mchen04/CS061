;=================================================
; Name: Michael Chen
; Email: mchen356@ucr.edi
; 
; Lab: lab 8, ex 2
; Lab section: 23
; TA: Westin
; 
;=================================================

.ORIG x3000

    LD R6, TOP_STACK_ADDR
    
    ; Test harness
    ;-------------------------------------------------
    LEA R0, PROMPT 
    PUTS
    
    ; Input
    GETC
    OUT
    
    ADD R1, R0, #0  ; Load value into R1
    
    LD R5, SUB_PARITY_CHECK
    JSRR R5
    
    HALT
    
    ; Test harness local data
    ;-------------------------------------------------
    TOP_STACK_ADDR .FILL xFE00
    PROMPT .STRINGZ "ENTER A CHARACTER: "
    ENDLINE .STRINGZ "\n"
    SUB_PARITY_CHECK .FILL x3600

.END

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: R1 input character
; Postcondition: only characters from x20 - x7F
; Return Value (R3): number of 1's stored in R3
;=================================================

.ORIG x3600
    
    ; Backup registers
    ADD R6, R6, #-1
    STR R1, R6, #0
    ;---
    ADD R6, R6, #-1
    STR R2, R6, #0
    ;---
    ADD R6, R6, #-1
    STR R5, R6, #0
    ;---
    ADD R6, R6, #-1
    STR R7, R6, #0
    
    ; Code
    LD R3, DEC_48        ; Counter for 1's
    LD R4, DEC_15       ; Loop counter
    
    ADD R2, R1, #0      ; Set R2 to R1
    WHILE_COUNT
        LD R5, LEAD_1_MASK
        AND R5, R5, R2  ; Bit mask to check if R2 has leading 1
        BRz ELSE
        IF_NEG
            ADD R3, R3, #1
        ELSE
        
        ADD R2, R2, R2
        ADD R4, R4, #-1
        BRp WHILE_COUNT
    END_WHILE
        
    LEA R0, RESULT1
    PUTS
    
    ADD R0, R1, #0
    OUT
    
    LEA R0, RESULT2
    PUTS
    
    ADD R0, R3, #0
    OUT
    
    ; Restore registers
    LDR R7, R6, #0
    ADD R6, R6, #1
    ;---
    LDR R5, R6, #0
    ADD R6, R6, #1
    ;---
    LDR R2, R6, #0
    ADD R6, R6, #1
    ;---
    LDR R1, R6, #0
    ADD R6, R6, #1
    
    RET
    DEC_48   .FILL #48
    DEC_15 .FILL #16
    LEAD_1_MASK .FILL x8000
    RESULT1 .STRINGZ "\nTHE NUMBER OF 1's IN '"
    RESULT2 .STRINGZ "' IS: "
.END