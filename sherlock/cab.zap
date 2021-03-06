

	.FUNCT	RT-AC-CH-HANSOM-CABBIE,CONTEXT
	EQUAL?	CONTEXT,K-M-WINNER \?CCL3
	EQUAL?	GL-PRSA,V?WAIT \?CCL6
	SET	'GL-WHERE-TO-PROMPT?,FALSE-VALUE
	SET	'GL-WHERE-TO-ORPH?,FALSE-VALUE
	PRINTI	"""Right-o."""
	CRLF	
	SET	'TH-HANSOM-CAB-AUX2,1
	ICALL2	RT-ALARM-CLR,RT-I-HANSOM-LEAVE
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,30,0
	CALL	RT-ALARM-SET-REL,RT-I-HANSOM-LEAVE,STACK
	RSTACK	
?CCL6:	EQUAL?	GL-PRSA,V?DRIVE,V?WALK-TO \?CCL8
	CALL1	RT-CF-TH-HANSOM-CAB
	RSTACK	
?CCL8:	EQUAL?	GL-PRSA,V?HELLO,V?GOODBYE,V?THANK \?CCL10
	SET	'GL-WINNER,CH-PLAYER
	CALL	RT-PERFORM,GL-PRSA,CH-HANSOM-CABBIE
	RSTACK	
?CCL10:	PRINTR	"""Sorry, guv. All I does is drives a cab."""
?CCL3:	EQUAL?	GL-PRSA,V?PAY \?PRD14
	ZERO?	GL-NOW-PRSI? /?CTR11
?PRD14:	EQUAL?	GL-PRSA,V?GIVE \?CCL12
	ZERO?	GL-NOW-PRSI? /?CCL12
	FSET?	GL-PRSO,FL-MONEY \?CCL12
?CTR11:	PRINTR	"""No thanks, guv'nor. It'll go on Mr 'Olmes's monthly account."""
?CCL12:	EQUAL?	GL-PRSA,V?TELL \?CCL21
	ZERO?	GL-NOW-PRSI? \?CCL21
	ZERO?	GL-P-CONT \FALSE
?CCL21:	EQUAL?	GL-PRSA,V?HELLO \?CCL26
	PRINTR	"""'Ello."""
?CCL26:	EQUAL?	GL-PRSA,V?GOODBYE \?CCL28
	PRINTR	"""Ta ta."""
?CCL28:	EQUAL?	GL-PRSA,V?THANK \?CCL30
	PRINTR	"""Anytime, mate."""
?CCL30:	CALL1	RT-TALK-VERB?
	ZERO?	STACK /FALSE
	PRINTR	"""Sorry, sir. No time to chat."""


	.FUNCT	RT-AC-CH-GROWLER-CABBIE,CONTEXT
	EQUAL?	CONTEXT,K-M-WINNER \?CCL3
	EQUAL?	GL-PRSA,V?WAIT \?CCL6
	SET	'GL-WHERE-TO-PROMPT?,FALSE-VALUE
	SET	'GL-WHERE-TO-ORPH?,FALSE-VALUE
	ICALL2	RT-CTHEO-PRINT,CH-GROWLER-CABBIE
	PRINTR	" says brightly, ""Okay."""
?CCL6:	EQUAL?	GL-PRSA,V?DRIVE,V?WALK-TO \?CCL8
	CALL1	RT-CF-TH-GROWLER-CAB
	RSTACK	
?CCL8:	ICALL2	RT-CTHEO-PRINT,CH-GROWLER-CABBIE
	PRINTR	" says brightly, ""Hello,"" and looks at you expectantly."
?CCL3:	EQUAL?	GL-PRSA,V?PAY \?PRD12
	ZERO?	GL-NOW-PRSI? /?CTR9
?PRD12:	EQUAL?	GL-PRSA,V?GIVE \?CCL10
	ZERO?	GL-NOW-PRSI? /?CCL10
	FSET?	GL-PRSO,FL-MONEY \?CCL10
?CTR9:	ICALL2	RT-CTHEO-PRINT,CH-GROWLER-CABBIE
	PRINTR	" says brightly, ""No thanks. I'm not in it for the money. I just like to meet new people."""
?CCL10:	EQUAL?	GL-PRSA,V?TELL \?CCL19
	ZERO?	GL-NOW-PRSI? \?CCL19
	ZERO?	GL-P-CONT \FALSE
?CCL19:	CALL1	RT-TALK-VERB?
	ZERO?	STACK /FALSE
	ICALL2	RT-CTHEO-PRINT,CH-GROWLER-CABBIE
	PRINTR	" says brightly, ""Hello,"" and looks at you expectantly."


	.FUNCT	RT-GET-ROOM-ID,HERE,TBL
	INTBL?	HERE,CAB-ROOM-IDS,CAB-ROOM-IDS-LEN,1 >TBL \FALSE
	LESS?	CAB-ROOM-IDS,0 \?CCL6
	SUB	TBL,CAB-ROOM-IDS
	ADD	STACK,1
	RSTACK	
?CCL6:	SUB	CAB-ROOM-IDS,TBL
	ADD	STACK,1
	RSTACK	


	.FUNCT	RT-CAB-DIST,HERE,THERE,NUM1,NUM2,PTR,TMP
	CALL2	RT-GET-ROOM-ID,HERE >NUM1
	CALL2	RT-GET-ROOM-ID,THERE >NUM2
	EQUAL?	HERE,THERE /FALSE
	EQUAL?	NUM1,NUM2 /FALSE
	LESS?	NUM1,NUM2 \?CND5
	SET	'TMP,NUM1
	SET	'NUM1,NUM2
	SET	'NUM2,TMP
?CND5:	SUB	NUM1,2 >NUM1
?PRG7:	LESS?	NUM1,1 /?REP8
	ADD	PTR,NUM1 >PTR
	DEC	'NUM1
	JUMP	?PRG7
