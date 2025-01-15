TITLE 'Display IBM256 Character'

.MODEL MEDIUM         ; Define medium memory model
.STACK 100H           ; Reserve 256 bytes of stack space

.DATA                 ; Data segment (empty in this case)

.CODE                 ; Code segment begins
MAIN PROC             ; Start of the main procedure
    MOV CX, 256       ; Set loop counter to 256 (for 256 characters)
    MOV DL, 0         ; Start with ASCII code 0 (null character)

PRINT_LOOP:           ; Label for the loop
    MOV AH, 2H        ; DOS function to display a single character
    INT 21H           ; Call DOS interrupt to display the character
    INC DL            ; Increment ASCII code (DL will point to next character)
    DEC CX            ; Decrement loop counter
    JNZ PRINT_LOOP    ; Jump back to PRINT_LOOP if CX is not zero

    ; Uncomment the following lines if you want to exit explicitly
    ;JCXZ EXIT        ; Jump to EXIT if CX is zero
    ;EXIT:            ; Exit label

    MOV AH, 4CH       ; Function to terminate the program
    INT 21H           ; DOS interrupt to terminate the program
MAIN ENDP             ; End of the main procedure
END MAIN              ; Specify the program entry point
