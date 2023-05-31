; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 23
; TA: Westina nd Montano
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000
    
    ; Initialize the stack
    ld r6, stack_address
    
    ; Call main subroutine
    lea r5, main_subroutine
    jsrr r5
    
    ;---------------------------------------------------------------------------------
    ; Main Subroutine
    ;---------------------------------------------------------------------------------
    main_subroutine
    ; Get a string from the user
    ; * put your code here
    LEA R0, user_prompt
    PUTS
    
    LD R2, get_user_string_address
    JSRR R2
    
    ; Find the size of the input string
    ; * put your code here
    LD R2, strlen_address
    JSRR R2
    
    ; Call the palindrome method
    ; * put your code here
    LD R2, palindrome_address
    JSRR R2
    
    ; Determine if the string is a palindrome
    ; * put your code here
    ADD R0, R0, #0
    BRz NOT_PALINDROME  ; If palindrome subroutine returns 0
    BRp IS_PALINDROME   ; If palindrome subroutine returns 1 since >0.
    
    ; Print the result to the screen
    ; * put your code here
    
    
    ; Decide whether or not to print "not"
    ; * put your code here
    IS_PALINDROME 
    LEA R0, result_string
    PUTS
    LEA R0, final_string
    PUTS
    
    NOT_PALINDROME
    LEA R0, result_string
    PUTS
    LEA R0, not_string 
    PUTS
    LEA R0, final_string
    PUTS
    
    HALT
    
    ;---------------------------------------------------------------------------------
    ; Required labels/addresses
    ;---------------------------------------------------------------------------------
    
    ; Stack address ** DO NOT CHANGE **
    stack_address           .FILL    xFE00
    
    ; Addresses of subroutines, other than main
    get_user_string_address .FILL    x3200
    strlen_address          .FILL    x3300
    palindrome_address      .FILL	x3400
    
    
    ; Reserve memory for strings in the program
    user_prompt          .STRINGZ "Enter a string: "
    result_string        .STRINGZ "The string is "
    not_string           .STRINGZ "not "
    final_string         .STRINGZ "a palindrome\n"
    
    ; Reserve memory for user input string
    user_string          .BLKW	  100

.END

;---------------------------------------------------------------------------------
; get_user_string  - obtains string from user input
; parameter: R1 - the address of the user prompt
; parameter: R2 - the starting address of the character array
; postcondition: Takes in a string from the user
; returns: nothing
;---------------------------------------------------------------------------------
.ORIG x3200
    get_user_string
    
    ; Backup all used registers, starting with R7, using proper stack discipline
    ADD R6, R6, #-1
    STR R0, R6, #0
    ADD R6, R6, #-1
    STR R1, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R7, R6, #0
    
    LD R2, ARRAY_ONE
    
DO_WHILE_LOOP
    GETC
    OUT
    LD R3, newline
    ADD R3, R0, R3      ; Check if input character is newline
    
    IF_STATEMENT
        BRnp TRUE_CONDITION
    
    FALSE_CONDITION
        STR R4, R2, #0      ; Store R4 to R2
        ADD R4, R4, #-1     ; Set R4 to -1
        BR END_DO_WHILE_LOOP
    
    TRUE_CONDITION
        STR R0, R2, #0      ; Store R0 to R2
    
    END_IF
    
    ADD R2, R2, #1          ; Move to next address
    ADD R4, R4, #0
    BRz DO_WHILE_LOOP       ; Check if R4 is negative, loop continues if R4 plus itself is zero.
    
END_DO_WHILE_LOOP
    
    ; Restore all used registers, starting with R7, using proper stack discipline
    LDR R7, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R1, R6, #0
    ADD R6, R6, #1
    LDR R0, R6, #0
    ADD R6, R6, #1
    
    RET
    
    ; Local data
    ARRAY_ONE   .FILL   x4000
    newline     .FILL   #-10
.END


;---------------------------------------------------------------------------------
; strlen - compute the length of a zero terminated string
; parameter: R1 - the address of a zero terminated string
; postcondition: finds the length of the usre inputed string
; returns: The length of the string (R0)
;---------------------------------------------------------------------------------
.ORIG x3300
    strlen
    ; Backup all used registers, starting with R7, using proper stack discipline
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    ADD R6, R6, #-1
    STR R1, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    
    LD R4, num_zero
    LD R0, num_zero
    LD R1, STRING_ADDRESS
    
    LOOP_START
    LDR R5, R1, #0      ; Load value at address R1 into R5
    IF_STATEMENT9       
    BRz LOOP_END        ; If R5 = 0, string has been completely counted
    TRUE_STATEMENT
    ADD R0, R0, #1      ; Increment R0 to store new string length    
    ADD R1, R1, #1      ; Move R1 to the next character in the array
    BRnzp LOOP_START
    LOOP_END
    
    ; Restore all used registers, starting with R7, using proper stack discipline
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R1, R6, #0
    ADD R6, R6, #1
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
    
    RET
    
    ; Local data
    STRING_ADDRESS  .FILL   x4000
    num_zero        .FILL   #0

.END


;---------------------------------------------------------------------------------
; palindrome - determine if a string is spelled the same backwards
; parameter: R1 - the address of a zero terminated string
; parameter: R0 - the length of the string
; postcondition: checks if the string is a palindrome
; returns: 1 if palindrome, 0 if not a palindrome
;---------------------------------------------------------------------------------
.ORIG x3400
    palindrome   ; Hint, do not change this label and use for recursive calls
    
    ; Backup all used registers, R7 first, using proper stack discipline
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R1, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    ADD R6, R6, #-1
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    ADD R6, R6, #-1
    STR R7, R6, #0
    
    ADD R1, R1, #0
    BRp STORE_CHARACTER
    
    LD R2, zero           ; Initialize R2 to 0
    LD R1, ARRAY_ADDR     ; Load array address into R1
    ADD R2, R0, R1        ; R2 has address of the last string (counter + array address)
    
    ADD R2, R2, #-1
    
    STORE_CHARACTER
    LDR R5, R1, #0        ; Load current character from the array
    LDR R3, R2, #0        ; Load current character from the end of the array
    
    IF_STATEMENT3
    CHECK_ADDRESS
        LD R4, zero
        ADD R4, R2, #0     ; Store the end address of the string into R4
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R4, R1     ; Store the beginning of the string + two's complement of the end of the string into R4
        BRzp RETURN_ONE
    CHECK_CHARACTER
        LD R4, zero
        ADD R4, R3, #0
        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R4, R5     ; Store two's complement of R4 + array address into R4
        
        BRnp RETURN_ZERO
        BRz INCREMENT
        
        RETURN_ZERO
        LD R0, zero
        BR END_IF3
        
        RETURN_ONE
        LD R0, one
        BR END_IF3
        
        INCREMENT
        ADD R1, R1, #1     ; Move to the next address (beginning -> end)
        ADD R2, R2, #-1    ; Move to the next address (end -> beginning)
        JSR palindrome     ; Call itself (recursive call)
        END_IF3
        
    ; Restore all used registers, R7 last, using proper stack discipline
    LDR R7, R6, #0
    ADD R6, R6, #1
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R2, R6, #0
    ADD R6, R6, #1
    LDR R1, R6, #0
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    
    RET

    ;Local data
    ARRAY_ADDR  .FILL   x4000
    zero        .FILL   #0
    one         .FILL   #1
.END
