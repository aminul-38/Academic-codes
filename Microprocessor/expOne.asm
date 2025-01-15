TITLE PRG1: A SINGLE CHARACTER INPUT

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV AH, 1H        ; Set AH to 1 for character input
    INT 21H           ; Call DOS interrupt to read a character

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
