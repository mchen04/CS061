;=================================================
; Name: Michael Chen
; Email: mchen356@ucr.edu    
; 
; Lab: lab 8, ex 1
; Lab section: 23
; TA: Westin & Monty
; 
;=================================================
.ORIG x3000

    LD R6, TOP_STACK_ADDR
    
    ; Test harness
    ;-------------------------------------------------
    LD R5, SUB_FILL_VALUE
    JSRR R5
    
    ADD R1, R1, #1
    
    LD R5, SUB_OUTPUT_DECIMAL
    JSRR R5
    
    HALT

; Test harness local data
;-------------------------------------------------
    TOP_STACK_ADDR .FILL xFE00
    SUB_FILL_VALUE .FILL x3200
    SUB_OUTPUT_DECIMAL .FILL x3400

.END

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: R1 input
; Postcondition: NA
; Return Value: R1 hardcoded value
;=================================================

.ORIG x3200

    ; Backup registers
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    
    ; Code
    LD R1, INPUT_VALUE
    
    ADD R1, R1, #0
    BRzp END_IF
    
    IF_NEG
        NOT R1, R1
        ADD R1, R1, #1
        LD R0, NEGATIVE_SYMB
        OUT
    END_IF

    ; Restore registers
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
    
    RET
    INPUT_VALUE .FILL #-3
    NEGATIVE_SYMB .STRINGZ "-"
.END

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter:
; Postcondition:
; Return Value: R2 stack values
;=================================================

.ORIG x3400
    
    ; Backup registers
    ADD R6, R6, #-1
    STR R1, R6, #0
    ;---
    ADD R6, R6, #-1
    STR R3, R6, #0
    ;---
    ADD R6, R6, #-1
    STR R4, R6, #0
    
    ; Code
    LD R2, DECIMAL_STACK_ADD
    LD R3, DEC_ZERO ; counter for how many times 10 can be subtracted from value
    LD R4, DEC_ZERO ; value that will be pushed into the stack
    
    MODULO_LOOP
        ADD R4, R1, #0 ; copy R1 value to R4
        ADD R1, R1, #-10 ; subtract
        BRn END_LOOP
        ADD R3, R3, #1 ; counting how many times 10 goes into value
        BR MODULO_LOOP
    END_LOOP
        STR R4, R2, #0
        ADD R2, R2, #1 ; pushing value to stack
        ADD R1, R3, #0 ; setting R1 to now R3
        AND R3, R3, #0 ; reset R3 counter
        ADD R1, R1, #0
        BRp MODULO_LOOP
    
    LD R3, DEC_48
    ; calculate size of stack
    LD R4, DECIMAL_STACK_ADD
    NOT R4, R4
    ADD R4, R4, #1
    ADD R4, R2, R4
    
    WHILE_PRINT
        ADD R2, R2, #-1
        LDR R0, R2, #0
            ADD R0, R0, R3
        OUT
        ADD R4, R4, #-1     ;WHEN SIZE IS NOT POSITIVE
        BRp WHILE_PRINT
    PRINT_END
    
    ; Restore registers
    LDR R4, R6, #0
    ADD R6, R6, #1
    ;---
    LDR R3, R6, #0
    ADD R6, R6, #1
    ;---
    LDR R1, R6, #0
    ADD R6, R6, #1
    
    RET
    DECIMAL_STACK_ADD .FILL x4000
    DEC_ZERO .FILL #0
    DEC_48 .FILL #48
.END