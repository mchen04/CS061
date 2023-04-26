; Hello World example program
; Also illustrates how to use PUTS(aka: Trap x22)
.ORIG 3000

; Instructions

    LEA R0, MSG_TO_PRINT  ;R0 <- the location of the label: MSG_TO_PRINT
    PUTS ;Prints string defined at MSG_TO_PRINT
    
    HALT ;terminates program
    
; Local Data
    
    MSG_TO_PRINT .STRINGZ "Hello world!!!\n" ;Store 'H' in an Address labelled MSG_TO_PRINT and then each character in its own memory,
                                            ;followed by #0 at the end of the string to mark the end 
    
.END
    
