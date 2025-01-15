TITLE PRG4: DISPLAY TWO LINE MESSAGE

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment begins
    MSG1 DB 'HOW ARE YOU CSTE 16 BATCH?$' ; First message to display
    MSG2 DB 0DH, 0AH, 'WE ARE FINE$'      ; Second message with new line (CR+LF)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV AX, @DATA     ; Load the address of the data segment into AX
    MOV DS, AX        ; Move the address from AX to the data segment register DS

    ; Display the first message
    LEA DX, MSG1      ; Load the effective address of MSG1 into DX
    MOV AH, 9         ; Set AH to 9 for displaying a string
    INT 21H           ; Call DOS interrupt to display the string

    ; Display the second message
    LEA DX, MSG2      ; Load the effective address of MSG2 into DX
    MOV AH, 9         ; Set AH to 9 for displaying a string
    INT 21H           ; Call DOS interrupt to display the string

    ; Terminate the program
    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