?REP8:	SUB	NUM2,1
	ADD	PTR,STACK >PTR
	GETB	GL-CAB-DIST-TBL,PTR
	RSTACK	


	.FUNCT	RT-I-CAB-ARRIVE,CAB,PLACE,NUM,SCORE,AUX1
	SET	'NUM,TH-CAB-WHISTLE-AUX1
	SET	'PLACE,TH-CAB-WHISTLE-AUX2
	SET	'TH-CAB-WHISTLE-AUX1,0
	SET	'TH-CAB-WHISTLE-AUX2,0
	EQUAL?	GL-PLACE-CUR,PLACE \FALSE
	EQUAL?	GL-PRSA,V?WALK /FALSE
	EQUAL?	NUM,1 \?CCL8
	SET	'CAB,TH-GROWLER-CAB
	SET	'SCORE,0
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,5,0
	ICALL	RT-ALARM-SET-REL,RT-I-GROWLER-LEAVE,STACK
	ICALL2	RT-REMOVE-ALL,TH-GROWLER-CAB
	MOVE	CH-GROWLER-CABBIE,TH-GROWLER-CAB
	FSET	CH-GROWLER-CABBIE,FL-SEEN
	JUMP	?CND6
?CCL8:	EQUAL?	NUM,2 \FALSE
	SET	'CAB,TH-HANSOM-CAB
	SET	'SCORE,5
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,5,0
	ICALL	RT-ALARM-SET-REL,RT-I-HANSOM-LEAVE,STACK
	ICALL2	RT-REMOVE-ALL,TH-HANSOM-CAB
	MOVE	CH-HANSOM-CABBIE,TH-HANSOM-CAB
	FSET	CH-HANSOM-CABBIE,FL-SEEN
?CND6:	ZERO?	SOUND-QUEUED? \?CND11
	SET	'CAB-RAMP,2
	ICALL1	RT-S-CAB-ARRIVES
?CND11:	CRLF	
	PRINTI	"A "
	ICALL2	DPRINT,CAB
	PRINTI	" pulls up beside you."
	CRLF	
	MOVE	CAB,GL-PLACE-CUR
	EQUAL?	CAB,TH-HANSOM-CAB \?CCL15
	SET	'AUX1,TH-HANSOM-CAB-AUX1
	JUMP	?CND13
?CCL15:	SET	'AUX1,TH-GROWLER-CAB-AUX1
?CND13:	ZERO?	AUX1 \TRUE
	EQUAL?	CAB,TH-HANSOM-CAB \?CCL20
	SET	'TH-HANSOM-CAB-AUX1,1
	JUMP	?CND18
?CCL20:	SET	'TH-GROWLER-CAB-AUX1,1
?CND18:	ZERO?	SCORE /TRUE
	ICALL2	RT-UPDATE-SCORE,SCORE
	RTRUE	


	.FUNCT	RT-I-HANSOM-LEAVE
	EQUAL?	GL-PLACE-CUR,RM-VICTORIA-SQUARE /?CND1
	CALL2	RT-VISIBLE?,TH-HANSOM-CAB
	ZERO?	STACK /?CND3
	ICALL1	RT-S-CAB-LEAVES
	ICALL2	RT-CTHEO-PRINT,TH-HANSOM-CAB
	PRINTI	" drives off."
	CRLF	
?CND3:	MOVE	TH-HANSOM-CAB,RM-VICTORIA-SQUARE
	ICALL2	RT-REMOVE-ALL,TH-HANSOM-CAB
	MOVE	CH-HANSOM-CABBIE,TH-HANSOM-CAB
	CALL1	RT-IS-LIT? >GL-NOW-LIT?
?CND1:	SET	'TH-HANSOM-CAB-AUX2,0
	RFALSE	


	.FUNCT	RT-I-HANSOM-TO?
	IN?	CH-PLAYER,TH-HANSOM-CAB \FALSE
	PRINTI	"""Where to mister?"""
	CRLF	
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,1,0
	CALL	RT-ALARM-SET-REL,RT-I-HANSOM-TO?,STACK
	RSTACK	


	.FUNCT	RT-I-GROWLER-LEAVE
	EQUAL?	GL-PLACE-CUR,RM-OXFORD-ST /FALSE
	CALL2	RT-VISIBLE?,TH-GROWLER-CAB
	ZERO?	STACK /?CND3
	ICALL1	RT-S-CAB-LEAVES
	ICALL2	RT-CTHEO-PRINT,TH-GROWLER-CAB
	PRINTI	" drives off."
	CRLF	
?CND3:	MOVE	TH-GROWLER-CAB,RM-OXFORD-ST
	ICALL2	RT-REMOVE-ALL,TH-GROWLER-CAB
	MOVE	CH-GROWLER-CABBIE,TH-GROWLER-CAB
	CALL1	RT-IS-LIT? >GL-NOW-LIT?
	RFALSE	


	.FUNCT	RT-I-GROWLER-TO?
	IN?	CH-PLAYER,TH-GROWLER-CAB \FALSE
	CRLF	
	PRINTI	"Suddenly the cabbie - who seems to have a low threshold of boredom - pipes up and says, ""I know where we can go!"""
	CRLF	
	CRLF	
	PRINT	K-WILD-RIDE-MSG
	CRLF	
	ICALL1	RT-MOVE-GROWLER
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,5,0
	ICALL	RT-ALARM-SET-REL,RT-I-GROWLER-TO?,STACK
	CRLF	
	CALL1	RT-DESC-ALL
	RSTACK	


	.FUNCT	RT-MOVE-HANSOM,ROOM,MIN
	EQUAL?	GL-PLACE-CUR,ROOM \?CCL3
	PRINTR	"""We're already here, guv."""
?CCL3:	ZERO?	ROOM /FALSE
	SET	'GL-WHERE-TO-PROMPT?,FALSE-VALUE
	SET	'GL-WHERE-TO-ORPH?,FALSE-VALUE
	CALL	RT-CAB-DIST,GL-PLACE-CUR,ROOM
	MUL	STACK,K-HANSOM-TIME >MIN
	PRINTI	"""Right-o."""
	CRLF	
	CRLF	
	MOVE	TH-HANSOM-CAB,ROOM
	SET	'GL-PLACE-PRV,GL-PLACE-CUR
	SET	'GL-PLACE-CUR,ROOM
	IN?	CH-PLAYER,TH-HANSOM-CAB \?CCL8
	SET	'GL-PUPPY-MSG?,FALSE-VALUE
	EQUAL?	ROOM,RM-COVENT-GARDEN \?CCL11
	SET	'LOOPING?,S-CROWD
	SET	'LOOP-VOL,8
	JUMP	?CND9
