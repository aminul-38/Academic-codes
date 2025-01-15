TITLE 'Debug Program Two: OR, XOR, NOT'

.MODEL SMALL          
.STACK 100H           

.CODE                  
MAIN PROC             

    MOV AX, 1027H     ; Load AX with 1027H
    MOV BX, 5A27H     ; Load BX with 5A27H
    MOV CX, 54A5H     ; Load CX with 54A5H

    OR AX, BX         ; Perform bitwise OR operation on AX and BX (AX = AX | BX)
    XOR CX, AX        ; Perform bitwise XOR operation on CX and AX (CX = CX ^ AX)
    NOT AX            ; Perform bitwise NOT operation on AX (AX = ~AX)
    
    XOR AL, AL        ; Clear AL before program termination
    MOV AH, 4CH       ; Set AH to 4CH for program termination
    INT 21H           ; Call DOS interrupt to terminate the program

MAIN ENDP             
END MAIN              ; Specify the program entry point
