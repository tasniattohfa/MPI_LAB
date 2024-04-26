                    .MODEL SMALL
.STACK 100H

.DATA
    ; Variables to store the input digits and results
    NUMBERS DB 5 DUP (?)    ; Array to store input digits
    AVERAGE DB ?
    LARGEST DB ?
    SMALLEST DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input five decimal digits
    MOV AH, 01H     ; Function to read a character from standard input (keyboard)
    MOV CX, 5       ; Counter for reading 5 digits
    MOV SI, OFFSET NUMBERS   ; Point SI to the NUMBERS array
READ_DIGITS:
    INT 21H         ; Read character
    SUB AL, 30H     ; Convert ASCII digit to binary
    MOV [SI], AL    ; Store the digit in the array
    INC SI
    LOOP READ_DIGITS

    ; Call procedures to calculate average, largest, and smallest
    CALL CALC_AVERAGE
    CALL CALC_LARGEST
    CALL CALC_SMALLEST

    ; Display results
    MOV DL, AVERAGE
    ADD DL, 30H     ; Convert binary digit to ASCII
    MOV AH, 02H     ; Function to display character
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    MOV DL, "LARGEST = "
    MOV AH, 09H     ; Function to display string
    INT 21H

    MOV DL, LARGEST
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    MOV DL, "SMALLEST = "
    MOV AH, 09H
    INT 21H

    MOV DL, SMALLEST
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH     ; Function to terminate program
    INT 21H

MAIN ENDP

; Procedure to calculate the average of the digits
CALC_AVERAGE PROC
    MOV BL, 5       ; Counter for 5 digits
    MOV AL, 0       ; Initialize sum to 0
    MOV CX, 0       ; Initialize count to 0

CALC_AVERAGE_LOOP:
    MOV AH, 0       ; Clear AH before division
    MOV AH, [NUMBERS + BX - 1] ; Load digit from array
    ADD AL, AH      ; Add digit to sum
    INC CX          ; Increment count
    DEC BL          ; Decrement counter
    JNZ CALC_AVERAGE_LOOP   ; Loop until all digits processed

    DIV CX          ; Calculate average (sum / count)
    MOV AVERAGE, AL ; Store average

    RET
CALC_AVERAGE ENDP

; Procedure to find the largest digit
CALC_LARGEST PROC
    MOV BL, 5       ; Counter for 5 digits
    MOV AL, 0       ; Initialize largest to 0

CALC_LARGEST_LOOP:
    MOV AH, [NUMBERS + BX - 1] ; Load digit from array
    CMP AH, AL      ; Compare current digit with largest
    JG UPDATE_LARGEST  ; Jump if current digit is greater than largest
    DEC BL          ; Decrement counter
    JNZ CALC_LARGEST_LOOP  ; Loop until all digits processed
    JMP LARGEST_DONE

UPDATE_LARGEST:
    MOV AL, AH      ; Update largest with current digit
    DEC BL          ; Decrement counter
    JNZ CALC_LARGEST_LOOP  ; Loop until all digits processed

LARGEST_DONE:
    MOV LARGEST, AL    ; Store largest digit
    RET
CALC_LARGEST ENDP

; Procedure to find the smallest digit
CALC_SMALLEST PROC
    MOV BL, 5       ; Counter for 5 digits
    MOV AL, 9       ; Initialize smallest to 9 (largest possible digit)

CALC_SMALLEST_LOOP:
    MOV AH, [NUMBERS + BX - 1] ; Load digit from array
    CMP AH, AL      ; Compare current digit with smallest
    JL UPDATE_SMALLEST  ; Jump if current digit is smaller than smallest
    DEC BL          ; Decrement counter
    JNZ CALC_SMALLEST_LOOP  ; Loop until all digits processed
    JMP SMALLEST_DONE

UPDATE_SMALLEST:
    MOV AL, AH      ; Update smallest with current digit
    DEC BL          ; Decrement counter
    JNZ CALC_SMALLEST_LOOP  ; Loop until all digits processed

SMALLEST_DONE:
    MOV SMALLEST, AL   ; Store smallest digit
    RET
CALC_SMALLEST ENDP

END MAIN
