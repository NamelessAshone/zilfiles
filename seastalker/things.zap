

	.FUNCT	RANDOM-PSEUDO
	PRINTR	"You can't do anything useful with that."


	.FUNCT	NOT-HERE-OBJECT-F,TBL,PRSO?=1,OBJ
	EQUAL?	PRSO,NOT-HERE-OBJECT \?ELS3
	EQUAL?	PRSI,NOT-HERE-OBJECT \?ELS3
	PRINTI	"(Those things aren't here!)"
	CRLF	
	RETURN	2
?ELS3:	EQUAL?	PRSO,NOT-HERE-OBJECT \?ELS11
	SET	'TBL,P-PRSO
	JUMP	?CND1
?ELS11:	SET	'TBL,P-PRSI
	SET	'PRSO?,FALSE-VALUE
?CND1:	EQUAL?	PRSA,V?SEARCH-FOR,V?ASK-FOR,V?ASK-ABOUT \?CND14
	FSET?	PRSO,PERSON \?CND14
	IN?	PRSO,GLOBAL-OBJECTS \?CND14
	PRINTD	PRSO
	CALL	NOT-HERE-PERSON,PRSO
?CND14:	ZERO?	PRSO? /?ELS23
	EQUAL?	PRSA,V?ASK-CONTEXT-ABOUT,V?BOARD /?THN28
	EQUAL?	PRSA,V?ASK-CONTEXT-FOR,V?TAKE-WITH /?THN28
	EQUAL?	PRSA,V?FIND,V?FOLLOW,V?USE /?THN28
	EQUAL?	PRSA,V?LEAVE,V?DISEMBARK,V?PHONE /?THN28
	EQUAL?	PRSA,V?THROUGH,V?WALK-TO,V?WHAT /?THN28
	EQUAL?	PRSA,V?BRING,V?TAKE,V?SSHOW \?CND21
	EQUAL?	WINNER,PLAYER /?CND21
?THN28:	CALL	FIND-NOT-HERE,TBL,PRSO? >OBJ
	ZERO?	OBJ /FALSE
	EQUAL?	OBJ,NOT-HERE-OBJECT /?CND21
	RETURN	2
?ELS23:	EQUAL?	PRSA,V?ASK-ABOUT,V?ASK-FOR,V?TAKE-TO /?THN47
	EQUAL?	PRSA,V?SEARCH-FOR,V?TELL-ABOUT /?THN47
	EQUAL?	PRSA,V?SBRING,V?SHOW \?CND21
	EQUAL?	WINNER,PLAYER /?CND21
?THN47:	CALL	FIND-NOT-HERE,TBL,PRSO? >OBJ
	ZERO?	OBJ /FALSE
	EQUAL?	OBJ,NOT-HERE-OBJECT /?CND21
	RETURN	2
?CND21:	PRINTI	"(You can't see any"
	CALL	NOT-HERE-PRINT
	PRINTI	" here!)"
	CRLF	
	RETURN	2


	.FUNCT	FIND-NOT-HERE,TBL,PRSO?,M-F,OBJ,PERSON?=1
	CALL	MOBY-FIND,TBL >M-F
	ZERO?	DEBUG /?CND1
	PRINTI	"[Found "
	PRINTN	M-F
	PRINTI	" objects]"
	CRLF	
?CND1:	EQUAL?	1,M-F \?ELS11
	ZERO?	DEBUG /?CND12
	PRINTI	"[Namely: "
	PRINTD	P-MOBY-FOUND
	PRINTI	"]"
	CRLF	
?CND12:	ZERO?	PRSO? /?ELS20
	SET	'PRSO,P-MOBY-FOUND
	RFALSE	
?ELS20:	SET	'PRSI,P-MOBY-FOUND
	RFALSE	
?ELS11:	LESS?	1,M-F \?ELS25
	GET	TBL,1 >OBJ
	GETP	OBJ,P?GENERIC
	CALL	STACK,OBJ >OBJ
	ZERO?	OBJ /?ELS25
	ZERO?	DEBUG /?CND28
	PRINTI	"[Generic: "
	PRINTD	OBJ
	PRINTI	"]"
	CRLF	