?CCL11:	SET	'LOOPING?,FALSE-VALUE
?CND9:	ICALL	SOUNDS,S-HORSE,S-START,4,6
	PRINTI	"The cab speeds through the streets, "
	CALL1	RT-TIME-OF-DAY
	EQUAL?	STACK,1,2,3 \?CND12
	PRINTI	"deftly weaving in and out of the jubilee traffic and "
?CND12:	PRINTI	"whizzing past famous landmarks. Only a few minutes later, you arrive at your destination."
	CRLF	
	CRLF	
	ICALL1	RT-DESC-ALL
	JUMP	?CND6
?CCL8:	ICALL1	RT-S-CAB-LEAVES
	PRINTI	"The cab drives off."
	CRLF	
	CALL1	RT-IS-LIT? >GL-NOW-LIT?
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,30,0
	ICALL	RT-ALARM-SET-REL,RT-I-HANSOM-LEAVE,STACK
?CND6:	ICALL2	RT-ALARM-CLR,RT-I-HANSOM-LEAVE
	ICALL	RT-CLOCK-JMP,0,MIN,0
	RTRUE	


	.FUNCT	RT-MOVE-GROWLER,ROOM,NUM,MIN
	RANDOM	37 >NUM
	EQUAL?	NUM,1 \?CCL3
	SET	'ROOM,RM-AUDLEY-ST
	JUMP	?CND1
?CCL3:	EQUAL?	NUM,2 \?CCL5
	SET	'ROOM,RM-221B-BAKER-ST
	JUMP	?CND1
?CCL5:	EQUAL?	NUM,3 \?CCL7
	SET	'ROOM,RM-BIRDCAGE-WALK
	JUMP	?CND1
?CCL7:	EQUAL?	NUM,5 \?CCL9
	SET	'ROOM,RM-BROAD-SANCTUARY
	JUMP	?CND1
?CCL9:	EQUAL?	NUM,6 \?CCL11
	SET	'ROOM,RM-BUCKINGHAM-PALACE-RD
	JUMP	?CND1
?CCL11:	EQUAL?	NUM,7 \?CCL13
	SET	'ROOM,RM-CHEAPSIDE
	JUMP	?CND1
?CCL13:	EQUAL?	NUM,8 \?CCL15
	SET	'ROOM,RM-COVENT-GARDEN
	JUMP	?CND1
?CCL15:	EQUAL?	NUM,9 \?CCL17
	SET	'ROOM,RM-THE-EMBANKMENT
	JUMP	?CND1
?CCL17:	EQUAL?	NUM,10 \?CCL19
	SET	'ROOM,RM-FLEET-STREET
	JUMP	?CND1
?CCL19:	EQUAL?	NUM,11 \?CCL21
	SET	'ROOM,RM-GREAT-RUSSELL-ST
	JUMP	?CND1
?CCL21:	EQUAL?	NUM,12 \?CCL23
	SET	'ROOM,RM-GROSVENOR-PLACE
	JUMP	?CND1
?CCL23:	EQUAL?	NUM,13 \?CCL25
	SET	'ROOM,RM-HYDE-PARK-CORNER
	JUMP	?CND1
?CCL25:	EQUAL?	NUM,14 \?CCL27
	SET	'ROOM,RM-KENSINGTON-GARDENS
	JUMP	?CND1
?CCL27:	EQUAL?	NUM,15 \?CCL29
	SET	'ROOM,RM-KING-WILLIAM-ST
	JUMP	?CND1
?CCL29:	EQUAL?	NUM,16 \?CCL31
	SET	'ROOM,RM-LONDON-BRIDGE
	JUMP	?CND1
?CCL31:	EQUAL?	NUM,17 \?CCL33
	SET	'ROOM,RM-LOWER-THAMES-ST
	JUMP	?CND1
?CCL33:	EQUAL?	NUM,18 \?CCL35
	SET	'ROOM,RM-THE-MALL
	JUMP	?CND1
?CCL35:	EQUAL?	NUM,19 \?CCL37
	SET	'ROOM,RM-MARYLEBONE-RD
	JUMP	?CND1
?CCL37:	EQUAL?	NUM,20 \?CCL39
	SET	'ROOM,RM-MONUMENT
	JUMP	?CND1
?CCL39:	EQUAL?	NUM,21 \?CCL41
	SET	'ROOM,RM-NEW-OXFORD-ST
	JUMP	?CND1
?CCL41:	EQUAL?	NUM,22 \?CCL43
	SET	'ROOM,RM-OXFORD-ST
	JUMP	?CND1
?CCL43:	EQUAL?	NUM,23 \?CCL45
	SET	'ROOM,RM-ORCHARD-ST
	JUMP	?CND1
?CCL45:	EQUAL?	NUM,24 \?CCL47
	SET	'ROOM,RM-PARLIAMENT-SQUARE
	JUMP	?CND1
?CCL47:	EQUAL?	NUM,25 \?CCL49
	SET	'ROOM,RM-PINCHIN-LANE
	JUMP	?CND1
?CCL49:	EQUAL?	NUM,26 \?CCL51
	SET	'ROOM,RM-QUEENS-GARDENS
	JUMP	?CND1
?CCL51:	EQUAL?	NUM,27 \?CCL53
	SET	'ROOM,RM-ST-GILES-CIRCUS
	JUMP	?CND1
?CCL53:	EQUAL?	NUM,28 \?CCL55
	SET	'ROOM,RM-THE-STRAND
	JUMP	?CND1
?CCL55:	EQUAL?	NUM,29 \?CCL57
	SET	'ROOM,RM-THREADNEEDLE-ST
	JUMP	?CND1
?CCL57:	EQUAL?	NUM,30 \?CCL59
	SET	'ROOM,RM-TOTTENHAM-COURT-RD
	JUMP	?CND1
?CCL59:	EQUAL?	NUM,31 \?CCL61
	SET	'ROOM,RM-TOWER-ENTRANCE
	JUMP	?CND1
