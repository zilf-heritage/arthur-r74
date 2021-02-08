
	.SEGMENT "TOWER"


	.FUNCT	RT-RM-NORTH-OF-CHASM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	LG-CHASM,FL-SEEN
	FSET	TH-BOAR,FL-SEEN
	PRINTI	"You are on the northern lip of a narrow chasm in the heart of the forest. "
	ICALL2	THIS-IS-IT,TH-BOAR
	FSET?	TH-BOAR,FL-ALIVE \?CCL6
	ZERO?	GL-PLAYER-FORM \?CCL9
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTC	32
	EQUAL?	GL-BOAR-NUM,1 \?CCL12
	PRINTI	"is a short distance away, madly pawing the ground as if he is about to make a charge at you"
	JUMP	?CND4
?CCL12:	PRINTI	"is thundering towards you. There is a mad, wild gleam in his eyes, and his single tusk is poised to strike your unprotected flesh"
	JUMP	?CND4
?CCL9:	PRINTI	"Nearby you see"
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-A
	PRINT	K-PACING-MSG
	JUMP	?CND4
?CCL6:	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-A,TRUE-VALUE
	IN?	TH-TUSK,TH-BOAR \?CND13
	FSET	TH-TUSK,FL-SEEN
	PRINT	K-SINGLE-TUSK-MSG
?CND13:	PRINTI	" lies on"
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
?CND4:	PRINTC	46
	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL16
	SET	'GL-PICTURE-NUM,K-PIC-NORTH-OF-CHASM
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL16:	EQUAL?	CONTEXT,M-END \FALSE
	FSET?	TH-BOAR,FL-ALIVE \FALSE
	EQUAL?	PRSA,V?TRANSFORM \FALSE
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /FALSE
	CRLF	
	ZERO?	GL-PLAYER-FORM \?CCL29
	SET	'GL-BOAR-NUM,1
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-BOAR,STACK
	ICALL2	THIS-IS-IT,TH-BOAR
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTI	" looks startled, and then starts to paw the ground like a bull about to charge.
"
	JUMP	?CND27
?CCL29:	SET	'GL-BOAR-NUM,0
	ICALL2	RT-DEQUEUE,RT-I-BOAR
	ICALL2	THIS-IS-IT,TH-BOAR
	PRINTI	"Startled,"
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE
	PRINTI	" stops dead in his tracks, and then resumes his wild pacing.
"
?CND27:	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL32
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL32:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \TRUE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RTRUE	


	.FUNCT	RT-LG-CHASM:ANY:0:1,CONTEXT,RM
	ZERO?	CONTEXT \FALSE
	CALL	NOUN-USED?,LG-CHASM,W?SIDE
	ZERO?	STACK /?CCL5
	CALL	ADJ-USED?,LG-CHASM,W?OTHER
	ZERO?	STACK /?CCL5
	ZERO?	NOW-PRSI /?CCL10
	EQUAL?	PRSA,V?THROW /?PRD15
	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	EQUAL?	P-PRSA-WORD,W?THROW,W?TOSS,W?HURL /?PRD15
	EQUAL?	P-PRSA-WORD,W?CHUCK,W?FLING,W?PITCH /?PRD15
	EQUAL?	P-PRSA-WORD,W?HEAVE \FALSE
?PRD15:	CALL1	IDROP
	ZERO?	STACK /FALSE
	CALL2	RT-MOVE-OVER-CHASM,PRSO
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?CLIMB-OVER,V?ENTER,V?WALK-TO \FALSE
	EQUAL?	HERE,RM-SOUTH-OF-CHASM \?CCL27
	CALL2	RT-DO-WALK,P?NORTH
	RSTACK	
?CCL27:	EQUAL?	HERE,RM-NORTH-OF-CHASM \FALSE
	CALL2	RT-DO-WALK,P?SOUTH
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?THROW,V?PUT-IN,V?PUT \?CCL31
	CALL1	IDROP
	ZERO?	STACK /FALSE
	REMOVE	PRSO
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE,TRUE-VALUE,STR?179
	PRINTI	" into"
	ICALL	RT-PRINT-OBJ,LG-CHASM,K-ART-THE
	PRINTR	" and quickly disappears from sight."
?CCL31:	EQUAL?	PRSA,V?THROW-OVER \?CCL36
	CALL1	IDROP
	ZERO?	STACK /FALSE
	CALL2	RT-MOVE-OVER-CHASM,PRSO
	RSTACK	
