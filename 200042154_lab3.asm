
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  
.model small
.stack 100h

.data
    input_string db 'We are IUT Students', 0Dh, 0Ah, '$'

.code
main proc
    mov ax, @data            ; load starting data segment address into ax
    mov ds, ax               ; move data segment address to ds

    ; display the string
    mov ah, 09h              ; set ah to display string function
    lea dx, input_string     ; load effective address of input_string into dx
    int 21h                  ; call DOS interrupt to display string

    ; calculate the number of characters 
    xor cx, cx               ; clear cx register
    mov si, offset input_string  ; point si to the input_string
count_chars:
    lodsb                    ; load character from si into al, and increment si
    cmp al, '$'              ; compare al with null terminator
    je end_count             ; jump to end if end of string
    inc cx                   ; increment character count
    jmp count_chars          ; repeat for next character

end_count:
    mov dl, cl               ; move character count to dl
    mov ah, 02h              ; set ah to display character function
    add dl, 30h              ; convert character count to ASCII
    int 21h                  ; call DOS interrupt to display character

    mov ah, 4Ch              ; set ah to terminate program function
    int 21h                  ; call DOS interrupt to terminate program
main endp

end main



ret




