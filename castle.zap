
	.SEGMENT "CASTLE"


	.FUNCT	RT-RM-PASSAGE-1:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	LG-BADGER-TAPESTRY,FL-SEEN
	PRINTI	"You are in a dark underground passageway whose walls have been carved out of solid rock. You peer into the darkness and "
	EQUAL?	CONTEXT,M-F-LOOK \?CCL6
	PRINTI	"discover"
	JUMP	?CND4
?CCL6:	PRINTI	"see"
?CND4:	PRINTI	" a secret passage leading upward to both the north and south. To the west is the back of a tapestry.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL8
	SET	'GL-PICTURE-NUM,K-PIC-PASSAGE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL8:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL17
	PUSH	2
	JUMP	?CND15
?CCL17:	PUSH	1
?CND15:	CALL2	EVERYWHERE-VERB?,STACK
	ZERO?	STACK \FALSE
	FSET?	LG-BADGER-TAPESTRY,FL-LOCKED \FALSE
	CALL1	NP-CANT-SEE
	RSTACK	


	.FUNCT	RT-EXIT-PASSAGE-1:ANY:0:1,QUIET
	ZERO?	QUIET \FALSE
	PRINTI	"[Which way, north or south?]
"
	RFALSE	


	.FUNCT	RT-RM-PASSAGE-2:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You are in a dark passage that continues "
	EQUAL?	OHERE,RM-PASSAGE-1 \?CCL6
	PRINTI	"up to the north and back down behind you to the south.
"
	RFALSE	
?CCL6:	PRINTI	"down to the south and back up behind you to the north.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL8
	SET	'GL-PICTURE-NUM,K-PIC-PASSAGE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL8:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-PASSAGE-3:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You are in a dark passage that continues "
	EQUAL?	OHERE,RM-PASSAGE-1 \?CCL6
	PRINTI	"up to the south and back down behind you to the north.
"
	RFALSE	
?CCL6:	PRINTI	"down to the north and back up behind you to the south.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL8
	SET	'GL-PICTURE-NUM,K-PIC-PASSAGE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL8:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-BEHIND-FIRE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are in a small, cramped room that is solid on three sides."
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-CAS-KITCHEN \?CCL9
	PRINTI	"You"
	ICALL1	RT-WALK-MSG
	PRINTI	" back through the fire"
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED /?CND10
	PRINTI	"place"
?CND10:	PRINTI	" to the small room."
	JUMP	?CND4
?CCL9:	PRINTI	"The passage ends in a small, cramped room that is solid on three sides."
?CND4:	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \?CND12
	FSET	TH-CASTLE-FIRE,FL-SEEN
	PRINTI	" The fourth side is a blazing wall of fire whose bright flames leap high into the air."
?CND12:	PRINTI	" A dark passage leads down on the north. The fire"
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED /?CND14
	PRINTI	"place"
?CND14:	PRINTI	" is to the west.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL17
	SET	'GL-PICTURE-NUM,K-PIC-PASSAGE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CND18
	ICALL1	RT-UPDATE-PICT-WINDOW
?CND18:	MOVE	TH-CASTLE-FIRE,RM-BEHIND-FIRE
	RFALSE	
?CCL17:	EQUAL?	CONTEXT,M-BEG \?CCL21
	ZERO?	GL-PUPPY \FALSE
	IN?	CH-PRISONER,RM-BEHIND-FIRE \FALSE
	CALL2	RT-SET-PUPPY,CH-PRISONER
	RSTACK	
?CCL21:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-THRU-FIRE:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	EQUAL?	HERE,RM-CAS-KITCHEN \?CCL6
	RETURN	RM-BEHIND-FIRE
?CCL6:	EQUAL?	HERE,RM-BEHIND-FIRE \FALSE
	RETURN	RM-CAS-KITCHEN
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER /?CTR9
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED /?CCL10
?CTR9:	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \?CND13
	ICALL1	RT-CLEAR-PUPPY
?CND13:	EQUAL?	HERE,RM-CAS-KITCHEN \?CCL17
	RETURN	RM-BEHIND-FIRE
?CCL17:	EQUAL?	HERE,RM-BEHIND-FIRE \FALSE
	RETURN	RM-CAS-KITCHEN
?CCL10:	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTI	" would surely perish in the flames.
"
	RFALSE	


	.FUNCT	RT-TH-CASTLE-FIRE:ANY:0:3,CONTEXT,ART,CAP?
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,TH-CASTLE-FIRE,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"fire"
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED /FALSE
	PRINTI	"place"
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-CONT \?CCL17
	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL23
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?289
	PRINTI	" around in"
	ICALL	RT-PRINT-OBJ,TH-CASTLE-FIRE,K-ART-THE
	PRINTR	" but find nothing of interest."