?CCL36:	EQUAL?	PRSA,V?CLIMB-OVER \?CCL41
	EQUAL?	HERE,RM-SOUTH-OF-CHASM \?CCL44
	CALL2	RT-DO-WALK,P?NORTH
	RSTACK	
?CCL44:	EQUAL?	HERE,RM-NORTH-OF-CHASM \FALSE
	CALL2	RT-DO-WALK,P?SOUTH
	RSTACK	
?CCL41:	EQUAL?	PRSA,V?DISMOUNT,V?ENTER \?CCL48
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL51
	PRINT	K-UPDRAFT-MSG
	CALL1	RT-FLY-UP
	ICALL	RT-GOTO,STACK,TRUE-VALUE
	RTRUE	
?CCL51:	EQUAL?	P-PRSA-WORD,W?JUMP,W?DIVE,W?LEAP \?CCL53
	PRINTI	"Throwing caution to the winds, you leap into the chasm. On the way down, you notice that the walls are gray and jagged. When you land at the bottom, you notice that you are squashed and dead.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL53:	PRINTR	"The steep cliffs are too dangerous to climb down."
?CCL48:	EQUAL?	PRSA,V?LOOK-DOWN,V?LOOK-IN,V?EXAMINE \FALSE
	FSET	LG-CHASM,FL-SEEN
	PRINTR	"It looks like a long way down."


	.FUNCT	RT-ENTER-CHASM:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	RETURN	LG-CHASM
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL5
	PRINT	K-UPDRAFT-MSG
	CALL1	RT-FLY-UP
	ICALL	RT-GOTO,STACK,TRUE-VALUE
	RFALSE	
?CCL5:	PRINTI	"The steep cliffs are too dangerous to climb down.
"
	RFALSE	


	.FUNCT	RT-MOVE-OVER-CHASM:ANY:1:1,OBJ
	EQUAL?	HERE,RM-SOUTH-OF-CHASM \?CCL3
	EQUAL?	OBJ,TH-APPLE \?CCL6
	CALL1	RT-APPLE-MSG
	RSTACK	
?CCL6:	MOVE	OBJ,RM-NORTH-OF-CHASM
	ICALL2	THIS-IS-IT,OBJ
	ICALL2	THIS-IS-IT,TH-BOAR
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE,TRUE-VALUE,STR?179
	PRINTI	" through the air and"
	ICALL	RT-PRINT-VERB,OBJ,STR?211
	PRINTI	" on the ground near"
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE
	PRINTC	46
	CRLF	
	BOR	GL-UPDATE-WINDOW,5 >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL3:	EQUAL?	HERE,RM-NORTH-OF-CHASM \FALSE
	MOVE	OBJ,RM-SOUTH-OF-CHASM
	EQUAL?	OBJ,TH-TUSK \?CND11
	FSET?	TH-TUSK,FL-BROKEN /?CND11
	FSET	TH-TUSK,FL-BROKEN
	PUTP	TH-TUSK,P?SCORE,2048
?CND11:	BOR	GL-UPDATE-WINDOW,K-UPD-INVT >GL-UPDATE-WINDOW
	ICALL2	THIS-IS-IT,OBJ
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE,TRUE-VALUE,STR?211
	PRINTI	" to the ground on the other side of"
	ICALL	RT-PRINT-OBJ,LG-CHASM,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-OVER-CHASM:ANY:0:1,QUIET
	ZERO?	QUIET \?CTR2
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL3
?CTR2:	EQUAL?	P-WALK-DIR,P?NORTH /?CTR7
	RETURN	RM-SOUTH-OF-CHASM
?CTR7:	RETURN	RM-NORTH-OF-CHASM
?CCL3:	ICALL2	THIS-IS-IT,LG-CHASM
	PRINTI	"You gauge the distance and decide that"
	ICALL	RT-PRINT-OBJ,LG-CHASM,K-ART-THE
	PRINTI	" is just a little too wide to jump over.
"
	RFALSE	


	.FUNCT	RT-RM-SOUTH-OF-CHASM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" in"
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-LEP-PATH \?CCL9
	PRINTI	"After a while the trees begin to thin out, and soon you find yourself in"
	JUMP	?CND4
?CCL9:	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" in"
?CND4:	FSET	LG-CHASM,FL-SEEN
	PRINTI	" a large clearing in the heart of the forest. The clearing is cleft by a narrow chasm which lies directly to the north. A path leading into the forest lies to the south. On the other side of the chasm you see"
	FSET	TH-BOAR,FL-LOCKED
	ICALL2	PRINT-CONTENTS,RM-NORTH-OF-CHASM
	FCLEAR	TH-BOAR,FL-LOCKED
	FSET	TH-BOAR,FL-SEEN
	PRINTC	46
	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL11
	SET	'GL-PICTURE-NUM,K-PIC-SOUTH-OF-CHASM
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL11:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-BOAR:ANY:0:3,CONTEXT,ART,CAP?,P
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,TH-BOAR,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	FSET?	TH-BOAR,FL-ALIVE /?CCL15
	PRINTI	"dead"
	JUMP	?CND13
