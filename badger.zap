
	.SEGMENT "TOWN"


	.FUNCT	RT-GN-DEN:ANY:2:2,R,T
	RETURN	RM-HOLE


	.FUNCT	RT-RM-BADGER-TUNNEL:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-B-LOOK /?CTR2
	EQUAL?	CONTEXT,M-LOOK \?CCL3
?CTR2:	PRINTI	"You are in a den of twisty little passages - all alike. Tunnels exit in all directions. "
	CALL1	RT-NUM-MARKS-MSG
	RSTACK	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL7
	EQUAL?	PRSA,V?SCRATCH,V?DIG \FALSE
	EQUAL?	PRSO,FALSE-VALUE,ROOMS,TH-GROUND /?CCL10
	EQUAL?	PRSO,TH-SKY,HERE,GLOBAL-HERE /?CCL10
	EQUAL?	PRSO,LG-WALL \FALSE
?CCL10:	GRTR?	GL-TUNNEL-NUM,0 \FALSE
	GETB	K-TUNNEL-CNT-TBL,GL-TUNNEL-NUM
	ICALL2	RT-MAKE-MARK,STACK
	RTRUE	
?CCL7:	EQUAL?	CONTEXT,M-ENTER \?CCL20
	SET	'GL-PICTURE-NUM,K-PIC-HOLE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CND21
	ICALL1	RT-UPDATE-PICT-WINDOW
?CND21:	EQUAL?	OHERE,RM-HOLE \?CCL25
	SET	'GL-TUNNEL-NUM,1
	RFALSE	
?CCL25:	EQUAL?	OHERE,RM-THORNEY-ISLAND \FALSE
	SET	'GL-TUNNEL-NUM,10
	RFALSE	
?CCL20:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-MAKE-MARK:ANY:1:2,COUNT,N
	ASSIGNED?	'N /?CND1
	SET	'N,1
?CND1:	ADD	COUNT,N >COUNT
	PUTB	K-TUNNEL-CNT-TBL,GL-TUNNEL-NUM,COUNT
	GRTR?	COUNT,11 \?CCL5
	PRINTI	"You scratch at the dirt with your claw. A trickle starts to fall from the ceiling, and then suddenly the wall collapses. In a matter of seconds, you are buried alive, with no hope of digging your way out.
"
	ICALL1	RT-END-OF-GAME
	RETURN	COUNT
?CCL5:	EQUAL?	COUNT,11 \?CCL7
	PRINTI	"You add an eleventh claw mark alongside the others. You have scraped so much dirt from the wall that another scratch might bring the entire warren down around your ears.
"
	RETURN	COUNT
?CCL7:	EQUAL?	COUNT,1 \?CCL9
	PRINTI	"You make a distinct claw mark in the dirt.
"
	RETURN	COUNT
?CCL9:	PRINTI	"You add another claw mark next to the"
	SUB	COUNT,N
	ICALL2	RT-WORD-NUMBERS,STACK
	PRINTI	" already in the dirt.
"
	RETURN	COUNT


	.FUNCT	RT-NUM-MARKS-MSG:ANY:0:0,COUNT
	GETB	K-TUNNEL-CNT-TBL,GL-TUNNEL-NUM >COUNT
	ZERO?	COUNT \?CCL3
	PRINTR	"The soft earthen walls of the den are smooth and even."
?CCL3:	PRINTI	"In the dirt you can see"
	EQUAL?	COUNT,1 \?CCL6
	PRINTI	" a distinct"
	JUMP	?CND4
?CCL6:	ICALL2	RT-WORD-NUMBERS,COUNT
?CND4:	PRINTI	" claw mark"
	EQUAL?	COUNT,1 /?CND7
	PRINTC	115
?CND7:	PRINTR	"."


	.FUNCT	RT-WALK-TUNNEL:ANY:0:1,QUIET,TBL,N
	ZERO?	QUIET \FALSE
	EQUAL?	P-WALK-DIR,P?OUT \?CCL5
	EQUAL?	GL-TUNNEL-NUM,10 \?CCL8
	SET	'GL-TUNNEL-NUM,0
	RETURN	RM-THORNEY-ISLAND
?CCL8:	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINT	K-WHICH-DIR-MSG
	RFALSE	
?CCL5:	GET	K-TUNNEL-DIR-TBL,0 >TBL
	INTBL?	P-WALK-DIR,TBL,10 >N \?CCL11
	SUB	N,TBL
	DIV	STACK,2 >N
	JUMP	?CND9