?CCL61:	EQUAL?	NUM,32 \?CCL63
	SET	'ROOM,RM-TRAFALGAR-SQUARE
	JUMP	?CND1
?CCL63:	EQUAL?	NUM,33 \?CCL65
	SET	'ROOM,RM-UPPER-THAMES-ST
	JUMP	?CND1
?CCL65:	EQUAL?	NUM,34 \?CCL67
	SET	'ROOM,RM-VICTORIA-STREET
	JUMP	?CND1
?CCL67:	EQUAL?	NUM,35 \?CCL69
	SET	'ROOM,RM-VICTORIA-SQUARE
	JUMP	?CND1
?CCL69:	EQUAL?	NUM,36 \?CCL71
	SET	'ROOM,RM-WHITEHALL
	JUMP	?CND1
?CCL71:	EQUAL?	NUM,37 \?CCL73
	SET	'ROOM,RM-YORK-PLACE
	JUMP	?CND1
?CCL73:	PRINTI	"This is odd..."
	CRLF	
	CRLF	
	SET	'ROOM,RM-KENSINGTON-GARDENS
?CND1:	CALL	RT-CAB-DIST,GL-PLACE-CUR,ROOM
	MUL	STACK,K-GROWLER-TIME >MIN
	EQUAL?	ROOM,RM-COVENT-GARDEN \?CCL76
	SET	'LOOPING?,S-CROWD
	SET	'LOOP-VOL,8
	JUMP	?CND74
?CCL76:	SET	'LOOPING?,FALSE-VALUE
?CND74:	ICALL	SOUNDS,S-HORSE,S-START,4,6
	MOVE	TH-GROWLER-CAB,ROOM
	SET	'GL-PLACE-PRV,GL-PLACE-CUR
	SET	'GL-PLACE-CUR,ROOM
	SET	'GL-PUPPY-MSG?,FALSE-VALUE
	CALL	RT-CLOCK-JMP,0,MIN,0
	RSTACK	


	.FUNCT	RT-CF-TH-HANSOM-CAB,CONTEXT,WRD,ADJ
	IN?	CH-PLAYER,TH-HANSOM-CAB \?CND1
	SET	'GL-WHERE-TO-PROMPT?,TRUE-VALUE
	SET	'GL-WHERE-TO-ORPH?,TRUE-VALUE
?CND1:	EQUAL?	GL-PRSA,V?WALK \?CCL5
	EQUAL?	GL-P-WALK-DIR,P?OUT \?CCL5
	CALL	RT-PERFORM,V?EXIT,TH-HANSOM-CAB
	RSTACK	
?CCL5:	EQUAL?	GL-PRSA,V?WALK \?PRD11
	EQUAL?	GL-WINNER,CH-PLAYER /?CTR8
?PRD11:	EQUAL?	GL-PRSA,V?ENTER \?CCL9
	EQUAL?	GL-PRSO,TH-HANSOM-CAB /?CCL9
?CTR8:	ICALL1	RT-CYOU-MSG
	ICALL	RT-WOULD-HAVE-TO-MSG,STR?797,TH-HANSOM-CAB
	PRINTR	" first."
?CCL9:	EQUAL?	GL-PRSA,V?DRIVE,V?WALK-TO \?CCL17
	GET	GL-P-NAMW,0 >WRD
	GET	GL-P-ADJW,0 >ADJ
	EQUAL?	GL-PRSO,RM-AUDLEY-ST \?CCL20
	CALL2	RT-MOVE-HANSOM,RM-AUDLEY-ST
	RSTACK	
?CCL20:	EQUAL?	GL-PRSO,RM-221B-BAKER-ST,RM-ENTRY-HALL \?CCL22
	CALL2	RT-MOVE-HANSOM,RM-221B-BAKER-ST
	RSTACK	
?CCL22:	EQUAL?	GL-PRSO,RM-BIRDCAGE-WALK \?CCL24
	CALL2	RT-MOVE-HANSOM,RM-BIRDCAGE-WALK
	RSTACK	
?CCL24:	EQUAL?	GL-PRSO,RM-BROAD-SANCTUARY,LG-TOMBS-ABBEY \?CCL26
	CALL2	RT-MOVE-HANSOM,RM-BROAD-SANCTUARY
	RSTACK	
?CCL26:	EQUAL?	GL-PRSO,RM-BUCKINGHAM-PALACE-RD \?CCL28
	CALL2	RT-MOVE-HANSOM,RM-BUCKINGHAM-PALACE-RD
	RSTACK	
?CCL28:	EQUAL?	GL-PRSO,RM-CHEAPSIDE \?CCL30
	CALL2	RT-MOVE-HANSOM,RM-CHEAPSIDE
	RSTACK	
?CCL30:	EQUAL?	GL-PRSO,RM-COVENT-GARDEN \?CCL32
	CALL2	RT-MOVE-HANSOM,RM-COVENT-GARDEN
	RSTACK	
?CCL32:	EQUAL?	GL-PRSO,RM-THE-EMBANKMENT,LG-WATER \?CCL34
	CALL2	RT-MOVE-HANSOM,RM-THE-EMBANKMENT
	RSTACK	
?CCL34:	EQUAL?	GL-PRSO,RM-FLEET-STREET \?CCL36
	CALL2	RT-MOVE-HANSOM,RM-FLEET-STREET
	RSTACK	
?CCL36:	EQUAL?	GL-PRSO,RM-GREAT-RUSSELL-ST,RM-BRITISH-MUSEUM \?CCL38
	CALL2	RT-MOVE-HANSOM,RM-GREAT-RUSSELL-ST
	RSTACK	
?CCL38:	EQUAL?	GL-PRSO,RM-GROSVENOR-PLACE \?CCL40
	CALL2	RT-MOVE-HANSOM,RM-GROSVENOR-PLACE
	RSTACK	
?CCL40:	EQUAL?	GL-PRSO,RM-HYDE-PARK-CORNER \?CCL42
	CALL2	RT-MOVE-HANSOM,RM-HYDE-PARK-CORNER
	RSTACK	
?CCL42:	EQUAL?	GL-PRSO,RM-KENSINGTON-GARDENS \?CCL44
	CALL2	RT-MOVE-HANSOM,RM-KENSINGTON-GARDENS
	RSTACK	
