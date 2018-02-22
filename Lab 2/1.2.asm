	ORG	$5000
N:	EQU	20
DATA:	DC.B	$23, $74, $55, $C2, $00, $17, $F3, $BD, $A8, $38
	DC.B	$67, $97, $66, $08, $7A, $EF, $4B, $43, $1A, $28 

	ORG 	$5020

MAXS: 	DS.B 	1
MAXU:	DS.B	1


	ORG 	$6000
	movb	DATA, MAXS
	ldx	#DATA+1
	ldab	#N-1
loop:	ldaa	1, X+ 	
	cmpa	MAXS
	ble	skip
	staa	MAXS
skip:	dbne	b,loop
	
	movb	DATA, MAXU
	ldx	#DATA+1	
	ldab	#N-1
loop2: 	ldaa	1, X+
	cmpa	MAXU
	blo	skip2
	staa	MAXU
skip2:	dbne	b,loop2

	swi
		