?CCL23:	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \?CCL25
	PRINT	K-HOT-MSG
	RTRUE	
?CCL25:	ZERO?	NOW-PRSI /?PRD29
	FSET?	PRSI,FL-AIR /?CCL27
?PRD29:	ZERO?	NOW-PRSI \FALSE
	FSET?	PRSO,FL-AIR \FALSE
?CCL27:	PRINT	K-HOT-MSG
	RTRUE	
?CCL17:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL37
	EQUAL?	PRSA,V?EMPTY \?CCL40
	EQUAL?	PRSO,TH-BARREL,TH-BARREL-WATER \FALSE
	IN?	TH-BARREL-WATER,TH-BARREL \FALSE
	ZERO?	GL-PLAYER-FORM \FALSE
	CALL1	RT-PUT-OUT-FIRE-MSG
	RSTACK	
?CCL40:	EQUAL?	PRSA,V?PUT-IN,V?PUT \?CCL51
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \FALSE
	EQUAL?	PRSO,CH-PLAYER,TH-HANDS,TH-LEGS /?CTR55
	EQUAL?	PRSO,TH-HEAD,TH-MOUTH /?CTR55
	FSET?	PRSI,FL-BODY-PART \?CCL56
	CALL2	GET-OWNER,PRSI
	EQUAL?	STACK,CH-PLAYER \?CCL56
?CTR55:	PRINT	K-HOT-MSG
	RTRUE	
?CCL56:	EQUAL?	PRSO,TH-WHISKY-JUG \?CCL63
	IN?	TH-WHISKY,TH-WHISKY-JUG \?CCL63
	CALL2	RT-PUT-WHISKY-IN-FIRE-MSG,TH-CASTLE-FIRE
	RSTACK	
?CCL63:	FSET?	PRSO,FL-BURNABLE \FALSE
	REMOVE	PRSO
	PRINTI	"The flames leap higher, and soon"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	" can no longer be seen."
?CCL51:	EQUAL?	PRSA,V?PUT-THRU \FALSE
	EQUAL?	HERE,RM-BEHIND-FIRE \?CCL72
	CALL1	IDROP
	ZERO?	STACK /FALSE
	CALL	RT-THROW-INTO-ROOM-MSG,PRSO,RM-CAS-KITCHEN
	RSTACK	
?CCL72:	EQUAL?	HERE,RM-CAS-KITCHEN \?CCL77
	CALL1	IDROP
	ZERO?	STACK /FALSE
	CALL	RT-THROW-INTO-ROOM-MSG,PRSO,RM-BEHIND-FIRE
	RSTACK	
?CCL77:	CALL2	NOT-HERE,PRSI
	RSTACK	
?CCL37:	EQUAL?	PRSA,V?ENTER \?CCL82
	EQUAL?	HERE,RM-BEHIND-FIRE \?CCL85
	CALL2	RT-DO-WALK,P?WEST
	RSTACK	
?CCL85:	EQUAL?	HERE,RM-CAS-KITCHEN \FALSE
	CALL2	RT-DO-WALK,P?EAST
	RSTACK	
?CCL82:	EQUAL?	PRSA,V?CLIMB-ON \?CCL89
	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL92
	PRINTI	"You step"
	ICALL2	RT-IN-ON-MSG,TH-CASTLE-FIRE
	PRINTI	"to"
	ICALL	RT-PRINT-OBJ,TH-CASTLE-FIRE,K-ART-THE
	PRINTI	" and look around for a few moments. Finding nothing of interest, you step"
	ICALL2	RT-OUT-OFF-MSG,TH-CASTLE-FIRE
	PRINTR	" again."
?CCL92:	PRINT	K-HOT-MSG
	RTRUE	
?CCL89:	EQUAL?	PRSA,V?EXTINGUISH \?CCL94
	EQUAL?	PRSI,TH-BARREL,TH-BARREL-WATER \FALSE
	IN?	TH-BARREL-WATER,TH-BARREL \FALSE
	ZERO?	GL-PLAYER-FORM \?CCL103
	CALL1	RT-PUT-OUT-FIRE-MSG
	RSTACK	
?CCL103:	CALL2	RT-ANIMAL-CANT-MSG,STR?290
	RSTACK	
?CCL94:	EQUAL?	PRSA,V?EXAMINE \?CCL105
	FSET	TH-CASTLE-FIRE,FL-SEEN
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \?CCL109
	PRINTR	"It's a roaring fire that gives off intense heat."