?CCL15:	PRINTI	"wild"
?CND13:	PRINTI	" boar"
	FSET?	TH-BOAR,FL-LOCKED \FALSE
	FSET?	TH-BOAR,FL-ALIVE \FALSE
	PRINT	K-PACING-MSG
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-WINNER \?CCL23
	PRINT	K-BOAR-UNDERSTAND-MSG
	RTRUE	
?CCL23:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL27
	EQUAL?	PRSA,V?THROW \?CCL30
	EQUAL?	PRSO,TH-SWORD \?CCL33
	PRINTI	"The sword slices through the air and "
	MOVE	PRSO,RM-NORTH-OF-CHASM
	PRINTI	"the hilt smacks"
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE
	PRINTI	" right between the eyes"
	FSET?	TH-BOAR,FL-ALIVE \?CND35
	PRINTI	", stunning it momentarily"
?CND35:	PRINTC	46
	EQUAL?	HERE,RM-NORTH-OF-CHASM \?CND37
	FSET?	TH-BOAR,FL-ALIVE \?CND37
	SET	'GL-BOAR-NUM,1
	PRINTC	32
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTR	" staggers around for a second, but then recovers and prepares to charge again."
?CND37:	CRLF	
	RTRUE	
?CCL33:	EQUAL?	PRSO,TH-APPLE \?CCL42
	CALL1	RT-APPLE-MSG
	RSTACK	
?CCL42:	CALL1	IDROP
	ZERO?	STACK /FALSE
	MOVE	PRSO,RM-NORTH-OF-CHASM
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE,TRUE-VALUE,STR?243
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE
	PRINTI	" and"
	ICALL	RT-PRINT-VERB,PRSO,STR?211
	PRINTI	" to the ground."
	FSET?	TH-BOAR,FL-ALIVE \?CND45
	PRINTC	32
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTR	" looks madder than ever."
?CND45:	CRLF	
	RTRUE	
?CCL30:	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't do that."
?CCL27:	EQUAL?	PRSA,V?TELL \?CCL50
	ZERO?	P-CONT \FALSE
?CCL50:	CALL1	SPEAKING-VERB?
	ZERO?	STACK /?CCL54
	EQUAL?	HERE,RM-NORTH-OF-CHASM,RM-SOUTH-OF-CHASM \?CCL54
	PRINT	K-BOAR-UNDERSTAND-MSG
	RTRUE	
?CCL54:	EQUAL?	PRSA,V?EXAMINE \?CCL58
	FSET	TH-BOAR,FL-SEEN
	FSET?	TH-BOAR,FL-ALIVE \?CCL61
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTR	" is several hundred angry pounds of pure viciousness. He has only one tusk, and a gaping hole where the other one used to be."
?CCL61:	IN?	TH-TUSK,TH-BOAR /?CCL64
	PRINTI	"The badly mangled boar"
	JUMP	?CND62
?CCL64:	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
?CND62:	PRINTI	" lies on"
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
	PRINTR	"."
?CCL58:	EQUAL?	PRSA,V?PUT /?CTR65
	EQUAL?	PRSA,V?PUT-IN,V?THROW,V?LOWER /?CTR65
	EQUAL?	PRSA,V?RAISE,V?MOVE,V?TAKE \?CCL66
?CTR65:	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTR	" is too heavy to move."
?CCL66:	EQUAL?	PRSA,V?CUT,V?ATTACK \FALSE
	FSET?	TH-BOAR,FL-ALIVE /?CCL74
	PRINTR	"It's already dead."
?CCL74:	ZERO?	GL-PLAYER-FORM /?CCL76
	PRINTI	"Your feeble efforts fail even to attract"
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE
	PRINTR	"'s attention."
?CCL76:	EQUAL?	PRSI,TH-SWORD \?CCL78
	PRINTI	"You brace yourself, hold the sword steady, and sight down the blade at the onrushing boar. The wild creature charges headlong into the sword and impales himself on the tip. His momentum carries him halfway up the blade before he realizes that he is dead. Unfortunately, this still doesn't prevent him from crashing into you with such force that his tusk rips open your flesh and kills you instantly.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL78:	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTI	" ignores your feeble defense"
	GRTR?	GL-BOAR-NUM,1 \?CND79
	PRINTI	" and continues his charge"