?CCL44:	EQUAL?	GL-PRSO,RM-KING-WILLIAM-ST \?CCL46
	CALL2	RT-MOVE-HANSOM,RM-KING-WILLIAM-ST
	RSTACK	
?CCL46:	EQUAL?	GL-PRSO,RM-LONDON-BRIDGE \?CCL48
	CALL2	RT-MOVE-HANSOM,RM-LONDON-BRIDGE
	RSTACK	
?CCL48:	EQUAL?	GL-PRSO,RM-LOWER-THAMES-ST,RM-BAR-OF-GOLD,RM-SWAN-LANE \?CCL50
	CALL2	RT-MOVE-HANSOM,RM-LOWER-THAMES-ST
	RSTACK	
?CCL50:	EQUAL?	GL-PRSO,RM-THE-MALL \?CCL52
	CALL2	RT-MOVE-HANSOM,RM-THE-MALL
	RSTACK	
?CCL52:	EQUAL?	GL-PRSO,RM-MARYLEBONE-RD,RM-MADAME-TUSSAUDS \?CCL54
	CALL2	RT-MOVE-HANSOM,RM-MARYLEBONE-RD
	RSTACK	
?CCL54:	EQUAL?	WRD,W?MONUMENT \?PRD58
	EQUAL?	ADJ,FALSE-VALUE /?CTR55
?PRD58:	EQUAL?	GL-PRSO,RM-MONUMENT \?CCL56
?CTR55:	CALL2	RT-MOVE-HANSOM,RM-MONUMENT
	RSTACK	
?CCL56:	EQUAL?	GL-PRSO,RM-NEW-OXFORD-ST \?CCL62
	CALL2	RT-MOVE-HANSOM,RM-NEW-OXFORD-ST
	RSTACK	
?CCL62:	EQUAL?	WRD,W?STREET,W?ST \?PRD66
	EQUAL?	ADJ,W?OXFORD /?CTR63
?PRD66:	EQUAL?	GL-PRSO,RM-OXFORD-ST \?CCL64
?CTR63:	CALL2	RT-MOVE-HANSOM,RM-OXFORD-ST
	RSTACK	
?CCL64:	EQUAL?	GL-PRSO,RM-ORCHARD-ST \?CCL70
	CALL2	RT-MOVE-HANSOM,RM-ORCHARD-ST
	RSTACK	
?CCL70:	EQUAL?	GL-PRSO,RM-PARLIAMENT-SQUARE,RM-PARLIAMENT,TH-BELL \?CCL72
	CALL2	RT-MOVE-HANSOM,RM-PARLIAMENT-SQUARE
	RSTACK	
?CCL72:	EQUAL?	GL-PRSO,RM-PINCHIN-LANE,RM-SHERMANS-HOUSE \?CCL74
	CALL2	RT-MOVE-HANSOM,RM-PINCHIN-LANE
	RSTACK	
?CCL74:	EQUAL?	GL-PRSO,RM-QUEENS-GARDENS,RM-BUCKINGHAM-PALACE \?CCL76
	CALL2	RT-MOVE-HANSOM,RM-QUEENS-GARDENS
	RSTACK	
?CCL76:	EQUAL?	GL-PRSO,RM-ST-GILES-CIRCUS \?CCL78
	CALL2	RT-MOVE-HANSOM,RM-ST-GILES-CIRCUS
	RSTACK	
?CCL78:	EQUAL?	GL-PRSO,RM-THE-STRAND \?CCL80
	CALL2	RT-MOVE-HANSOM,RM-THE-STRAND
	RSTACK	
?CCL80:	EQUAL?	GL-PRSO,RM-THREADNEEDLE-ST,RM-BANK-OF-ENGLAND \?CCL82
	CALL2	RT-MOVE-HANSOM,RM-THREADNEEDLE-ST
	RSTACK	
?CCL82:	EQUAL?	GL-PRSO,RM-TOTTENHAM-COURT-RD \?CCL84
	CALL2	RT-MOVE-HANSOM,RM-TOTTENHAM-COURT-RD
	RSTACK	
?CCL84:	EQUAL?	WRD,W?TOWER /?CTR85
	EQUAL?	GL-PRSO,RM-TOWER-ENTRANCE,LG-TOWER,RM-DRAWBRIDGE \?CCL86
?CTR85:	CALL2	RT-MOVE-HANSOM,RM-TOWER-ENTRANCE
	RSTACK	
?CCL86:	EQUAL?	GL-PRSO,RM-TRAFALGAR-SQUARE,RM-DIOGENES-CLUB \?CCL90
	CALL2	RT-MOVE-HANSOM,RM-TRAFALGAR-SQUARE
	RSTACK	
?CCL90:	EQUAL?	GL-PRSO,RM-UPPER-THAMES-ST \?CCL92
	CALL2	RT-MOVE-HANSOM,RM-UPPER-THAMES-ST
	RSTACK	
?CCL92:	EQUAL?	GL-PRSO,RM-VICTORIA-STREET \?CCL94
	CALL2	RT-MOVE-HANSOM,RM-VICTORIA-STREET
	RSTACK	
?CCL94:	EQUAL?	GL-PRSO,RM-VICTORIA-SQUARE \?CCL96
	CALL2	RT-MOVE-HANSOM,RM-VICTORIA-SQUARE
	RSTACK	
?CCL96:	EQUAL?	GL-PRSO,RM-WHITEHALL,RM-SCOTLAND-YARD \?CCL98
	CALL2	RT-MOVE-HANSOM,RM-WHITEHALL
	RSTACK	
?CCL98:	EQUAL?	GL-PRSO,RM-YORK-PLACE \FALSE
	CALL2	RT-MOVE-HANSOM,RM-YORK-PLACE
	RSTACK	
?CCL17:	EQUAL?	GL-PRSA,V?STAND,V?STAND-ON,V?LEAP \?CCL102
	PRINT	K-ENOUGH-ROOM-MSG
	CRLF	
	RTRUE	
?CCL102:	EQUAL?	GL-PRSA,V?SIT \?CCL104
	PRINTR	"You're already seated."