?CCL109:	PRINTR	"The fire has gone out."
?CCL105:	EQUAL?	PRSA,V?LOOK-THRU \?CCL111
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't see much from here."
?CCL111:	EQUAL?	PRSA,V?LISTEN \?CCL113
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \FALSE
	PRINTR	"The fire roars like a furnace."
?CCL113:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \FALSE
	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER /?CCL124
	EQUAL?	PRSI,FALSE-VALUE,ROOMS,CH-PLAYER /?CTR123
	EQUAL?	PRSI,TH-HANDS,TH-LEGS,TH-HEAD /?CTR123
	EQUAL?	PRSI,TH-MOUTH /?CTR123
	FSET?	PRSI,FL-BODY-PART \?CCL124
	CALL2	GET-OWNER,PRSI
	EQUAL?	STACK,CH-PLAYER \?CCL124
?CTR123:	PRINT	K-HOT-MSG
	RTRUE	
?CCL124:	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?289
	PRINTI	" around in"
	ICALL	RT-PRINT-OBJ,TH-CASTLE-FIRE,K-ART-THE
	PRINTR	" but find nothing of interest."


	.FUNCT	RT-PUT-OUT-FIRE-MSG:ANY:0:0,OBJ
	ADD	GL-MOVES,60
	ICALL	RT-QUEUE,RT-I-COOL-FIRE,STACK
	FCLEAR	TH-CASTLE-FIRE,FL-LIGHTED
	REMOVE	TH-BARREL-WATER
	ICALL	RT-MOVE-ALL,TH-BARREL,HERE
	FIRST?	TH-CASTLE-FIRE >OBJ /?PRG2
?PRG2:	ZERO?	OBJ /?REP3
	FSET	OBJ,FL-AIR
	NEXT?	OBJ >OBJ /?PRG2
	JUMP	?PRG2
?REP3:	PRINTI	"You strain against the barrel. It teeters for a moment, but then finally crashes over on its side, sending a flood of water directly onto the blaze. The roar of the fire disappears in a loud hiss, and a huge cloud of steam pours out of the fireplace. When the steam clears, you see that the fire has gone out."
	SET	'GL-PICTURE-NUM,K-PIC-CAS-FIREPLACE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CND8
	ICALL1	RT-UPDATE-PICT-WINDOW
?CND8:	IN?	CH-PRISONER,RM-BEHIND-FIRE \?CND10
	ICALL2	RT-SET-PUPPY,CH-PRISONER
	MOVE	CH-PRISONER,HERE
	ICALL2	THIS-IS-IT,CH-PRISONER
	PRINTI	" The prisoner steps through to join you in the kitchen."
?CND10:	CRLF	
	CALL	RT-SCORE-MSG,0,2,0,1
	RSTACK	


	.FUNCT	RT-I-COOL-FIRE:ANY:0:0,OBJ
	FIRST?	TH-CASTLE-FIRE >OBJ /?PRG2
?PRG2:	ZERO?	OBJ /FALSE
	FCLEAR	OBJ,FL-AIR
	NEXT?	OBJ >OBJ /?PRG2
	JUMP	?PRG2


	.FUNCT	RT-RM-CAS-KITCHEN:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You"
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	IN?	CH-PLAYER,TH-BARREL \?CCL9
	PRINTI	" are in"
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-A
	PRINTI	", in"
	JUMP	?CND4
?CCL9:	PRINTI	" are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" in"
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-BEHIND-FIRE \?CCL12
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \?CCL12
	ICALL1	RT-WALK-MSG
	PRINTI	" through the flames unharmed and are now in"
	JUMP	?CND4
?CCL12:	PRINTI	" enter"
?CND4:	FSET	LG-KITCHEN-DOOR,FL-SEEN
	PRINTI	" the castle's kitchen. It is a huge stone room with a cavernous fireplace along the east wall. There is a door in the northwest corner of the room."
	IN?	CH-PLAYER,TH-BARREL /?CND15
	FSET	TH-BARREL,FL-SEEN
	PRINTI	" On the floor next to a nearby table you see a barrel."
?CND15:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL18
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \?CCL21
	SET	'GL-PICTURE-NUM,K-PIC-CAS-KITCHEN
	JUMP	?CND19
?CCL21:	SET	'GL-PICTURE-NUM,K-PIC-CAS-FIREPLACE
?CND19:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CND22
	ICALL1	RT-UPDATE-PICT-WINDOW
?CND22:	MOVE	TH-CASTLE-FIRE,RM-CAS-KITCHEN
	RFALSE	
?CCL18:	EQUAL?	CONTEXT,M-ENTERED \?CCL25
	FSET?	RM-CAS-KITCHEN,FL-BROKEN /FALSE
	EQUAL?	OHERE,RM-BEHIND-FIRE \FALSE
	FSET?	TH-CASTLE-FIRE,FL-LIGHTED \FALSE
	FSET	RM-CAS-KITCHEN,FL-BROKEN
	CALL	RT-SCORE-MSG,0,3,3,1
	RSTACK	
