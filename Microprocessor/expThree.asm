TITLE PRG3: DISPLAY ONE LINE MESSAGE

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment begins
    MSG1 DB 'HOW ARE YOU CSTE 16 BATCH?$' ; Message to be displayed, ending with '$'

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV AX, @DATA     ; Load the address of the data segment into AX
    MOV DS, AX        ; Move the address from AX to the data segment register DS

    LEA DX, MSG1      ; Load the effective address of MSG1 into DX
    MOV AH, 9H        ; Set AH to 9 for displaying a string
    INT 21H           ; Call DOS interrupt to display the string

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
