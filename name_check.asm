;a certain programming language requires that variables names consist of only alphabetic characters(a-z, A-Z)
;Write a subroutine name_check to check the syntax of a variable name to make sure it only uses valid characters
;the variable name is passed to the subroutine as a string. A pointer to the string is passed in the register Y 
;the subroutine should count the number of invalid characters in the variable name and return the result in accum. B

;For example, the string "Maxval" would return zero because it is valid. The string "a+bc3" woudl return 2 because 
;there are two non-valid characters in the name 

;Note: the string pointer in Y should be return unmodified to the calling program. Save any registers you use 


name_check:   pshy
              pshx
              psha
              clrb 
loop:         ldaa  0, Y         ;load accumulator a with what Y is pointing to 
              cmpa  #0
              beq   done        ;Check for NULL 
              cmpa  #$40        ;Check if it is is not letters
              bhi   word
              incb
              bra   loop        ;branch always to loop 
  word        cmpa  #$5B
              blo   loop
              cmpa  #$60
              bhi   lowercase
              incb              ;add number 
              bra   loop
  lowercase:  cmpa  #$7A
              bls   loop
              incb
              bra   loop
  done:       pula  
              pulx 
              puly
              rts