?CND79:	PRINTR	"."


	.FUNCT	RT-I-BOAR:ANY:0:1,PN?
	ZERO?	GL-CLK-RUN /?CND1
	CRLF	
?CND1:	INC	'GL-BOAR-NUM
	EQUAL?	GL-BOAR-NUM,2 \?CCL5
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-BOAR,STACK
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
	PRINTI	" starts his charge.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL8
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL8:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \TRUE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RTRUE	
?CCL5:	ZERO?	PN? /?CCL12
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-HE,TRUE-VALUE
	JUMP	?CND10
?CCL12:	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE,TRUE-VALUE
?CND10:	PRINTI	" slams into you at full speed, ripping your flesh open with his tusk and severing an artery. You fall to the ground and discover with dismay how little time it takes to bleed to death.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-TH-TUSK:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL7
	FSET	TH-TUSK,FL-SEEN
	ICALL	RT-PRINT-OBJ,TH-TUSK,K-ART-THE,TRUE-VALUE
	PRINTR	" is a curled tooth of pure ivory."
?CCL7:	IN?	TH-TUSK,TH-BOAR \FALSE
	EQUAL?	PRSA,V?TAKE \?CCL11
	FSET?	TH-BOAR,FL-ALIVE \?CCL14
	CALL2	NOT-HERE,TH-BOAR
	RSTACK	
?CCL14:	PRINTI	"You tug on"
	ICALL	RT-PRINT-OBJ,TH-TUSK,K-ART-THE
	PRINTI	", but it is firmly attached to"
	ICALL	RT-PRINT-OBJ,TH-BOAR,K-ART-THE
	PRINTC	46
	CRLF	
	CALL2	RT-AUTHOR-MSG,STR?244
	RSTACK	
?CCL11:	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,TH-SWORD \FALSE
	FSET?	TH-BOAR,FL-ALIVE \?CCL21
	PRINTI	"You take a wild swing at"
	ICALL	RT-PRINT-OBJ,TH-TUSK,K-ART-THE
	PRINTR	", but miss."
?CCL21:	FSET	TH-TUSK,FL-TAKEABLE
	FCLEAR	TH-TUSK,FL-TRY-TAKE
	CALL2	RT-DO-TAKE,TH-TUSK
	ZERO?	STACK /?CND22
	PRINTI	"You grasp"
	ICALL	RT-PRINT-OBJ,TH-TUSK,K-ART-THE
	PRINTI	" with one hand and hack it off at the base with"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
	PRINTI	". You are now holding"
	ICALL	RT-PRINT-OBJ,TH-TUSK,K-ART-THE
	PRINTC	46
	CRLF	
	ICALL2	RT-SCORE-OBJ,TH-TUSK
?CND22:	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	


	.FUNCT	RT-TH-APPLETREE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	FSET	TH-APPLETREE,FL-SEEN
	PRINTI	"Little remains of the tree except a shriveled-up trunk and a few branches."
	IN?	TH-APPLE,TH-APPLETREE \?CND6
	ICALL2	THIS-IS-IT,TH-APPLE
	PRINTR	" A withered old apple hangs from one of the branches."
?CND6:	CRLF	
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?CLIMB-ON,V?CLIMB-UP \FALSE
	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-TH-APPLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EAT \?CCL5
	PRINTI	"You take a bite from the apple. As its incredibly virulent poison courses through your system, you begin to think that perhaps you've made a mistake. Your suspicions are confirmed when, seconds later, you drop dead.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-APPLE,FL-SEEN
	PRINTR	"The apple is shriveled and black."

	.ENDSEG

	.SEGMENT "TOWER"


	.FUNCT	RT-APPLE-MSG:ANY:0:0
	PRINTI	"The apple lands near the boar, who stops pacing long enough to gobble it up in a couple of bites. He resumes pacing - apparently unharmed - until suddenly he leaps several feet straight into the air, flips over on his back, and crashes back to the ground, dead.
"
	SET	'GL-BOAR-NUM,0
	ICALL2	RT-DEQUEUE,RT-I-BOAR
	REMOVE	TH-APPLE
	FCLEAR	TH-BOAR,FL-ALIVE
	FSET	TH-BOAR,FL-CONTAINER
	ICALL	RT-SCORE-MSG,0,3,7,4
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL3
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL3:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \TRUE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RTRUE	

	.ENDSEG

	.ENDI
