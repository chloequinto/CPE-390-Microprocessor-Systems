;a 24 element arry of 16 bit unsigned integers is stored in memory at a location DATA. 
;Write an instruction sequence to find the average of these 24 integers, rounded to the nearest integer
;and storing the 16 bit result in the memory location labeled result. 
;You can assume that the sume of the 24 integers does not overflow a 16 bit result


      ldx   #24
      ldy   #DATA
      dex               ;decrement x by 1 
loop: addd  2, Y+       ;add to accum D with [Y], post increment by 2
      dbne  X, loop     ;branch if counter (X) is not equal to 23 (or keep looping till 23)
      addd  #12         ;add to accum D (divident/2)  
      idiv  #24         ;unsigned 16 by 16 divide
      stx   RESULT      ;store the result in RESULT
      swi             
      
      
      
;Now assume that DATA is a 24 element array of signed integers. Modify your code to give the average of the absolute
;values of these integers

;TO DO:
;Check if it is negative, if so negate. Otherwise load into accum D

;When testing a signed or unsinged you need to have two instructions a COMPARE and a TEST 


      ldx   #25
      ldy   #DATA
      dex               ;decrement [x] by 1    
loop: ldd  2,Y+         ;add values to accum D 
      cpd   #0          ;compare value to zero 
      bge   POS         ;branch if value is positive
      nega              ;otherwise negate MSB
      negb              ;otherwise negate LSB
      std   2,Y+        ;store values in accum D 
POS:  std   2,Y+
      dbne  X, loop
      ldx   #25
      ldy   #DATA
loop2: addd  2,Y+
      dbne  X, loop2
      addd  #12
      ldx   #24
      idivs             ;signed division  
      stx   RESULT
      swi
      
      
      
      
