TITLE PRG5: 'Display CSTE DEPARTMENT 22 TIMES'

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment begins
    MSG DB 0DH, 0AH, 'CSTE, NSTU$' ; Message with a new line (CR+LF)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV AX, @DATA     ; Load the address of the data segment into AX
    MOV DS, AX        ; Move the address from AX to the data segment register DS

    MOV CX, 22        ; Initialize loop counter to 22
    LEA DX, MSG       ; Load the effective address of MSG into DX
    MOV AH, 9H        ; Set AH to 9 for displaying a string

TOP:                  ; Label for the loop
    INT 21H           ; Call DOS interrupt to display the string
    LOOP TOP          ; Decrement CX and loop if CX is not zero

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
