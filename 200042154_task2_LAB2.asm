
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data   


.code
main proc   
    
    get_to_front_upper:          
        sub bl,27
        cmp bl,0
        jg loop_forward
        
               
    get_to_front_lower:
        sub bl,27
        cmp bl,0
        jg loop_forward_upper
        
     get_to_back_upper:          
        add bl,27
        cmp bl,0
        jg loop_backward
        
               
    get_to_back_lower:
        add bl,27
        cmp bl,0
        jg loop_backward_upper
                      
    ;flush bx
    mov bx,0
    
    ;input a character
    mov ah,1
    int 21h
    mov bl,al      
               
    ;provide a new line:    
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
        jge complete_execution_upper
    
    ;define lowercase_to_uppercase
    lowercase_to_uppercase:
        sub bl,32
        
               
    ;check for lower_case letters as input
    complete_execution_lower:     
        ;move forward
        mov cx,0
        loop_Forward:
            add bl,1
            
            cmp bl,90
            jg get_to_front_upper 
            
            mov dl,bl 
            mov ah,2
            int 21h 
            add cl,1
            cmp cl,5
            jl loop_forward
        
        ;add a new line
        mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h            
        
        
        ;move backward
        mov cx,0
        sub bl,5
        loop_backward:
            sub bl,1
            
            cmp bl,65
            jl get_to_back_upper
            
            mov dl,bl 
            mov ah,2
            int 21h 
            add cl,1
            cmp cl,5
            jl loop_backward
            cmp bl,0
            jg exit
            
  
    ;check for upper_case letters as input
    complete_execution_upper:     
        ;move forward
        mov cx,0
        loop_Forward_upper:
            add bl,1
            
            cmp bl,122
            jg get_to_front_lower 
            
            mov dl,bl 
            mov ah,2
            int 21h 
            add cl,1
            cmp cl,5
            jl loop_forward_upper
        
        ;add a new line
        mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h            
        
        
        ;move backward
        mov cx,0
        sub bl,5
        loop_backward_upper:
            sub bl,1
            
            cmp bl,97
            jl get_to_back_lower
            
            mov dl,bl 
            mov ah,2
            int 21h 
            add cl,1
            cmp cl,5
            jl loop_backward_upper
            cmp bl,0
            jg exit 
        
        ;Return to DOS
        exit:
            mov ah,4ch
            int 21h 
        
    hlt
    
    
main endp
end main
ret




