org 100h

.DATA
    input db ?
    RESULT dw ?
    input_prompt db 'The value of N in between: $' , '$'  
    output_prompt db 'The result is: $' , 0DH, 0AH
    
.CODE
MAIN PROC
    mov ax, @DATA
    mov ds, ax

    ; Display input prompt
    mov dx, offset input_prompt
    mov ah, 09h
    int 21h

   
    mov ah, 01h
    int 21h
    sub al, '0'      
    mov input, al

   
    xor bx, bx       ; BX will store total
    mov cl, input 
    xor ax, ax       

    ; Calculate the sum
Calculate_Sum0fSquare:
    mov ax, cx           
    imul ax              
    add bx, ax           
    dec cl            
    jnz Calculate_Sum0fSquare    

   
    mov RESULT, bx
         
    
    ; Display the output message
    mov dx, offset output_prompt
    mov ah, 09h
    int 21h


    mov ax, RESULT
    call ShowOutput

    
    mov ah, 4Ch
    int 21h
MAIN ENDP

ShowOutput PROC
   
    push ax
    push bx
    push cx
    push dx         

    mov bx, 10      
    mov cx, 0       

divideandpush:
    xor dx, dx      
    div bx          ; Divide AX by 10, remainder in DX
    push dx        
    inc cx         
    test ax, ax     ; Check if quotient is zero
    jnz divideandpush 

print:
    pop dx          
    add dl, '0'     
    mov ah, 02h     
    int 21h        
    loop print

    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ShowOutput ENDP

END MAIN