?CCL104:	CALL1	RT-TOUCH-VERB?
	ZERO?	STACK /FALSE
	EQUAL?	GL-PRSO,FALSE-VALUE,ROOMS /?CND107
	IN?	GL-PRSO,GLOBAL-OBJECTS /?CND107
	CALL	RT-META-IN?,GL-PRSO,TH-HANSOM-CAB
	ZERO?	STACK \?CND107
	ICALL1	RT-CYOU-MSG
	PRINTI	"cannot reach "
	ICALL1	RT-THEO-PRINT
	PRINTR	"."
?CND107:	EQUAL?	GL-PRSI,FALSE-VALUE,ROOMS /FALSE
	IN?	GL-PRSI,GLOBAL-OBJECTS /FALSE
	FSET?	GL-PRSI,FL-PERSON \?CCL119
	IN?	GL-PRSI,GL-PLACE-CUR /FALSE
?CCL119:	CALL	RT-META-IN?,GL-PRSI,TH-HANSOM-CAB
	ZERO?	STACK \FALSE
	ICALL1	RT-CYOU-MSG
	PRINTI	"cannot reach "
	ICALL1	RT-THEI-PRINT
	PRINTR	"."


	.FUNCT	RT-CF-TH-GROWLER-CAB,CONTEXT
	IN?	CH-PLAYER,TH-GROWLER-CAB \?CND1
	SET	'GL-WHERE-TO-PROMPT?,TRUE-VALUE
	SET	'GL-WHERE-TO-ORPH?,TRUE-VALUE
?CND1:	EQUAL?	GL-PRSA,V?WALK \?CCL5
	EQUAL?	GL-P-WALK-DIR,P?OUT \?CCL5
	CALL	RT-PERFORM,V?EXIT,TH-GROWLER-CAB
	RSTACK	
?CCL5:	EQUAL?	GL-PRSA,V?WALK \?PRD11
	EQUAL?	GL-WINNER,CH-PLAYER /?CTR8
?PRD11:	EQUAL?	GL-PRSA,V?ENTER \?CCL9
	EQUAL?	GL-PRSO,TH-GROWLER-CAB /?CCL9
?CTR8:	ICALL1	RT-CYOU-MSG
	ICALL	RT-WOULD-HAVE-TO-MSG,STR?797,TH-GROWLER-CAB
	PRINTR	" first."
?CCL9:	EQUAL?	GL-PRSA,V?DRIVE,V?WALK-TO \?CCL17
	PRINTI	"""Oh good! I've never been THERE before."""
	CRLF	
	CRLF	
	SET	'GL-WHERE-TO-PROMPT?,FALSE-VALUE
	SET	'GL-WHERE-TO-ORPH?,FALSE-VALUE
	ICALL2	RT-ALARM-CLR,RT-I-GROWLER-TO?
	ICALL2	RT-ALARM-CLR,RT-I-GROWLER-LEAVE
	ICALL1	RT-MOVE-GROWLER
	IN?	CH-PLAYER,TH-GROWLER-CAB \?CCL20
	SET	'GL-PUPPY-MSG?,FALSE-VALUE
	PRINT	K-WILD-RIDE-MSG
	CRLF	
	CRLF	
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,5,0
	ICALL	RT-ALARM-SET-REL,RT-I-GROWLER-TO?,STACK
	ICALL1	RT-DESC-ALL
	RTRUE	
?CCL20:	PRINTI	"The cab drives off."
	CRLF	
	CALL1	RT-IS-LIT? >GL-NOW-LIT?
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,30,0
	ICALL	RT-ALARM-SET-REL,RT-I-GROWLER-LEAVE,STACK
	RTRUE	
?CCL17:	EQUAL?	GL-PRSA,V?STAND,V?STAND-ON,V?LEAP \?CCL22
	PRINT	K-ENOUGH-ROOM-MSG
	CRLF	
	RTRUE	
?CCL22:	EQUAL?	GL-PRSA,V?SIT \?CCL24
	PRINTR	"You're already seated."
?CCL24:	CALL1	RT-TOUCH-VERB?
	ZERO?	STACK /FALSE
	EQUAL?	GL-PRSO,FALSE-VALUE,ROOMS /?CND27
	IN?	GL-PRSO,GLOBAL-OBJECTS /?CND27
	CALL	RT-META-IN?,GL-PRSO,TH-GROWLER-CAB
	ZERO?	STACK \?CND27
	ICALL1	RT-CYOU-MSG
	PRINTI	"cannot reach "
	ICALL1	RT-THEO-PRINT
	PRINTR	"."
?CND27:	EQUAL?	GL-PRSI,FALSE-VALUE,ROOMS /FALSE
	IN?	GL-PRSI,GLOBAL-OBJECTS /FALSE
	CALL	RT-META-IN?,GL-PRSI,TH-GROWLER-CAB
	ZERO?	STACK \FALSE
	ICALL1	RT-CYOU-MSG
	PRINTI	"cannot reach "
	ICALL1	RT-THEI-PRINT
	PRINTR	"."


	.FUNCT	RT-BLOW-WHISTLE,WHO,WHO2,L,?TMP1
	LOC	TH-HANSOM-CAB >?TMP1
	LOC	TH-GROWLER-CAB
	EQUAL?	GL-PLACE-CUR,?TMP1,STACK \?CCL3
	PRINT	K-CAB-HERE-MSG
	CRLF	
	RTRUE	
?CCL3:	PRINTI	"Tweeeeeeeeee!"
	CRLF	
	FSET?	GL-PLACE-CUR,FL-INDOORS \?CCL6
	EQUAL?	GL-PLACE-CUR,RM-HOLMES-STUDY \?CND7
	FSET?	CH-HOLMES,FL-ASLEEP \?CND7
	PRINT	K-HOLMES-DISTRACTION-MSG
	CRLF	
	RTRUE	
?CND7:	CALL1	RT-ANYONE-HERE? >WHO
	ZERO?	WHO /TRUE
	LOC	WHO >L
	REMOVE	WHO
	CALL1	RT-ANYONE-HERE? >WHO2
	ZERO?	WHO2 /?CCL15
	PRINTI	"Everyone holds their hands to their "
	JUMP	?CND13
