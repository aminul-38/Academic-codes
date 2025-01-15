TITLE PRG7: 'Display List of Characters Until Pressing SPACE Bar Key'

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV AH, 1H        ; Function to read a single character

REPEAT_:              ; Label for the loop
    INT 21H           ; Call DOS interrupt to read a character
    CMP AL, ' '       ; Compare the input character with a space (' ')
    JNE REPEAT_       ; If not a space, repeat the loop
    MOV DL, AL        ; Move the input character to DL for output
    MOV AH, 2H        ; Function to display a single character
    INT 21H           ; Call DOS interrupt to display the character

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
