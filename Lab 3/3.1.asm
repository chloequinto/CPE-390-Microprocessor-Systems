N: 	EQU 	15 ; length of array
NFC: 	EQU 	$FF ; not-found code
key: 	EQU 	$190
CR: 	EQU 	$0D ; ASCII return
LF: 	EQU 	$0A ; ASCII line feed

	ORG	 $5000
result: DS.B 	1 ;reserve a byte for result
vecx: 	DC.W 	$D1A, $B5, $39F, $980, $E4F, $186, $E3, $319, $430
	DC.W 	$4, $190, $22C, $189, $A55, $30D
str1: 	DC.B 	"Key found", CR, LF, 0
str2: 	DC.B 	"Key not found", CR, LF, 0
str3: 	DC.B 	"Index = $", 0
str4:	DC.B	CR, LF, 0

	
	ORG	$4000
	clrb 			;initialize index = 0
	movb 	#NFC, result 	; initialize search result
	ldy 	#key 		; set key we’re searching for
	ldx 	#vecx 		; set up X as pointer to array
loop: 	tfr 	B, A 		; copy index to A
	lsla 			; and multiply by 2 to give byte offset
	cpy 	A, X 		; compare key to array element
	beq 	found 		; branch if element = key
	incb 			; if not – increment indexe
	cmpb 	#N 		; are we at the end of the array yet?
	bne 	loop 		; no – go check next value
	ldx 	#str2 		; yes - we’re done without finding key
	jsr 	putstr
	bra 	done
found: 	stab 	result 		; write index into result
	ldx 	#str1
	jsr	putstr
	ldx 	#str3
	jsr	putstr
	ldaa	result 
	jsr	puthx8	
	ldx 	#str4
	jsr	putstr
	
done: 	swi 			; return to monitor

SCIOSR1: EQU 	$00CC
SCIODRL: EQU	$00CF

putstr:	psha			;output null terminated string to terminal 
ploop:	ldaa	1, X+		;X contains pointer to string
	beq	pdone
	jsr	putc
	bra 	ploop
pdone:	pula
	rts

putc: 	brclr	SCIOSR1, $80, *	;output single character to terminal 
	staa	SCIODRL
	rts 	
puthx8: psha 			; output 8bit value in acc A as two hex digits
	lsra
	lsra
	lsra
	lsra
	jsr 	puthx4	
	pula
	anda	 #$0F
	jsr 	puthx4
	rts
puthx4: cmpa 	#$A 	; output 4-bit value in acc A as a hex character
	blo 	hxnum
	adda 	#$7
hxnum: 	adda 	#$30
	jsr 	putc
	rts