?CCL25:	EQUAL?	CONTEXT,M-EXIT \?CCL36
	EQUAL?	P-WALK-DIR,P?NW,P?OUT \FALSE
	EQUAL?	GL-PUPPY,CH-PRISONER \FALSE
	IN?	TH-HELMET,CH-PRISONER /FALSE
	ZERO?	GL-PLAYER-FORM \FALSE
	PRINTR	"Before you can step through the door, the smith grabs you by the arm and says, ""I can't go out there. Someone might recognize me."""
?CCL36:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL47
	EQUAL?	PRSA,V?THROW /?CCL50
	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	EQUAL?	P-PRSA-WORD,W?THROW,W?TOSS,W?HURL /?CCL50
	EQUAL?	P-PRSA-WORD,W?CHUCK,W?FLING,W?PITCH /?CCL50
	EQUAL?	P-PRSA-WORD,W?HEAVE \FALSE
?CCL50:	EQUAL?	HERE,RM-BEHIND-FIRE \?CCL60
	CALL1	IDROP
	ZERO?	STACK /TRUE
	CALL	RT-THROW-INTO-ROOM-MSG,PRSO,RM-CAS-KITCHEN
	RSTACK	
?CCL60:	CALL2	NOT-HERE,PRSI
	RSTACK	
?CCL47:	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,RM-CAS-KITCHEN /FALSE
	FSET	RM-CAS-KITCHEN,FL-SEEN
	EQUAL?	HERE,RM-BEHIND-FIRE \?CCL71
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't see much from here."
?CCL71:	PRINTR	"It's a small building to the south of the Great Hall."


	.FUNCT	RT-TH-CASTLE-TABLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?CLIMB-OVER,V?CLIMB-ON,V?CLIMB-UP \FALSE
	DIROUT	D-TABLE-ON,K-DIROUT-TBL,0
	PRINTI	"It's not polite to "
	PRINTB	P-PRSA-WORD
	PRINTI	" on tables."
	CALL1	RT-AUTHOR-OFF
	RSTACK	


	.FUNCT	RT-TH-BARREL:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-BEG \?CCL3
	EQUAL?	PRSA,V?EXIT \?CCL6
	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL \?CCL6
	EQUAL?	PRSO,TH-BARREL,FALSE-VALUE,ROOMS \?CCL6
	PRINTR	"Eels can't live out of water."
?CCL6:	EQUAL?	PRSA,V?TIP,V?MOVE,V?EMPTY \?PRD13
	EQUAL?	PRSO,TH-BARREL /?CCL11
?PRD13:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	CALL	RT-META-IN?,PRSO,TH-CASTLE-TABLE
	ZERO?	STACK \FALSE
	CALL	RT-META-IN?,PRSO,TH-BARREL
	ZERO?	STACK \FALSE
	CALL	RT-META-IN?,PRSO,CH-PLAYER
	ZERO?	STACK \FALSE
?CCL11:	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTI	" would have to get out of"
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-THE
	PRINTR	" first."
?CCL3:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?DRINK-FROM \?CCL25
	IN?	TH-BARREL-WATER,TH-BARREL \?CCL28
	ICALL	PERFORM,V?DRINK,TH-BARREL-WATER
	RTRUE	
?CCL28:	PRINTI	"There is nothing to drink in"
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-THE
	PRINTR	"."
?CCL25:	EQUAL?	PRSA,V?RAISE,V?TAKE \?CCL30
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-THE,TRUE-VALUE,STR?25
	PRINTR	" too heavy to lift."
?CCL30:	EQUAL?	PRSA,V?EMPTY \?CCL32
	ZERO?	GL-PLAYER-FORM /?CCL35
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL35:	IN?	TH-BARREL-WATER,TH-BARREL \FALSE
	EQUAL?	PRSI,FALSE-VALUE,ROOMS,TH-GROUND /?CTR39
	EQUAL?	PRSI,TH-CASTLE-FIRE \?CCL40
?CTR39:	CALL1	RT-PUT-OUT-FIRE-MSG
	RSTACK	
?CCL40:	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	
?CCL32:	EQUAL?	PRSA,V?TIP,V?MOVE \?CCL44
	ZERO?	GL-PLAYER-FORM /?CCL47
	CALL2	RT-ANIMAL-CANT-MSG,STR?181
	RSTACK	
?CCL47:	IN?	TH-BARREL-WATER,TH-BARREL \?CCL49
	CALL1	RT-PUT-OUT-FIRE-MSG
	RSTACK	
