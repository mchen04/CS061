;=================================================
; Name: Michael Chen
; Email: mchne356@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 23
; TA: Sanchit Goel & Westin Montano	
; 
;=================================================

.orig x3000
    
    ;Instructions
    ld r6, reg_stack        ;register backup stack
    
    ;load value stack
    ld r3, stack_base
    ld r4, stack_max
    ld r5, stack_base       ;top of stack address, starts off as base and increment
    
    lea r0, prompt 
    puts
    
    ld r1, zero
    
    while_input
        getc
        out
        ld r2, zero
        add r2, r0, #-10                ;Checks invalid input
        BRz end_input                   ;If invalid input (endline) exit loop
        ;Adding valid input into array
            add r1, r0, #0
            ld r2, sub_stack_push
            jsrr r2
        BR while_input                  ;Continues loop
    end_input
    
    ld r1, stack_base
    
    ld r2, sub_stack_pop
    jsrr r2
    
    
    
    halt
    
    ;local data
    reg_stack .fill xFE00
    stack_base .fill xA000
    stack_max .fill xA005
    sub_stack_push .fill x3200
    sub_stack_pop .fill x3400
    sub_stack_print .fill x3800
    prompt .stringz "Enter stack value\n"
    zero .fill #0

.end

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R1): The value to push onto the stack
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available address) of
;the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R1) onto the stack (i.e to address TOS+1).
; If the stack was already full (TOS = MAX), the subroutine has printed an
; overflow error message and terminated.
; Return Value: R5 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3200

    ;backup registers 
    add r6, r6, #-1
    str r7, r6, #0
    
    add r6, r6, #-1
    str r3, r6, #0
    
    add r6, r6, #-1
    str r4, r6, #0
    
    ld r2, num_zero
    
    ;find two's complement of top address and compare to the max address
    not r4, r4
    add r4, r4, #1
    
    add r5, r5, #1      ;increment max
    add r2, r4, r5      ;Check if top < max
    BRnz if_valid
    BR else
    if_valid
        str r1, r5, #0      ;store r1 value
        BR else_end
    if_end
    else
        lea r0, stack_overflow
        puts
    else_end
    
    ;restoring register
    ldr r4, r6, #0
    add r6, r6, #1
    
    ldr r3, r6, #0
    add r6, r6, #1
    
    ldr r7, r6, #0
    add r6, r6, #1
    
    
    ret
    
    stack_overflow .stringz " Error: stack overflow\n"
    num_zero .fill #0

.end
;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack and copied it to R0.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Values: R0 ← value popped off the stack
;		   R5 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3400

    ;backup registers 
    add r6, r6, #-1
    str r7, r6, #0
    
    add r6, r6, #-1
    str r3, r6, #0
    
    add r6, r6, #-1
    str r4, r6, #0
    
    ld r2, zero_1
    
    ;find two's complement of base address compare to top of stack address
    not r3, r3
    add r3, r3, #1
    
    add r2, r3, r5          ;checks if top > base
    BRp if_pop
    BR else_underflow
    
    if_pop
        lea r0, test
        puts
        ldr r0, r5, #0
        out
        add r5, r5, #-1         ;decrement top
        BR else_end_1
    pop_end
    else_underflow
        lea r0, underflow
        puts
    else_end_1
    
    ;restoring register
    ldr r4, r6, #0
    add r6, r6, #1
    
    ldr r3, r6, #0
    add r6, r6, #1
    
    ldr r7, r6, #0
    add r6, r6, #1
    
    ret
    test .stringz "POP: "
    underflow .stringz "Error: stack underflow\n"
    zero_1 .fill #0

.end


;------------------------------------------------------------------------------------------
; Subroutine: sub_stack_print
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available address) of
;the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
;------------------------------------------------------------------------------------------
.orig x3800

    ;backup registers 
    add r6, r6, #-1
    str r7, r6, #0
    
    add r6, r6, #-1
    str r3, r6, #0
    
    and r2, r2, #0
    add r3, r3, #1
    
    while_print
        ldr r0, r3, #0
        out
        add r3, r3, #1
        add r2, r0, #0
        BRnp while_print
    end_print
    
    ret
    
    ;restoring register
    ldr r3, r6, #0
    add r6, r6, #1
    
    ldr r7, r6, #0
    add r6, r6, #1

.end

.orig xA000
    array .blkw #6
.end
