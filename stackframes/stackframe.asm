;Draw the stack frame showing the position of the stack pointer and the address and contents
;of each byte on the stack (if known) at the end of the following instruction sequence

          lds       #$4700        ;load stack pointer with $4700
          ldab      #$2A          ;load accum. B with $2A
          pshb                    ;push B onto the stack 
          leas      -2,SP         ;load effective address onto the stack pointer 
          movw      #$239C,0,SP   ;move $239C to SP, without reserving anything
          ldaa      #$B5
          staa      2,SP
          tfr       A,D           ;Transfer 8 bit [A] to 16 bit [D]
                                  ;[A] = B5 which is a negative number
                                  ;To keep signs add FF 
          pshd      
          ldx       #$1234
          jsr       abc
          ...
          ...
abc:      leas      -3,SP
          pshx
          pula
          staa      2,SP
          pshx      
here:     bra       here
          
          
          
          
          
          
          
          
          
