ORG 0100h  
  
.DATA
A DB 11
B DW 500
SUM DW ?
DIFFERENCE DB ?
MULTIPLICATION DW ?
DIVISION DB ?
F DB ?      

.CODE
MAIN PROC

; Task A: (30 + 15) * (575 - 225) + 210    

MOV AX, 30
ADD AX, 15
MOV BX, 575
SUB BX, 225
MUL BX
ADD AX, 210
MOV SUM, AX

; Task B: 0Bh * (200 - 225) + 127       

MOV AL, 0Bh
MOV BL, 200
SUB BL, 225
MUL BL
ADD AL, 127
MOV DIFFERENCE, AL

; Task C: 0FFFh * 10h + 1111b      

MOV AX, 0FFFh
MOV BL, 10h
MUL BL
MOV CX, 1111b
ADD AX, CX
MOV MULTIPLICATION, AX

; Task D: Convert 260 C (Celsius) to F (Fahrenheit)
MOV AX, 260     
MOV BX, 9       
MUL BX         
MOV BX, 5       
DIV BX         
ADD AX, 32      
MOV F, AL       


MAIN ENDP
END MAIN
RET

