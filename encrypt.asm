;Write a subroutine to encypt a message stored as a string. Assume the message consists of only upper
;case characters and spaces. The message is encryped by replacing each upper case character and spaces. 
;The message is encrypted by replacing each uppercase character with a new character that is advanced by n(positive)
;places in the alphabet. For example, if n=2, then 'A' is replaced by 'C' and 'P' to 'R' 
;The mapping should wrap around from 'Z' to 'A'. For example if n=3, then 'Y' should be 'B'. Spaces should be 
;replaced by $

;a pointer to the string to be encrypted is passed in register Y. The value of n is passed in accumulator B

;the encrypted string should be returned to the caller by overwriting the input string. You should save any registers 
;modified by the subroutine
encrypt:  pshb
          psha            ;use it load push new characters 
loop:     lda   0,Y       ;load characters 
          beq   END       ;check for null
          cpma  #$20      ;check for space 
          bne   add       ;if not a space go to add
          movb  #$24, Y+  ;Change spaces to $, then increment 
          bra   loop
add:      aba
          cmpa  #$5A      ;checks if character is Z
          bls   skip      ;branch if lower or same to skip
          suba  #26       ;wrap around
slip      sta   1,Y+      ;store it in accumulator a 
          bra   loop      ;go back to loop
END       pula
          pulb
          rts
          
;To further confuse would be interceptors, modify your encoding algorithm to increase the coding offset by one for each character
;encoded (so the first character is offset by n, the second character is offset (n+1)
encrypt:  pshb
          psha
          decb
loop:     lda   0,Y
          beq   NULL
          incb
          cmpa  #$20
          bne   ADD
          movb  #$24, 1, Y+
          bra   loop
add:      aba
          cmpa  #$5A
          bls   SKIP
          suba  #26
SKIP:     sta   1,Y+
          bra   loop
NULL:     pula
          pulb 
          rts
      
