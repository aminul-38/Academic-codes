TITLE PRG6: 'Display List of Characters Until Enter is Pressed'

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             
    
    MOV AH, 1H        ; Function to read a single character

TOP_:
    CMP AL, 0DH       ; Compare the input character with Carriage Return (Enter key)
    JE ENDLOOP_       ; If Enter (Carriage Return) is pressed, jump to ENDLOOP_

    INT 21H           ; Call DOS interrupt to read a character
    JMP TOP_          ; Jump back to the top of the loop

ENDLOOP_:
    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program

MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
