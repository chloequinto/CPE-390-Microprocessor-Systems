;Write a program to add an array of N 8 bit numbers starting at address $1000 sand store the 16 bit sum
;at memory locations $1100~$11001. Use a "for i n1 to n2" looop construct

N:      EQU   20
        ORG   $1000
array:  DC.B  1,2,3,4,5,6,7,8,9,10,11,12
        DC.B  13,14,15,16,17,18,19,20
        ORG   $1100
sum:    DS.B  2
i:      DS.B  1

        ORG   $4000
        clr   i
        clr   sum
        clr   sum+1
        ldx   #array
loop:   ldaa  i
        cmpa  #N
        beq   done
        ldab  a,x 
        ldy   sum 
        aby   
        sty    sum
        inc     i
        bra     loop
doneL:  bgnd
        END
