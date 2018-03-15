;Write a program to count the number of 0's in the 16 bit number stored at $800 to $801

        ORG     $800
numb:   DC.W    $2355
        ORG     $900
zeros:  DS.B    1
lp_cnt: DS.B    1

        ORG     $4000
        clr     zeros
        movb    #16, lp_count
        ldd     numb
loop:   lsrd    
        bcs     skip    ;branch if equal to 1 
        inc     zeros 
skip:   dec     lp_cnt   ;increment pointer 
        bne     loop
here:   bra     here