?CCL49:	CALL2	RT-NO-POINT-MSG,STR?160
	RSTACK	
?CCL44:	EQUAL?	PRSA,V?ENTER \?CCL51
	IN?	TH-BARREL-WATER,TH-BARREL \?CND52
	ZERO?	GL-PLAYER-FORM /?CND52
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL,K-FORM-BADGER,K-FORM-SALAMANDER \?CCL58
	PRINT	K-WOULD-DROWN-MSG
	RTRUE	
?CCL58:	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE \TRUE
	ICALL2	RT-ANIMAL-CANT-MSG,STR?291
	RTRUE	
?CND52:	MOVE	WINNER,TH-BARREL
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?130
	PRINTI	" into"
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-THE
	PRINTC	46
	CRLF	
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL51:	EQUAL?	PRSA,V?EXIT \FALSE
	MOVE	WINNER,HERE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?130
	PRINTI	" out of"
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-THE
	PRINTC	46
	CRLF	
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	


	.FUNCT	RT-LEAVE-BARREL:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	RETURN	RM-CAS-KITCHEN
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-EEL \?CCL5
	PRINTI	"Eels can't live out of water."
	CRLF	
	RETURN	ROOMS
?CCL5:	MOVE	WINNER,HERE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?130
	PRINTI	" out of"
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-THE
	PRINTC	46
	CRLF	
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \FALSE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RFALSE	


	.FUNCT	RT-TH-BARREL-WATER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EAT,V?DRINK \FALSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?174
	PRINTR	" a small, refreshing sip of water."

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-TH-PUMICE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-PUMICE,FL-SEEN
	PRINTR	"It is a small, rough stone."

	.ENDSEG

	.SEGMENT "CASTLE"


	.FUNCT	RT-LG-KITCHEN-DOOR:ANY:0:1,CONTEXT
	CALL	NOUN-USED?,LG-KITCHEN-DOOR,W?BAR
	ZERO?	STACK /?CCL3
	EQUAL?	HERE,RM-PARADE-AREA \?CCL6
	CALL1	NP-CANT-SEE
	RSTACK	
?CCL6:	EQUAL?	PRSA,V?EXAMINE \?CCL8
	PRINTI	"It's a stout piece of wood that has been "
	FSET?	LG-KITCHEN-DOOR,FL-LOCKED \?CCL11
	PRINTI	"lowered"
	JUMP	?CND9
?CCL11:	PRINTI	"raised"
?CND9:	PRINTI	" to "
	FSET?	LG-KITCHEN-DOOR,FL-LOCKED \?CCL14
	PRINTI	"bar"
	JUMP	?CND12
?CCL14:	PRINTI	"unbar"
?CND12:	PRINTR	" the door."
?CCL8:	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL16
	ZERO?	GL-PLAYER-FORM /?CCL16
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't reach the bar."
?CCL16:	EQUAL?	PRSA,V?TAKE \?CCL20
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?272
	PRINTR	" at the bar, but it is firmly attached to the wall."
?CCL20:	EQUAL?	PRSA,V?UNLOCK,V?OPEN,V?RAISE \?CCL22
	FSET?	LG-KITCHEN-DOOR,FL-LOCKED /?CCL25
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTR	"The bar is already up."
?CCL25:	FCLEAR	LG-KITCHEN-DOOR,FL-LOCKED
	PRINTR	"You lift the bar."
?CCL22:	EQUAL?	PRSA,V?LOCK,V?CLOSE,V?LOWER \FALSE
	FSET?	LG-KITCHEN-DOOR,FL-LOCKED \?CCL30
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTR	"The bar is already down."
?CCL30:	FSET	LG-KITCHEN-DOOR,FL-LOCKED
	PRINTR	"You lower the bar."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL32
	FSET	LG-KITCHEN-DOOR,FL-SEEN
	PRINTI	"It's a massive wooden door"
	EQUAL?	HERE,RM-CAS-KITCHEN \?CND33
	PRINTI	" with a stout bar to lock it"
?CND33:	PRINTR	"."
?CCL32:	EQUAL?	PRSA,V?OPEN \?CCL36
	FSET?	LG-KITCHEN-DOOR,FL-OPEN \?CCL39
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE,TRUE-VALUE
	PRINTR	" is already open."
?CCL39:	ZERO?	GL-PLAYER-FORM /?CCL41
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL41:	FSET?	LG-KITCHEN-DOOR,FL-LOCKED \?CCL43
	EQUAL?	HERE,RM-PARADE-AREA \?CCL43
	PRINTI	"You rattle"
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE
	PRINTR	" for a few moments, but it refuses to open. It must be barred from the other side."
