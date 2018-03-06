space: 	EQU 	$20
CR:	EQU	$0D
LF:	EQU	$0A

	ORG 	$5000
ch_cnt: ds.b 	1 ;character count
wd_cnt: ds.b 	1 ;word count
str_x: 	dc.b 	"Mariam", 0
str_y:	dc.b	CR, LF, 0

	ORG 	$4000
	ldx 	#str_x ;X is character pointer
	jsr	count 
	ldaa	ch_cnt
	jsr	puthx8
	ldx	#str_y
	jsr	putstr
	ldaa	wd_cnt
	jsr	puthx8
	ldx	#str_y
	jsr	putstr
	swi

	ORG 	$6000
count:	clr	ch_cnt ;clear character count
	clr 	wd_cnt ;clear word count
str_lp: ldab 	1,x+ ;read a character
	beq 	done ;end of string?
	inc 	ch_cnt ;increment character count
	cmpb 	#space ;check for space character
	beq 	str_lp
	inc 	wd_cnt ;found non-space: must be at start of word
wd_lp: ldab 	1,x+ ;read a character
	beq 	done ;end of string?
	inc 	ch_cnt ;increment character count
	cmpb 	#space ;check for space character
	beq 	str_lp
	bra 	wd_lp ;non-space character is part of word
done:	rts	

SCIOSR1: EQU 	$00CC
SCIODRL: EQU 	$00CF
putstr: psha 	; output null terminated string to terminal
ploop: 	ldaa 	1, X+ ; X contains pointer to string
	beq 	pdone
	jsr 	putc
	bra 	ploop
	pdone: 	pula
	rts
putc: 	brclr 	SCIOSR1, $80, * ; output single character to terminal
	staa	SCIODRL
	rts

puthx8: 	psha ; output 8bit value in acc A as two hex digits
	lsra
	lsra
	lsra
	lsra
	jsr 	puthx4
	pula
	anda 	#$0F
	jsr 	puthx4
	rts
puthx4: cmpa 	#$A ; output 4-bit value in acc A as a hex character
	blo 	hxnum
	adda 	#$7
hxnum: 	adda 	#$30
	jsr 	putc
	rts