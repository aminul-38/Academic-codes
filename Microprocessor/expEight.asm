TITLE PRG6: 'Write an Assembly Language to Display 80 Stars'

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV CX, 80        ; Initialize the loop counter to 80
    MOV AH, 2H        ; Function to display a single character
    MOV DL, '*'       ; Load the ASCII code for '*' into DL

TOP:                  ; Label for the loop
    INT 21H           ; Call DOS interrupt to display the character
    LOOP TOP          ; Decrement CX and loop if CX is not zero

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