?CCL43:	FSET	LG-KITCHEN-DOOR,FL-OPEN
	ICALL2	RT-CHECK-ADJ,LG-KITCHEN-DOOR
	PRINTI	"You "
	FSET?	LG-KITCHEN-DOOR,FL-LOCKED \?CND46
	FCLEAR	LG-KITCHEN-DOOR,FL-LOCKED
	PRINTI	"lift the bar and "
?CND46:	PRINTI	"open"
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE
	PRINTC	46
	CRLF	
	EQUAL?	GL-WINDOW-TYPE,K-WIN-MAP \TRUE
	ICALL1	RT-UPDATE-MAP-WINDOW
	RTRUE	
?CCL36:	EQUAL?	PRSA,V?CLOSE \?CCL51
	FSET?	LG-KITCHEN-DOOR,FL-OPEN /?CCL54
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE,TRUE-VALUE
	PRINTR	" is already closed."
?CCL54:	ZERO?	GL-PLAYER-FORM /?CCL56
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL56:	FCLEAR	LG-KITCHEN-DOOR,FL-OPEN
	ICALL2	RT-CHECK-ADJ,LG-KITCHEN-DOOR
	PRINTI	"You close"
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE
	PRINTC	46
	CRLF	
	EQUAL?	GL-WINDOW-TYPE,K-WIN-MAP \TRUE
	ICALL1	RT-UPDATE-MAP-WINDOW
	RTRUE	
?CCL51:	EQUAL?	PRSA,V?LOCK \?CCL60
	EQUAL?	P-PRSA-WORD,W?BAR /?CCL63
	CALL2	RT-NO-KEYHOLE-MSG,LG-KITCHEN-DOOR
	RSTACK	
?CCL63:	ZERO?	GL-PLAYER-FORM /?CCL65
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL65:	EQUAL?	HERE,RM-PARADE-AREA \?CCL67
	PRINTR	"There is no bar on this side."
?CCL67:	FSET?	LG-KITCHEN-DOOR,FL-LOCKED \?CCL69
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE,TRUE-VALUE
	PRINTR	" is already barred."
?CCL69:	EQUAL?	P-PRSA-WORD,W?BAR \?CCL71
	EQUAL?	PRSI,ROOMS /?CCL71
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTI	" can't bar"
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE
	PRINTI	" with"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
	PRINTR	"."
?CCL71:	PRINTI	"You "
	FSET?	LG-KITCHEN-DOOR,FL-OPEN \?CND74
	FCLEAR	LG-KITCHEN-DOOR,FL-OPEN
	ICALL2	RT-CHECK-ADJ,LG-KITCHEN-DOOR
	PRINTI	"close and "
?CND74:	FSET	LG-KITCHEN-DOOR,FL-LOCKED
	PRINTI	"bar"
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE
	PRINTR	"."
?CCL60:	EQUAL?	PRSA,V?UNLOCK \FALSE
	EQUAL?	P-PRSA-WORD,W?UNBAR /?CCL80
	CALL2	RT-NO-KEYHOLE-MSG,LG-KITCHEN-DOOR
	RSTACK	
?CCL80:	FSET?	LG-KITCHEN-DOOR,FL-LOCKED /?CCL82
	ICALL	RT-PRINT-OBJ,LG-KITCHEN-DOOR,K-ART-THE,TRUE-VALUE
	PRINTR	" is already un-barred."
?CCL82:	ZERO?	GL-PLAYER-FORM /?CCL84
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL84:	FCLEAR	LG-KITCHEN-DOOR,FL-LOCKED
	PRINTR	"You lift the bar."


	.FUNCT	RT-NO-KEYHOLE-MSG:ANY:0:1,DOOR
	ZERO?	DOOR \?CND1
	SET	'DOOR,PRSO
?CND1:	ICALL	RT-PRINT-OBJ,DOOR,K-ART-THE,TRUE-VALUE,STR?34
	PRINTI	" no keyhole. You will have to "
	EQUAL?	PRSA,V?LOCK \?CCL5
	PRINTI	"lower"
	JUMP	?CND3
?CCL5:	PRINTI	"raise"
?CND3:	PRINTR	" the bar."


	.FUNCT	RT-RM-SMALL-CHAMBER:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	LG-BADGER-TAPESTRY,FL-SEEN
	PRINTI	"You are in"
	ICALL	RT-PRINT-OBJ,RM-SMALL-CHAMBER,K-ART-A
	PRINTI	" that looks oddly out of place in this underground prison. Its rich furnishings include a fine stonework floor, comfortable chairs, and a beautifully woven tapestry on the wall. It looks like a king's secret consultation chamber.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-SMALL-CHAMBER
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	EQUAL?	CONTEXT,M-BEG \?CCL9
	EQUAL?	PRSA,V?YELL \?CCL12
	ZERO?	GL-PLAYER-FORM \FALSE
	CALL1	RT-CALL-GUARD
	RSTACK	
