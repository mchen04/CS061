;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Michael Chen
; Email: mchen356@ucr.edu
; 
; Assignment name: Program 4
; Lab section: 23
; TA: Westin 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================
.ORIG x3000            ; Program begins here

    ;-------------
    ; Instructions
    ;-------------
    LD R3, COUNTER
    AND R4, R4, #0
    
    START_LOOP
      AND R4, R4, #0
      LD R0, introPromptPtr
      PUTS
    
      GETC
      OUT
    
      AND R5, R5, #0     ; CHECK POSITIVE SIGN
      ADD R5, R5, R0
      ADD R5, R5, #-10
      BRz ERROR1
      ADD R5, R5, #-6
      ADD R5, R5, #-16
      ADD R5, R5, #-11
      BRz LOOP_POS
      BRp CHECKNEG
    
    CHECKNEG
      ADD R5, R5, #-2    ; CHECK NEGATIVE SIGN
      BRz LOOP_NEG
      BRp CHECKNUM
    
    CHECKNUM
      AND R5, R5, #0
      ADD R5, R5, R0
      ADD R5, R5, #-16
      ADD R5, R5, #-16
      ADD R5, R5, #-16
      BRn ERROR1
      ADD R5, R5, #-9
      BRp ERROR1
      ADD R3, R3, #-1
      BR LOOP_NUM
    
    LOOP_POS
      GETC
      OUT
      ; CONVERT ASCII TO DECIMAL
      ADD R0, R0, #-10
      BRz HALTPROGRAM
      ADD R0, R0, #-6
      ADD R0, R0, #-16
      ADD R0, R0, #-16
      BRn ERROR1
      ADD R6, R0, #0
      ADD R6, R6, #-9
      BRp ERROR1
      ADD R1, R4, R4
      ADD R4, R4, R4
      ADD R4, R4, R4
      ADD R4, R4, R4
      ADD R4, R1, R4
      ADD R4, R4, R0
      ADD R3, R3, #-1
      BRp LOOP_POS
      BR HALTPROGRAM
    
    LOOP_NEG
      GETC
      OUT
      ADD R0, R0, #-10
      BRz TWOCOM
      ADD R0, R0, #-6
      ADD R0, R0, #-16
      ADD R0, R0, #-16
      BRn ERROR1
      ADD R6, R0, #0
      ADD R6, R6, #-9
      BRp ERROR1
      ADD R1, R4, R4
      ADD R4, R4, R4
      ADD R4, R4, R4
      ADD R4, R4, R4
      ADD R4, R1, R4
      ADD R4, R4, R0
      ADD R3, R3, #-1
      BRp LOOP_NEG
      BR TWOCOM
        
    LOOP_NUM
      ADD R0, R0, #-10
      BRz HALTPROGRAM
      ADD R0, R0, #-6
      ADD R0, R0, #-16
      ADD R0, R0, #-16
      BRn ERROR1
      ADD R6, R0, #0
      ADD R6, R1, #-9
      BRp ERROR1
      ADD R1, R4, R4
      ADD R4, R4, R4
      ADD R4, R4, R4
      ADD R4, R4, R4
      ADD R4, R1, R4
      ADD R4, R4, R0
      BR LOOP_POS
    
    TWOCOM
      NOT R4, R4
      ADD R4, R4, #1
      BR HALTPROGRAM
    
    ERROR1
      LEA R0, NEWLINE
      PUTS
      LD R0, errorMessagePtr
      PUTS
      BR START_LOOP
    
    HALTPROGRAM
      LEA R0, NEWLINE
      PUTS
      HALT
    
    
    ;---------------	
    ; Program Data
    ;---------------
    
    introPromptPtr  .FILL xB000
    errorMessagePtr .FILL xB200
    COUNTER .FILL #5
    NEWLINE .FILL x0A

.END
    
    ;------------
    ; Remote data
    ;------------
    .ORIG xB000   ; intro prompt
    .STRINGZ     "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
    
    .END
    
    
    .ORIG xB200   ; error message
    .STRINGZ     "ERROR: invalid input\n"
    .END
    
    ;---------------
    ; END of PROGRAM
    ;---------------
.END


;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.