?CCL15:	ICALL2	RT-CTHEO-PRINT,WHO
	PRINTI	" hold"
	ICALL2	RT-S-NOS-MSG,WHO
	PRINTC	32
	ICALL2	RT-YOUR-MSG,WHO
	PRINTI	"hands to "
	ICALL2	RT-YOUR-MSG,WHO
?CND13:	MOVE	WHO,L
	PRINTI	"ears and glare"
	ICALL2	RT-S-NOS-MSG,WHO
	PRINTR	" at you."
?CCL6:	EQUAL?	GL-PLACE-CUR,RM-TOWER-GREEN,RM-OUTER-WARD,RM-BYWARD-TOWER /TRUE
	EQUAL?	GL-PLACE-CUR,RM-INSIDE-TRAITORS-GATE,RM-OUTSIDE-TRAITORS-GATE,RM-DRAWBRIDGE /TRUE
	EQUAL?	GL-PLACE-CUR,RM-THAMES-ONE,RM-THAMES-TWO,RM-THAMES-THREE /TRUE
	EQUAL?	GL-PLACE-CUR,RM-THAMES-FOUR,RM-THAMES-FIVE,RM-SWAN-LANE /TRUE
	INC	'TH-CAB-WHISTLE-AUX1
	SET	'TH-CAB-WHISTLE-AUX2,GL-PLACE-CUR
	CALL2	RT-ALARM-SET?,RT-I-CAB-ARRIVE
	ZERO?	STACK \TRUE
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,1,0
	ICALL	RT-ALARM-SET-REL,RT-I-CAB-ARRIVE,STACK
	RTRUE	


	.FUNCT	RT-AC-TH-HANSOM-CAB,CONTEXT
	EQUAL?	CONTEXT,K-M-DESCFCN \?CCL3
	PRINTR	"It is a small cab with two wheels and room for only two persons, drawn by a single horse."
?CCL3:	EQUAL?	GL-PRSA,V?ENTER \?CCL5
	EQUAL?	GL-PRSO,ROOMS,TH-HANSOM-CAB \?CCL5
	FSET?	TH-SUIT-OF-ARMOUR,FL-WORN \?CCL10
	PRINT	K-HEAVY-ARMOUR-MSG
	CRLF	
	RTRUE	
?CCL10:	IN?	GL-WINNER,TH-HANSOM-CAB /FALSE
	MOVE	GL-WINNER,TH-HANSOM-CAB
	ZERO?	GL-PUPPY /?CCL15
	EQUAL?	GL-WINNER,CH-PLAYER \?CCL15
	MOVE	GL-PUPPY,TH-HANSOM-CAB
	PRINTI	"You and "
	ICALL2	RT-THEO-PRINT,GL-PUPPY
	PRINTI	" get "
	JUMP	?CND13
?CCL15:	ICALL	RT-CYOU-MSG,STR?753,STR?754
?CND13:	FSET	TH-HANSOM-CAB,FL-NODESC
	ICALL2	RT-ALARM-CLR,RT-I-HANSOM-LEAVE
	SET	'TH-HANSOM-CAB-AUX2,0
	SET	'GL-WHERE-TO-PROMPT?,TRUE-VALUE
	SET	'GL-WHERE-TO-ORPH?,TRUE-VALUE
	PRINTR	"into the cab."
?CCL5:	EQUAL?	GL-PRSA,V?EXIT \?CCL19
	EQUAL?	GL-PRSO,ROOMS,TH-HANSOM-CAB \?CCL19
	IN?	CH-PLAYER,TH-HANSOM-CAB \FALSE
	MOVE	GL-WINNER,GL-PLACE-CUR
	ZERO?	GL-PUPPY /?CCL27
	EQUAL?	GL-WINNER,CH-PLAYER \?CCL27
	MOVE	GL-PUPPY,GL-PLACE-CUR
	PRINTI	"You and "
	ICALL2	RT-THEO-PRINT,GL-PUPPY
	PRINTI	" get "
	JUMP	?CND25
?CCL27:	ICALL	RT-CYOU-MSG,STR?753,STR?754
?CND25:	PRINTI	"out of the cab."
	FCLEAR	TH-HANSOM-CAB,FL-NODESC
	ZERO?	TH-HANSOM-CAB-AUX2 \?CND30
	IN?	CH-PLAYER,TH-HANSOM-CAB /?CND30
	ZERO?	GL-PUPPY /?PRD35
	IN?	GL-PUPPY,TH-HANSOM-CAB /?CND30
?PRD35:	EQUAL?	GL-PLACE-CUR,RM-VICTORIA-SQUARE /?CND30
	PRINTI	" After"
	ICALL	RT-YOU-MSG,STR?753,STR?754
	PRINTI	"out, it drives off."
	ICALL1	RT-S-CAB-LEAVES
	MOVE	TH-HANSOM-CAB,RM-VICTORIA-SQUARE
	ICALL2	RT-REMOVE-ALL,TH-HANSOM-CAB
	MOVE	CH-HANSOM-CABBIE,TH-HANSOM-CAB
	ICALL2	RT-ALARM-CLR,RT-I-HANSOM-LEAVE
	CALL1	RT-IS-LIT? >GL-NOW-LIT?
?CND30:	SET	'GL-WHERE-TO-PROMPT?,FALSE-VALUE
	SET	'GL-WHERE-TO-ORPH?,FALSE-VALUE
	CRLF	
	RTRUE	
?CCL19:	EQUAL?	GL-PRSA,V?LOOK-ON \?CCL39
	PRINTR	"There is a cab driver sitting on the hansom."
?CCL39:	EQUAL?	GL-PRSA,V?TAKE,V?PUSH-TO \?CCL41
	ZERO?	GL-NOW-PRSI? \?CCL41
	PRINT	K-TAKE-CAB-MSG
	CRLF	
	RETURN	2
?CCL41:	EQUAL?	GL-PRSA,V?SHOOT \FALSE
	CALL1	RT-WASTE-OF-BULLETS-MSG
	RSTACK	


	.FUNCT	RT-AC-TH-GROWLER-CAB,CONTEXT
	EQUAL?	CONTEXT,K-M-DESCFCN \?CCL3
	PRINTR	"It is a large cab with four wheels and room for four persons, drawn by a single horse."