?CND28:	EQUAL?	OBJ,NOT-HERE-OBJECT /TRUE
	ZERO?	PRSO? /?ELS38
	SET	'PRSO,OBJ
	RFALSE	
?ELS38:	SET	'PRSI,OBJ
	RFALSE	
?ELS25:	ZERO?	PRSO? \?ELS47
	IN?	PRSO,HERE \?ELS47
	EQUAL?	PRSA,V?TELL-ABOUT,V?ASK-FOR,V?ASK-ABOUT /?THN52
?ELS47:	ZERO?	PRSO? /?ELS49
	CALL	QCONTEXT-GOOD?
	ZERO?	STACK /?ELS49
	EQUAL?	PRSA,V?ASK-CONTEXT-FOR,V?ASK-CONTEXT-ABOUT /?THN52
?ELS49:	EQUAL?	WINNER,PLAYER /?ELS43
	EQUAL?	PRSA,V?SGIVE /?THN52
	EQUAL?	PRSA,V?GIVE,V?WHAT,V?FIND \?ELS43
?THN52:	EQUAL?	PRSA,V?ASK-FOR,V?ASK-ABOUT \?ELS56
	FSET?	PRSO,PERSON /?CND57
	SET	'PERSON?,FALSE-VALUE
	PRINTI	"The "
?CND57:	PRINTD	PRSO
	JUMP	?CND54
?ELS56:	CALL	QCONTEXT-GOOD?
	ZERO?	STACK /?ELS65
	FSET?	QCONTEXT,PERSON /?CND66
	SET	'PERSON?,FALSE-VALUE
	PRINTI	"The "
?CND66:	PRINTD	QCONTEXT
	JUMP	?CND54
?ELS65:	EQUAL?	WINNER,PLAYER /?ELS74
	PRINTD	WINNER
	JUMP	?CND54
?ELS74:	CALL	FIND-FLAG,HERE,PERSON,PLAYER >OBJ
	ZERO?	OBJ /?ELS78
	PRINTD	OBJ
	JUMP	?CND54
?ELS78:	CALL	VISIBLE?,TIP
	ZERO?	STACK /?ELS82
	PRINTI	"Tip"
	JUMP	?CND54
?ELS82:	PRINTI	"Someone"
?CND54:	ZERO?	PERSON? \?ELS91
	PRINTI	" isn't connected to any"
	JUMP	?CND89
?ELS91:	PRINTI	" looks confused. ""I don't know anything about any"
?CND89:	CALL	NOT-HERE-PRINT
	PRINTI	"!"
	ZERO?	PERSON? /?CND100
	PRINTI	""""
?CND100:	CRLF	
	RTRUE	
?ELS43:	ZERO?	PRSO? \?ELS107
	PRINTI	"You wouldn't find any"
	CALL	NOT-HERE-PRINT
	PRINTR	" there."
?ELS107:	RETURN	NOT-HERE-OBJECT


	.FUNCT	NOT-HERE-PRINT,?TMP1
	ZERO?	P-OFLAG \?THN6
	ZERO?	P-MERGED /?ELS5
?THN6:	ZERO?	P-XADJ /?CND8
	PRINTI	" "
	PRINTB	P-XADJN
?CND8:	ZERO?	P-XNAM /FALSE
	PRINTI	" "
	PRINTB	P-XNAM
	RTRUE	
?ELS5:	EQUAL?	PRSO,NOT-HERE-OBJECT \?ELS23
	GET	P-ITBL,P-NC1 >?TMP1
	GET	P-ITBL,P-NC1L
	CALL	BUFFER-PRINT,?TMP1,STACK,FALSE-VALUE
	RSTACK	
?ELS23:	GET	P-ITBL,P-NC2 >?TMP1
	GET	P-ITBL,P-NC2L
	CALL	BUFFER-PRINT,?TMP1,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	THE?,NOUN
	FSET?	NOUN,PERSON \?ELS9
	EQUAL?	NOUN,PLAYER \TRUE
?ELS9:	FSET?	NOUN,NARTICLEBIT /TRUE
	PRINTI	" the"
	RTRUE	


	.FUNCT	NOTEBOOK-F
	EQUAL?	PRSA,V?TELL-ABOUT,V?ANALYZE /?THN6
	EQUAL?	PRSA,V?EXAMINE,V?READ,V?OPEN \FALSE
?THN6:	PRINTI	"(You'll find the "
	PRINTD	NOTEBOOK
	PRINTI	" in your "
	PRINTD	GAME
	PRINTR	" package.)"


	.FUNCT	MAGAZINE-F
	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE \?ELS5
	CALL	NOT-HOLDING?,MAGAZINE
	ZERO?	STACK \TRUE
?ELS5:	EQUAL?	PRSA,V?LOOK-UP \?ELS12
	EQUAL?	PRSO,GLOBAL-THORPE \?ELS12
	CALL	PERFORM,V?READ,ARTICLE
	RTRUE	
?ELS12:	EQUAL?	PRSA,V?ANALYZE,V?EXAMINE,V?READ \FALSE
	CALL	NOT-HOLDING?,MAGAZINE
	ZERO?	STACK \TRUE
	PRINTI	"""Science World"" is a popular "
	PRINTD	MAGAZINE
	PRINTI	" about new scientific developments.