?CCL12:	EQUAL?	PRSA,V?SIT \FALSE
	EQUAL?	PRSO,FALSE-VALUE,ROOMS \FALSE
	CALL1	RT-PS-CHAIRS
	RSTACK	
?CCL9:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-EXIT-CHAMBER:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	FSET?	LG-BADGER-TAPESTRY,FL-LOCKED /FALSE
	RETURN	RM-PASSAGE-1
?CCL3:	FSET?	LG-BADGER-TAPESTRY,FL-LOCKED /?CTR7
	RETURN	RM-PASSAGE-1
?CTR7:	ICALL2	RT-YOU-CANT-MSG,STR?82
	RFALSE	


	.FUNCT	RT-PS-CHAIRS:ANY:0:3,CONTEXT,ART,CAP?
	FSET	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"chairs"
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?LOOK-ON,V?EXAMINE \?CCL14
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"The chairs look soft and cozy."
?CCL14:	EQUAL?	PRSA,V?ENTER,V?SIT \FALSE
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"You settle into one of the chairs for a few moments, and then leap up again, nervous that someone might come in."

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-GN-TAPESTRY:ANY:2:2,R,T
	CALL	GLOBAL-IN?,LG-BADGER-TAPESTRY,HERE
	ZERO?	STACK /?CCL3
	RETURN	LG-BADGER-TAPESTRY
?CCL3:	RETURN	LG-OWL-TAPESTRY

	.ENDSEG

	.SEGMENT "CASTLE"


	.FUNCT	RT-LG-BADGER-TAPESTRY:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	FSET	LG-BADGER-TAPESTRY,FL-SEEN
	EQUAL?	HERE,RM-PASSAGE-1 \?CCL6
	PRINTI	"It's hard to tell from the back, but it looks like"
	JUMP	?CND4
?CCL6:	ICALL	RT-PRINT-OBJ,LG-BADGER-TAPESTRY,K-ART-THE,TRUE-VALUE
	PRINTI	" is"
?CND4:	PRINTR	" a hunting scene of men in armour mercilessly hunting down badgers."
?CCL3:	EQUAL?	PRSA,V?LOOK-BEHIND,V?MOVE \?CCL8
	FCLEAR	LG-BADGER-TAPESTRY,FL-LOCKED
	PRINTI	"Behind the tapestry is"
	EQUAL?	HERE,RM-SMALL-CHAMBER \?CCL11
	ICALL	RT-PRINT-OBJ,RM-PASSAGE-1,K-ART-A
	JUMP	?CND9
?CCL11:	ICALL	RT-PRINT-OBJ,RM-SMALL-CHAMBER,K-ART-A
?CND9:	PRINTC	46
	CRLF	
	EQUAL?	HERE,RM-SMALL-CHAMBER \TRUE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-MAP \TRUE
	ICALL1	RT-UPDATE-MAP-WINDOW
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?HIDE-BEHIND \FALSE
	FSET?	LG-BADGER-TAPESTRY,FL-LOCKED \?CND18
	FCLEAR	LG-BADGER-TAPESTRY,FL-LOCKED
	PRINTI	"You pull back the tapestry and discover a hidden passage! Cautiously, you feel your way into the darkness.

"
?CND18:	EQUAL?	HERE,RM-SMALL-CHAMBER \?CCL22
	CALL2	RT-DO-WALK,P?EAST
	RSTACK	
?CCL22:	CALL2	RT-DO-WALK,P?WEST
	RSTACK	


	.FUNCT	RT-RM-END-OF-HALL:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	RM-SMALL-CHAMBER,FL-SEEN
	PRINTI	"You are at the end of an underground corridor that runs east and west. To the east is"
	ICALL	RT-PRINT-OBJ,RM-SMALL-CHAMBER,K-ART-A
	PRINTC	46
	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-HALL
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	EQUAL?	CONTEXT,M-BEG \?CCL9
	EQUAL?	PRSA,V?YELL \FALSE
	ZERO?	GL-PLAYER-FORM \FALSE
	CALL1	RT-CALL-GUARD
	RSTACK	
?CCL9:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-HALL:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	LG-CELL-DOOR,FL-SEEN
	PRINTI	"You are in an underground corridor that runs east and west. To the south is the door to a cell.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-HALL
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	EQUAL?	CONTEXT,M-BEG \?CCL9
	EQUAL?	PRSA,V?YELL \FALSE
	ZERO?	GL-PLAYER-FORM \FALSE
	CALL1	RT-CALL-GUARD
	RSTACK	
