;=================================================
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 23
; TA: Sanchit Goel & Westin Montano	
;=================================================
.orig x3000
    ; Initialize the stack. Don't worry about what that means for now.
    ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE
    
    ; your code goes here
    ld r1, array_ptr
    ld r2, counter_loop
    ld r5, array_size
    ld r3, sub_get_string
    jsrr r3

halt

; your local data goes here

    top_stack_addr .fill xFE00 ; DO NOT MODIFY THIS LINE OF CODE
    sub_get_string .fill x3200
    array_ptr .fill x4000
    counter_loop .fill #0
    array_size .fill #0

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
        add r2, r0, #-10               ;Checks invalid input
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
    
    ;remote data
.orig x4000
    array .blkw #100

.end
