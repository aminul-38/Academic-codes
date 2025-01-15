TITLE 'Debug Program Three: AND, OR, NEG'

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure

    MOV AX, 6A78H     ; Load AX with 6A78H
    MOV BX, 5B28H     ; Load BX with 5B28H
    MOV CX, 290AH     ; Load CX with 290AH

    AND AX, BX        ; Perform bitwise AND operation on AX and BX (AX = AX & BX)
    ; After AND, AX = 6A78H & 5B28H = 4A28H

    OR CX, AX         ; Perform bitwise OR operation on CX and AX (CX = CX | AX)
    ; After OR, CX = 290AH | 4A28H = 7A2AH

    NEG AX            ; Perform bitwise NEG operation on AX (AX = -AX)
    ; After NEG, AX = -4A28H = B5D8H (two's complement)

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program

MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