The cover shows "
	PRINTD	GLOBAL-THORPE
	PRINTR	", marine biologist, surrounded by imaginative drawings of weird undersea life forms. The cover says:
""HOT FLASH FROM THE MARINE BIOLOGY FRONT!
... NEW SEA CREATURES SPAWNED BY TEST TUBE?
(SEE ARTICLE INSIDE)"""


	.FUNCT	ARTICLE-F
	CALL	DIVESTMENT?,ARTICLE
	ZERO?	STACK /?ELS5
	CALL	PERFORM,PRSA,MAGAZINE,PRSI
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?ANALYZE /?THN8
	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE,V?READ \FALSE
?THN8:	CALL	NOT-HOLDING?,MAGAZINE
	ZERO?	STACK \TRUE
	PRINTI	"It says that "
	PRINTD	GLOBAL-THORPE
	PRINTI	" may have created synthetic forms of marine life by genetic engineering. You learn that Thorpe went into hiding to duck publicity, but before that he told friends he would soon marry "
	PRINTD	SHARON
	PRINTR	".
The form of the creatures is unknown. They may be stimulated by ultrasonic pulses and might be trained to respond to such pulses.
Some scientists are skeptical, but Thorpe has claimed that one-celled organisms had evolved in his lab from AMINO-HYDROPHASE or A.H. If rumors are true, these synthetic sea creatures should be based on the A.H. molecule."


	.FUNCT	CATALYST-CAPSULE-F
	EQUAL?	PRSA,V?COMPARE \?ELS5
	EQUAL?	PRSI,CATALYST-CAPSULE \?ELS11
	EQUAL?	PRSO,REACTOR /?THN8
?ELS11:	EQUAL?	PRSO,CATALYST-CAPSULE \?ELS5
	EQUAL?	PRSI,REACTOR \?ELS5
?THN8:	PRINTI	"It looks as if the "
	PRINTD	CATALYST-CAPSULE
	PRINTI	" fits perfectly into the "
	PRINTD	REACTOR
	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?FIND \?ELS17
	FSET?	CATALYST-CAPSULE,TOUCHBIT /?ELS17
	PRINTI	"The capsule is usually stored on a "
	PRINTD	WORK-COUNTER
	PRINTR	" on the west wall of the tank area."
?ELS17:	EQUAL?	PRSA,V?PUT \?ELS23
	EQUAL?	PRSI,LOCAL-SUB,GLOBAL-SUB \?ELS23
	PRINTR	"You'll have to take it there yourself."
?ELS23:	EQUAL?	PRSA,V?TAKE \FALSE
	FSET?	CATALYST-CAPSULE,TRYTAKEBIT \FALSE
	PRINTR	"It's too hot to pick up."


	.FUNCT	GENERIC-OXYGEN-GEAR-F,OBJ
	CALL	REMOTE-VERB?
	ZERO?	STACK /?ELS5
	RETURN	OXYGEN-GEAR
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	ZERO?	PRSI /FALSE
	FSET?	PRSI,PERSON \FALSE
	EQUAL?	PRSI,ANTRIM,SIEGEL,HORVAK \?ELS14
	RETURN	OXYGEN-GEAR-OTHER
?ELS14:	EQUAL?	PRSI,LOWELL,GREENUP \?ELS16
	RETURN	OXYGEN-GEAR-DIVER
?ELS16:	EQUAL?	PRSI,BLY \FALSE
	RETURN	OXYGEN-GEAR-BLY


	.FUNCT	OXYGEN-GEAR-GLOBAL-F
	ZERO?	SUB-IN-DOME /?THN6
	CALL	FIND-FLAG,HERE,PERSON,WINNER
	ZERO?	STACK \?ELS5
?THN6:	CALL	NOT-HERE,OXYGEN-GEAR-OTHER
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE,V?TELL-ABOUT,V?SEARCH-FOR /FALSE
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT /FALSE
	CALL	YOU-CANT
	RSTACK	


	.FUNCT	OXYGEN-GEAR-F
	CALL	REMOTE-VERB?
	ZERO?	STACK \FALSE
	FCLEAR	OXYGEN-GEAR,NDESCBIT
	EQUAL?	PRSA,V?TAKE \?ELS8
	EQUAL?	PRSO,OXYGEN-GEAR \?ELS8
	CALL	ITAKE
	EQUAL?	STACK,TRUE-VALUE \TRUE
	PRINTI	"You're now wearing"
	CALL	THE-PRSO-PRINT
	PRINTR	" around your neck."
?ELS8:	EQUAL?	PRSA,V?OPEN /?THN18
	EQUAL?	PRSA,V?USE,V?TURN,V?LAMP-ON \?ELS17
?THN18:	FSET?	OXYGEN-GEAR,ONBIT \?ELS22
	CALL	ALREADY,OXYGEN-GEAR,STR?42
	RTRUE	
?ELS22:	CALL	NOT-HOLDING?,OXYGEN-GEAR
	ZERO?	STACK \TRUE
	ZERO?	DOME-AIR-BAD? \?CND20
	PRINTR	"You don't need it now!"
?CND20:	FSET	OXYGEN-GEAR,ONBIT
	PRINTI	"As you open the valve and suck on the rubber straw, you feel your lungs filling with pure oxygen."
	ZERO?	DOME-AIR-BAD? /?CND31
	CALL	CORRIDOR-LOOK,BLY
	ZERO?	STACK /?CND31
	CRLF	
	PRINTI	"But you notice Zoe Bly collapsing, and you realize she has no "
	PRINTD	OXYGEN-GEAR
	PRINTI	"!"
?CND31:	CRLF	
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?CLOSE \FALSE
	CALL	PERFORM,V?LAMP-OFF,OXYGEN-GEAR
	RTRUE	


	.FUNCT	BADGE-PLAYER-F
	CALL	DIVESTMENT?,BADGE-PLAYER
	ZERO?	STACK /?ELS5
	PRINTR	"That wouldn't be good for security."
?ELS5:	EQUAL?	PRSA,V?READ,V?EXAMINE,V?ANALYZE \FALSE
	PRINTI	"It's a special identification badge for"
	CALL	RESEARCH-LAB
	PRINTR	"."


	.FUNCT	GENERIC-TOOL-F,OBJ
	EQUAL?	PRSA,V?TAKE-WITH,V?OPEN-WITH \FALSE
	RETURN	UNIVERSAL-TOOL


	.FUNCT	V-$BAY
	ZERO?	SUB-IN-TANK \?CND1
	PRINTR	"too late"
?CND1:	SET	'HERE,SUB
	MOVE	PLAYER,SUB
	MOVE	TIP,SUB
	MOVE	CATALYST-CAPSULE,REACTOR
	FCLEAR	REACTOR,OPENBIT
	FSET	REACTOR,ONBIT
	FSET	ENGINE,ONBIT
	FCLEAR	SUB-DOOR,OPENBIT
	SET	'MONSTER-GONE,TRUE-VALUE
	SET	'JOYSTICK-DIR,P?EAST
	SET	'SUB-DLON,1
	SET	'SUB-DLAT,0
	SET	'NOW-TERRAIN,BAY-TERRAIN
	SET	'SUB-IN-TANK,FALSE-VALUE
	CALL	QUEUE,I-UPDATE-SUB-POSITION,-1
	PUT	STACK,0,1
	RTRUE	

	.ENDI