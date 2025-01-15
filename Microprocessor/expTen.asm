TITLE 'Debug Program one: ADD, SUB, NEG, INC'

.MODEL SMALL          ; Define small memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure

    MOV AX, 4000H     ; Set AX to 4000H (AX = 4000H)
    ADD AX, AX        ; Add AX to itself (AX = AX + AX -> AX = 8000H)
    SUB AX, 0001H     ; Subtract 0001H from AX (AX = 8000H - 0001H -> AX = 7FFFH)
    
    ; AX is now 7FFFH
    
    NEG AX            ; Negate AX (AX = -7FFFH -> AX = 8001H)
    
    INC AX            ; Increment AX by 1 (AX = 8001H + 1 -> AX = 8002H)

    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; DOS interrupt to terminate the program

MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
