;=================================================
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: 23
; TA: Sanchit Goel & Westin Montano	
; 
;=================================================
.orig x3000
    ; Initialize the stack. Don't worry about what that means for now.
    ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE=
    
    ; your code goes here
    ;Variables
    ld r1, array_ptr
    ld r2, counter_loop
    ld r5, array_size
    
    ;Subroutines
    ld r3, sub_get_string
    jsrr r3
    
    ld r1, array_ptr ;reset r1
    
    ld r3, sub_is_palindrome 
    jsrr r3
    
    lea r0, the_string
    puts
    
    ld r3, sub_print_array
    jsrr r3
    
    add r4, r4, #0
    BRp if_palindrome
    BR else 
    if_palindrome
        lea r0, is_palindrome
        puts
    BR end_else
    else 
        lea r0, is_not_palindrome
        puts
    end_else
    
    halt
    
    ; your local data goes here
    top_stack_addr .fill xFE00 ; DO NOT MODIFY THIS LINE OF CODE
    sub_get_string .fill x3200
    sub_is_palindrome .fill x3400
    sub_print_array .fill x3600
    array_ptr .fill x4000
    counter_loop .fill #0
    array_size .fill #0
    the_string .stringz "The string \""
    is_palindrome .stringz "\" is a palindrome\n"
    is_not_palindrome .stringz "\" is not a palindrome\n"
.end

; your subroutines go below here
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
.orig x3200
    lea r0, prompt
    puts
    
    ;backup registers 
    add r6, r6, #-1
    str r7, r6, #0
    
    while_input
        getc
        out
        add r2, r0, #-10                ;Checks invalid input
        BRz end_input                   ;If invalid input (endline) exit loop
        ;Adding valid input into array
            str r0, r1, #0
            add r1, r1, #1
            add r5, r5, #1
        BR while_input                  ;Continues loop
    end_input
    
    ;restoring register
    ldr r7, r6, #0
    add r6, r6, #1
    
    ret
    
    prompt .stringz "Enter string\n"
.end

;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
.orig x3400
    
    ;backup registers 
    add r6, r6, #-1
    str r7, r6, #0
    
    ld r3, sub_to_upper
    jsrr r3
    
    ;assigns r2 to the address of last char
    ld r2, array_begin
    ld r1, array_begin
    add r2, r2, r5
    add r2, r2, #-1
    
    add r3, r5, #-1 ;counter
    
    while_compare
        ldr r4, r1, #0  ;starting char
        ldr r5, r2, #0  ;ending char
        
        ;Twos complement of r2, the last char
        not r5, r5
        add r5, r5, #1
        add r5, r5, r4
        BRnp if_not_zero
        
        ;next index iteration
        add r1, r1, #1
        add r2, r2, #-1
        
        ;counter
        add r3, r3, #-1
        BRp while_compare
        ld r4, true
        BR else_zero
        
        if_not_zero
            ld r4, false
            BR end_compare
        if_end
        
        else_zero
        ld r4, true
        
    end_compare
        
    ;restoring register
    ldr r7, r6, #0
    add r6, r6, #1
    
    ret
    
    sub_to_upper .fill x3800
    array_begin .fill x4000
    true .fill #1
    false .fill #0
.end

;-------------------------------------------------------------------------
; Subroutine: sub_print_array
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R2): Checks for sentinel character
; Postcondition: The subroutine prints array out until reaches sentinel character
; Return Value: Printed array
;-------------------------------------------------------------------------
.orig x3600
    
    ;backup registers 
    add r6, r6, #-1
    str r7, r6, #0
    
    ld r1, array_start
    ld r2, num_zero
    
    WHILE_2
        LDR R0, R1, #0
        OUT
        ADD R1, R1, #1
        ADD R2, R0, #0
        BRnp WHILE_2
    END_WHILE_2
    
    ;restoring register
    ldr r7, r6, #0
    add r6, r6, #1
    
    ret
    
    array_start .fill x4000
    num_zero .fill #0
.end

;-------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case
;     in-place i.e. the upper-case string has replaced the original string
; No return value, no output, but R1 still contains the array address, unchanged
;-------------------------------------------------------------------------
.orig x3800
    
    ;backup registers 
    add r6, r6, #-1
    str r7, r6, #0
    
    ld r1, array_start_1
    ld r3, bit_mask_32
    ld r4, num_zero_1
    
    While_upper 
        ldr r2, r1, #0
        and r2, r2, r3      ;get bit mask and store into r2
        str r2, r1, #0      ;get uppercase value store into r1
        add r1, r1, #1
        add r4, r2, #0
        BRnp While_upper
    end_upper
    
    ;restoring register
    ldr r7, r6, #0
    add r6, r6, #1
    
    ret
    
    num_zero_1 .fill #0
    array_start_1 .fill x4000
    bit_mask_32 .fill xDF ;1101 1111
.end

;==================
;remote data

.orig x4000
    array .blkw #100
.end