?CCL9:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-BOTTOM-OF-STAIRS:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You are at the west end of an underground corridor, at the bottom of a long flight of stairs. At the top, you see a soldier standing guard. To go up would mean certain capture.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-HALL
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	EQUAL?	CONTEXT,M-BEG \?CCL9
	EQUAL?	PRSA,V?YELL \FALSE
	ZERO?	GL-PLAYER-FORM \FALSE
	CALL1	RT-CALL-GUARD
	RSTACK	
?CCL9:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-EXIT-STAIRS:ANY:0:1,QUIET
	ZERO?	QUIET \FALSE
	ZERO?	GL-PLAYER-FORM \?CCL5
	PRINTI	"You steal up the stairs as quietly as you can, but the soldier sees you immediately. He quickly overpowers you and drags you back down into the dungeon and puts you in chains.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL5:	PRINTI	"As soon as you reach the top of the stairs, the guard notices you and says,"
	PRINT	K-LOVERLY-MSG
	ICALL1	RT-FORM-MSG
	PRINT	K-SKEWER-MSG
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-RM-ARMOURY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are in"
	JUMP	?CND4
?CCL6:	PRINTI	"You have entered"
?CND4:	PRINTI	" a deserted armoury. A few shields are fixed to the wall, and some pikestaffs are locked up as well. A broken dagger lies on the table awaiting the armourer's attention, but right now it's worthless."
	EQUAL?	CONTEXT,M-F-LOOK \?CCL9
	FCLEAR	TH-ARMOUR,FL-NO-DESC
	FCLEAR	TH-SHIELD,FL-NO-DESC
	FSET	TH-ARMOUR,FL-SEEN
	FSET	TH-SHIELD,FL-SEEN
	PRINTR	" The only things not broken or locked down are a tarnished shield and some armour that lie in the corner."
?CCL9:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL11
	SET	'GL-PICTURE-NUM,K-PIC-ARMOURY
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL11:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-PS-SHIELDS:ANY:0:3,CONTEXT,ART,CAP?
	FSET	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"shields"
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TAKE /?CCL14
	EQUAL?	PRSA,V?LOOK-ON,V?LOOK-IN,V?EXAMINE \FALSE
?CCL14:	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"The shields are fastened firmly to the wall."


	.FUNCT	RT-PS-PIKESTAFFS:ANY:0:3,CONTEXT,ART,CAP?
	FSET	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"pikestaffs"
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TAKE,V?EXAMINE \?CCL14
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"The pikestaffs are securely locked down."
?CCL14:	EQUAL?	PRSA,V?UNLOCK \FALSE
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't unlock the pikestaffs."


	.FUNCT	RT-TH-ARMOURY-TABLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?CLIMB-OVER,V?CLIMB-ON,V?CLIMB-UP \FALSE
	DIROUT	D-TABLE-ON,K-DIROUT-TBL,0
	PRINTI	"It's not polite to "
	PRINTB	P-PRSA-WORD
	PRINTI	" on tables."
	CALL1	RT-AUTHOR-OFF
	RSTACK	


	.FUNCT	RT-TH-BROKEN-DAGGER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"The dagger is broken and quite useless."
?CCL5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"You pick up the broken pieces and examine them. Realizing that they could be of no possible use to anyone, you put them back down and turn your attention elsewhere."


	.FUNCT	RT-LG-CASTLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?ENTER \?CCL5
	EQUAL?	HERE,RM-CASTLE-GATE \?CCL5
	CALL2	RT-DO-WALK,P?EAST
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?EXIT \?CCL9
	EQUAL?	HERE,RM-PARADE-AREA \?CCL9
	CALL2	RT-DO-WALK,P?WEST
	RSTACK	
?CCL9:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	LG-CASTLE,FL-SEEN
	PRINTR	"It's a centuries-old fort built during the Roman occupation of Britain. It has fallen into considerable disrepair since the legions left, although King Lot has tried to preserve its crumbling walls."

	.ENDSEG

	.SEGMENT "OWL"


	.FUNCT	RT-RM-ABOVE-CASTLE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	RM-BOG,FL-SEEN
	FSET	LG-TOWN,FL-SEEN
	FSET	LG-CASTLE,FL-SEEN
	PRINTI	"You are hovering over the castle. Below you to the north you see a patch of fog. To the northeast you see a road emerge from the fog and come to a ford in the river. Flying to the northwest would put you over the moor. To the west you see the roofs of the town.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL5
	SET	'GL-PICTURE-NUM,K-PIC-AIR-SCENE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	

	.ENDSEG

	.ENDI