?CCL11:	SET	'N,-1
?CND9:	GET	K-TUNNEL-DIR-TBL,GL-TUNNEL-NUM >TBL
	GETB	TBL,N >GL-TUNNEL-NUM
	ZERO?	GL-TUNNEL-NUM \?CCL14
	SET	'GL-TUNNEL-NUM,0
	RETURN	RM-HOLE
?CCL14:	EQUAL?	GL-TUNNEL-NUM,11 \?CCL16
	SET	'GL-TUNNEL-NUM,0
	RETURN	RM-THORNEY-ISLAND
?CCL16:	ICALL2	RT-RM-BADGER-TUNNEL,M-V-LOOK
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \FALSE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RFALSE	


	.FUNCT	RT-RM-THORNEY-ISLAND:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are"
	JUMP	?CND4
?CCL6:	PRINTI	"poke your head out of the badger hole and look around. Seeing no one, you crawl out of the hole and find yourself"
?CND4:	FSET	RM-BOG,FL-SEEN
	PRINTI	" deep within the confines of a hawthorn bush on a small, foggy island. The thorny branches of the bush form an impenetrable barrier on all sides.
"
	IN?	TH-HAWTHORN,RM-THORNEY-ISLAND \FALSE
	FSET	TH-HAWTHORN,FL-SEEN
	PRINTI	"
On the ground is a thorny sprig that has fallen from the bush.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL10
	IN?	TH-HAWTHORN,RM-THORNEY-ISLAND \FALSE
	EQUAL?	PRSO,TH-HAWTHORN,RM-THORNEY-ISLAND,GLOBAL-HERE \FALSE
	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER \?CCL22
	ICALL2	RT-DO-TAKE,TH-HAWTHORN
	FSET	TH-HAWTHORN,FL-WORN
	ICALL2	THIS-IS-IT,TH-HAWTHORN
	PRINTI	"As you brush up against the sprig, the thorn catches on your fur.
"
	BOR	GL-UPDATE-WINDOW,5 >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL25
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL25:	EQUAL?	GL-WINDOW-TYPE,K-WIN-INVT \TRUE
	ICALL1	RT-UPDATE-INVT-WINDOW
	RTRUE	
?CCL22:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL28
	ICALL2	THIS-IS-IT,TH-HAWTHORN
	PRINTR	"The thorn scratches your bare, unprotected skin."
?CCL28:	PRINTI	"You shouldn't be able to get here as"
	ICALL2	RT-FORM-MSG,K-ART-A
	PRINTR	"."
?CCL10:	EQUAL?	CONTEXT,M-ENTER \?CCL30
	SET	'GL-PICTURE-NUM,K-PIC-THORNEY-ISLAND
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL30:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL36
	EQUAL?	HERE,RM-THORNEY-ISLAND /FALSE
	CALL	NOUN-USED?,RM-THORNEY-ISLAND,W?ISLAND
	ZERO?	STACK /?CCL42
	FSET	RM-THORNEY-ISLAND,FL-SEEN
	PRINTR	"You peer through the fog at the island. Dimly, you see the vague outline of a single, large thornbush."
?CCL42:	PRINTR	"It looks like a large thornbush, but the fog is too thick to be sure."
?CCL36:	EQUAL?	PRSA,V?LAND-ON,V?WALK-TO,V?ENTER \?CCL44
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL44
	CALL1	RT-FLY-TO-ISLAND
	RSTACK	
?CCL44:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?108
	PRINTR	" a hole under the bush."

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-GN-ISLAND:ANY:2:2,TBL,FINDER
	EQUAL?	HERE,RM-COTTAGE /?CTR2
	RETURN	RM-ISLAND
?CTR2:	RETURN	RM-THORNEY-ISLAND

	.ENDSEG

	.SEGMENT "TOWN"


	.FUNCT	RT-ENTER-TUNNEL:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	RETURN	RM-BADGER-TUNNEL
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER,K-FORM-SALAMANDER \?CCL5
	ICALL1	RT-CLEAR-PUPPY
	RETURN	RM-BADGER-TUNNEL
?CCL5:	PRINT	K-TOO-BIG-MSG
	RFALSE	


	.FUNCT	RT-FLY-TO-ISLAND:ANY:0:0
	PRINTI	"You swoop"
	EQUAL?	HERE,RM-ABOVE-BOG \?CND1
	PRINTI	" down"
?CND1:	PRINTI	" through the fog towards the island and come upon an impenetrable barrier of sharp thorns. You search for a way through the thicket but find none, so you fly back"
	EQUAL?	HERE,RM-ABOVE-BOG \?CND3
	PRINTI	" up in into the air over the bog"
?CND3:	PRINTR	"."

	.ENDSEG

	.ENDI
