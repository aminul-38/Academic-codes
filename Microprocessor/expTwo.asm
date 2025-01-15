TITLE PRG2: DISPLAY A SINGLE CHARACTER

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV AH, 2H        ; Set AH to 2 for character display
    MOV DL, 'N'       ; Load the character 'N' into DL
    INT 21H           ; Call DOS interrupt to display the character

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