?CCL3:	EQUAL?	GL-PRSA,V?ENTER \?CCL5
	EQUAL?	GL-PRSO,ROOMS,TH-GROWLER-CAB \?CCL5
	FSET?	TH-SUIT-OF-ARMOUR,FL-WORN \?CCL10
	PRINT	K-HEAVY-ARMOUR-MSG
	CRLF	
	RTRUE	
?CCL10:	IN?	GL-WINNER,TH-GROWLER-CAB /FALSE
	MOVE	GL-WINNER,TH-GROWLER-CAB
	ZERO?	GL-PUPPY /?CCL15
	EQUAL?	GL-WINNER,CH-PLAYER \?CCL15
	MOVE	GL-PUPPY,TH-GROWLER-CAB
	PRINTI	"You and "
	ICALL2	RT-THEO-PRINT,GL-PUPPY
	PRINTI	" get "
	JUMP	?CND13
?CCL15:	ICALL	RT-CYOU-MSG,STR?753,STR?754
?CND13:	FSET	TH-GROWLER-CAB,FL-NODESC
	ICALL2	RT-ALARM-CLR,RT-I-GROWLER-LEAVE
	CALL	RT-DO-CLOCK-SET,GL-TIME-PARM,0,5,0
	ICALL	RT-ALARM-SET-REL,RT-I-GROWLER-TO?,STACK
	SET	'GL-WHERE-TO-PROMPT?,TRUE-VALUE
	SET	'GL-WHERE-TO-ORPH?,TRUE-VALUE
	PRINTR	"into the cab."
?CCL5:	EQUAL?	GL-PRSA,V?EXIT \?CCL19
	EQUAL?	GL-PRSO,ROOMS,TH-GROWLER-CAB \?CCL19
	IN?	CH-PLAYER,TH-GROWLER-CAB \FALSE
	MOVE	GL-WINNER,GL-PLACE-CUR
	ZERO?	GL-PUPPY /?CCL27
	EQUAL?	GL-WINNER,CH-PLAYER \?CCL27
	MOVE	GL-PUPPY,GL-PLACE-CUR
	PRINTI	"You and "
	ICALL2	RT-THEO-PRINT,GL-PUPPY
	PRINTI	" get "
	JUMP	?CND25
?CCL27:	ICALL	RT-CYOU-MSG,STR?753,STR?754
?CND25:	PRINTI	"out of the cab."
	FCLEAR	TH-GROWLER-CAB,FL-NODESC
	IN?	CH-PLAYER,TH-GROWLER-CAB /?CND30
	ZERO?	GL-PUPPY /?PRD34
	IN?	GL-PUPPY,TH-GROWLER-CAB /?CND30
?PRD34:	EQUAL?	GL-PLACE-CUR,RM-OXFORD-ST /?CND30
	PRINTI	" After"
	ICALL	RT-YOU-MSG,STR?753,STR?754
	PRINTI	"out, it drives off."
	ICALL1	RT-S-CAB-LEAVES
	MOVE	TH-GROWLER-CAB,RM-OXFORD-ST
	ICALL2	RT-REMOVE-ALL,TH-GROWLER-CAB
	MOVE	CH-GROWLER-CABBIE,TH-GROWLER-CAB
	ICALL2	RT-ALARM-CLR,RT-I-GROWLER-LEAVE
	ICALL2	RT-ALARM-CLR,RT-I-GROWLER-TO?
	CALL1	RT-IS-LIT? >GL-NOW-LIT?
?CND30:	SET	'GL-WHERE-TO-PROMPT?,FALSE-VALUE
	SET	'GL-WHERE-TO-ORPH?,FALSE-VALUE
	CRLF	
	RTRUE	
?CCL19:	EQUAL?	GL-PRSA,V?LOOK-ON \?CCL38
	PRINTR	"There is a cab driver sitting on the growler."
?CCL38:	EQUAL?	GL-PRSA,V?TAKE,V?PUSH-TO \?CCL40
	ZERO?	GL-NOW-PRSI? \?CCL40
	PRINT	K-TAKE-CAB-MSG
	CRLF	
	RETURN	2
?CCL40:	EQUAL?	GL-PRSA,V?SHOOT \FALSE
	CALL1	RT-WASTE-OF-BULLETS-MSG
	RSTACK	


	.FUNCT	RT-AC-TH-CAB-WHISTLE
	EQUAL?	GL-PRSA,V?BLOW-INTO \?CCL3
	ZERO?	GL-NOW-PRSI? \?CCL3
	CALL1	RT-BLOW-WHISTLE
	RSTACK	
?CCL3:	EQUAL?	GL-PRSA,V?CALL \?CCL7
	ZERO?	GL-NOW-PRSI? /?CCL7
	EQUAL?	GL-PRSO,TH-HANSOM-CAB \?CCL12
	ICALL1	RT-BLOW-WHISTLE
	CALL2	RT-ALARM-SET?,RT-I-CAB-ARRIVE
	ZERO?	STACK /TRUE
	ICALL	RT-DO-CLOCK-SET,GL-TIME-UPDT-INC,0,2,0
	ICALL1	RT-BLOW-WHISTLE
	RTRUE	
?CCL12:	EQUAL?	GL-PRSO,TH-GROWLER-CAB \?CCL16
	ICALL1	RT-BLOW-WHISTLE
	CALL2	RT-ALARM-SET?,RT-I-CAB-ARRIVE
	ZERO?	STACK /TRUE
	ICALL	RT-DO-CLOCK-SET,GL-TIME-UPDT-INC,0,2,0
	RTRUE	
?CCL16:	GET	GL-P-NAMW,0
	EQUAL?	STACK,W?CAB \?CCL20
	CALL1	RT-BLOW-WHISTLE
	RSTACK	
?CCL20:	ICALL1	RT-CYOU-MSG
	PRINTI	"can't "
	PRINTB	GL-P-PRSA-WORD
	PRINTC	32
	ICALL1	RT-A-PRINT
	PRINTI	" with "
	ICALL1	RT-THEI-PRINT
	PRINTR	"."
?CCL7:	EQUAL?	GL-PRSA,V?SHOOT \FALSE
	CALL1	RT-WASTE-OF-BULLETS-MSG
	RSTACK	

	.ENDI
