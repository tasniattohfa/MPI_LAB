
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
org 100h

.data

.code
main proc  
    
    ;input a character
    mov ah,1
    int 21h
    mov bl,al      
               
    ;provide a new line
    mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
    
    ;compare upper or lower
    cmp bl,97
    jge lowercase_to_uppercase
    
    ;define uppercase_to_lowercase
    uppercase_to_lowercase:
        add bl,32
        ;10 will always be greated than 5. So this condition will make it jump to complete_execution branch  
        mov al,10
        cmp al,5
        jge complete_execution
    
    ;define lowercase_to_uppercase
    lowercase_to_uppercase:
        sub bl,32 
    
    
    complete_execution:     
        ;display character  
        mov dl,bl
        int 21h   
        
        ;Return to DOS
        mov ah,4ch
        int 21h 
        
        hlt
    
    
main endp
end main
ret