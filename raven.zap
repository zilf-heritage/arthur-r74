
	.SEGMENT "TOWER"


	.FUNCT	RT-RAV-CANT-CLIMB-UP:ANY:0:0
	ZERO?	GL-PLAYER-FORM \?CCL3
	PRINTR	"You can't climb the tree. There are no branches near the ground."
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER \?CCL5
	PRINTR	"Your claws were designed for digging, not climbing."
?CCL5:	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE \FALSE
	PRINTR	"Turtles can't climb trees."


	.FUNCT	RT-RAV-CLIMBING:ANY:1:1,UD-FLAG
	PRINTI	"You continue to climb "
	EQUAL?	UD-FLAG,K-CLIMB-UP \?CCL3
	PRINTI	"up"
	JUMP	?CND1
?CCL3:	PRINTI	"down"
?CND1:	PRINTI	" the tree. It looks like a long way "
	EQUAL?	UD-FLAG,K-CLIMB-UP \?CCL6
	GRTR?	GL-RAV-P-CNT,K-RAVEN-TREE-HALF /?CCL9
	PRINTI	"up"
	JUMP	?CND4
?CCL9:	PRINTI	"back down"
	JUMP	?CND4
?CCL6:	GRTR?	GL-RAV-P-CNT,K-RAVEN-TREE-HALF /?CCL12
	PRINTI	"back up"
	JUMP	?CND4
?CCL12:	PRINTI	"down"
?CND4:	PRINTR	"."


	.FUNCT	RT-FALL-OFF-TREE:ANY:0:0
	PRINTI	"
You lose your grip on"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-TREE,K-ART-THE
	PRINTI	" and fall to the ground. "
	LESS?	GL-RAV-P-CNT,4 \?CCL3
	MOVE	CH-PLAYER,RM-GROVE
	PRINTR	"You are a bit bruised and battered but otherwise alright."
?CCL3:	PRINTI	"Too bad you were so far up. The fall was fatal.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-TH-RAVEN-BODY:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	PRINT	K-NO-REFER-MSG
	ICALL2	RT-PRINT-DESC,TH-RAVEN-BODY
	PRINTR	".]"

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-TH-RAVEN-EGG:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	FSET	TH-RAVEN-EGG,FL-SEEN
	PRINTR	"It is a huge hunk of gold in the shape of a perfect egg."
?CCL5:	EQUAL?	PRSA,V?SIT \FALSE
	PRINTI	"You squat down on top of the egg, clucking to yourself occasionally and dutifully trying to fool the egg into thinking that you are a medieval hen. Unfortunately, this has no effect, other than to make you feel ridiculous, so after a while you get up."
	CRLF	
	SET	'GL-QUESTION,1
	CALL2	RT-AUTHOR-MSG,STR?279
	RSTACK	

	.ENDSEG

	.SEGMENT "TOWER"


	.FUNCT	RT-CH-RAVEN:ANY:0:1,CONTEXT,F
	EQUAL?	CONTEXT,M-WINNER \?CCL3
	PRINT	K-RAVEN-SQUAWKS-MSG
	CRLF	
	RTRUE	
?CCL3:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?TELL \?CCL9
	ZERO?	P-CONT \FALSE
?CCL9:	CALL1	SPEAKING-VERB?
	ZERO?	STACK /?CCL13
	IN?	CH-RAVEN,HERE \?CCL13
	PRINT	K-RAVEN-SQUAWKS-MSG
	CRLF	
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?EXAMINE \?CCL17
	FSET	CH-RAVEN,FL-SEEN
	FIRST?	CH-RAVEN >F \?CND18
	EQUAL?	F,TH-RAVEN-BODY \?CND18
	NEXT?	F >F /?CND18
?CND18:	IN?	CH-RAVEN,HERE \?CCL25
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" is a huge bird with a wingspan of around twenty feet. It has a long, sharp beak and "
	ZERO?	F /?CND26
	PRINTI	"is holding"
	ICALL	RT-PRINT-OBJ,F,K-ART-THE
	PRINTI	" in its "
?CND26:	PRINTR	"huge talons."
?CCL25:	IN?	CH-RAVEN,RM-GROVE \?CCL29
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" is below you in"
	ICALL	RT-PRINT-OBJ,RM-GROVE,K-ART-THE
	PRINTR	"."
?CCL29:	IN?	CH-RAVEN,RM-RAVEN-NEST \?CCL31
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" is in"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-NEST,K-ART-THE
	PRINTI	" at the top of"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-TREE,K-ART-THE
	PRINTR	"."
?CCL31:	IN?	CH-RAVEN,RM-ABOVE-FOREST \FALSE
	ZERO?	F /?CCL36
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" is struggling to bring"
	ICALL	RT-PRINT-OBJ,F,K-ART-THE
	PRINTR	" up to its nest."
?CCL36:	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTR	" is circling far above you in the sky."
?CCL17:	EQUAL?	PRSA,V?ATTACK \FALSE
	EQUAL?	HERE,RM-RAVEN-NEST \?CCL41
	IN?	CH-RAVEN,RM-RAVEN-NEST \?CCL41
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?281
	PRINTI	" wildly at the raven, but"
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-HIS
	PRINTR	" blows have no effect."
?CCL41:	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTR	" isn't close enough."


	.FUNCT	RT-I-RAV-GROVE-1:ANY:0:0
	ZERO?	GL-RAVEN-OBJ /FALSE
	IN?	GL-RAVEN-OBJ,RM-GROVE \FALSE
	FSET	CH-RAVEN,FL-LOCKED
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-RAV-GROVE-2,STACK
	FSET?	CH-PLAYER,FL-ASLEEP /FALSE
	EQUAL?	HERE,RM-GROVE \?CCL9
	CRLF	
	PRINT	K-RAVEN-APPROACH-MSG
	CRLF	
	RTRUE	
?CCL9:	EQUAL?	HERE,RM-ABOVE-FOREST,RM-RAVEN-TREE \?CCL11
	PRINTI	"
The glint catches the giant raven's eye and it swoops down towards"
	ICALL	RT-PRINT-OBJ,RM-GROVE,K-ART-THE
	PRINTC	46
	CRLF	
	EQUAL?	HERE,RM-ABOVE-FOREST \TRUE
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL11:	EQUAL?	HERE,RM-RAVEN-NEST \FALSE
	PRINTI	"
You see"
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE
	PRINTI	" swoop down towards"
	ICALL	RT-PRINT-OBJ,RM-GROVE,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-I-RAV-GROVE-2:ANY:0:0
	ZERO?	GL-RAVEN-OBJ /?CTR2
	IN?	GL-RAVEN-OBJ,RM-GROVE /?CCL3
?CTR2:	FCLEAR	CH-RAVEN,FL-LOCKED
	FSET?	CH-PLAYER,FL-ASLEEP /FALSE
	EQUAL?	HERE,RM-GROVE \FALSE
	CRLF	
	PRINT	K-RAVEN-SWOOP-MSG
	PRINTR	"It gets a very puzzled look on its face, and then it flies back up out of sight."
?CCL3:	ADD	GL-MOVES,2
	ICALL	RT-QUEUE,RT-I-RAV-NEST-1,STACK
	MOVE	GL-RAVEN-OBJ,CH-RAVEN
	FSET?	CH-PLAYER,FL-ASLEEP /FALSE
	EQUAL?	HERE,RM-GROVE \?CCL15
	CRLF	
	PRINT	K-RAVEN-SWOOP-MSG
	PRINTI	"It clutches"
	ICALL	RT-PRINT-OBJ,GL-RAVEN-OBJ,K-ART-THE
	PRINTR	" in its talons and, struggling from the weight, flies up out of sight."
?CCL15:	EQUAL?	HERE,RM-ABOVE-FOREST,RM-RAVEN-TREE \FALSE
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" takes"
	ICALL	RT-PRINT-OBJ,GL-RAVEN-OBJ,K-ART-THE
	PRINTI	" and begins struggling upward."
	CRLF	
	EQUAL?	HERE,RM-ABOVE-FOREST \TRUE
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	


	.FUNCT	RT-I-RAV-NEST-1:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-RAV-NEST-2,STACK
	FSET?	CH-PLAYER,FL-ASLEEP /FALSE
	EQUAL?	HERE,RM-RAVEN-NEST \?CCL5
	CRLF	
	PRINT	K-RAVEN-APPROACH-MSG
	CRLF	
	RTRUE	
?CCL5:	EQUAL?	HERE,RM-ABOVE-FOREST,RM-RAVEN-TREE \FALSE
	PRINTR	"
The raven approaches its nest."


	.FUNCT	RT-I-RAV-NEST-2:ANY:0:0,1ST?,RM
	EQUAL?	HERE,RM-RAVEN-NEST \?CCL3
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	IN?	CH-RAVEN,RM-RAVEN-NEST /?CND4
	FSET?	CH-PLAYER,FL-ASLEEP /?CND6
	SET	'1ST?,TRUE-VALUE
?CND6:	MOVE	CH-RAVEN,RM-RAVEN-NEST
	FCLEAR	CH-RAVEN,FL-LOCKED
	PRINTI	" arrives in the nest"
	ZERO?	GL-RAVEN-OBJ /?CND8
	MOVE	GL-RAVEN-OBJ,RM-RAVEN-NEST
	PRINTI	", drops"
	ICALL	RT-PRINT-OBJ,GL-RAVEN-OBJ,K-ART-THE
	PRINTC	44
	EQUAL?	GL-RAVEN-OBJ,TH-RAVEN-EGG \?CND10
	GETP	TH-RAVEN-EGG,P?SCORE
	ZERO?	STACK /?CND10
	FCLEAR	TH-RAVEN-EGG,FL-BROKEN
	PUTP	TH-RAVEN-EGG,P?SCORE,0
?CND10:	SET	'GL-RAVEN-OBJ,FALSE-VALUE
?CND8:	PRINTI	" and"
?CND4:	ZERO?	GL-PLAYER-FORM /?CTR15
	FSET?	CH-PLAYER,FL-ASLEEP \?CCL16
?CTR15:	ZERO?	1ST? /?CCL21
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-RAV-NEST-2,STACK
	PRINTI	" starts buffeting you with its huge wings. The deafening squawks emerging from its sharp beak quickly convince you that it is unhappy at your presence. The raven unsheathes its talons and fixes you with a glassy-eyed stare."
	CRLF	
	JUMP	?CND14
?CCL21:	PRINTI	"'s razor-like talons dig into your flesh and kill you instantly.
"
	ICALL1	RT-END-OF-GAME
	JUMP	?CND14
?CCL16:	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL,K-FORM-SALAMANDER \?CCL23
	ADD	GL-MOVES,2
	ICALL	RT-QUEUE,RT-I-RAV-NEST-3,STACK
	PRINTI	" chases you out.

"
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL26
	ICALL	RT-GOTO,RM-ABOVE-FOREST,TRUE-VALUE
	JUMP	?CND14
?CCL26:	CALL1	RT-CLIMB-DOWN >RM
	ZERO?	RM /?CND14
	ICALL	RT-GOTO,RM,TRUE-VALUE
	JUMP	?CND14
?CCL23:	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE \?CCL30
	PRINTI	" picks you up. He carries you off and drops you from a great height onto a hard rock.
"
	ICALL1	RT-END-OF-GAME
	JUMP	?CND14
?CCL30:	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER \?CND14
	PRINTI	" kills you.
"
	ICALL1	RT-END-OF-GAME
?CND14:	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL3:	ADD	GL-MOVES,2
	ICALL	RT-QUEUE,RT-I-RAV-NEST-3,STACK
	MOVE	CH-RAVEN,RM-RAVEN-NEST
	FCLEAR	CH-RAVEN,FL-LOCKED
	ZERO?	GL-RAVEN-OBJ /?CND34
	MOVE	GL-RAVEN-OBJ,RM-RAVEN-NEST
	EQUAL?	GL-RAVEN-OBJ,TH-RAVEN-EGG \?CND36
	GETP	TH-RAVEN-EGG,P?SCORE
	ZERO?	STACK /?CND36
	FCLEAR	TH-RAVEN-EGG,FL-BROKEN
	PUTP	TH-RAVEN-EGG,P?SCORE,0
?CND36:	SET	'GL-RAVEN-OBJ,FALSE-VALUE
?CND34:	FSET?	CH-PLAYER,FL-ASLEEP /FALSE
	EQUAL?	HERE,RM-ABOVE-FOREST,RM-RAVEN-TREE \FALSE
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" lands in the nest."
	CRLF	
	EQUAL?	HERE,RM-ABOVE-FOREST \TRUE
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	


	.FUNCT	RT-I-RAV-NEST-3:ANY:0:0,EGG?
	FSET	CH-RAVEN,FL-BROKEN
	MOVE	CH-RAVEN,RM-ABOVE-FOREST
	IN?	TH-BRASS-EGG,RM-RAVEN-NEST \?CCL3
	IN?	TH-RAVEN-EGG,RM-RAVEN-NEST \?CCL3
	SET	'EGG?,TRUE-VALUE
	MOVE	TH-BRASS-EGG,RM-GROVE
	ICALL2	RT-RAVEN-WAIT-FOR,TH-BRASS-EGG
	JUMP	?CND1
?CCL3:	IN?	TH-RAVEN-EGG,RM-GROVE \?CCL7
	ICALL2	RT-RAVEN-WAIT-FOR,TH-RAVEN-EGG
	JUMP	?CND1
?CCL7:	IN?	TH-BRASS-EGG,RM-GROVE \?CND1
	ICALL2	RT-RAVEN-WAIT-FOR,TH-BRASS-EGG
?CND1:	EQUAL?	HERE,RM-ABOVE-FOREST,RM-RAVEN-TREE,RM-GROVE \FALSE
	CRLF	
	ZERO?	EGG? /?CND12
	EQUAL?	HERE,RM-GROVE \?CCL16
	FSET?	CH-PLAYER,FL-ASLEEP \?CCL19
	PRINTI	"Suddenly, you are awakened by the sound of something crashing through the leaves above. Your eyes fly open in a panic, and the last thing you ever see is a large brass egg approaching your head at terminal velocity. Seconds later, you, too, become terminal."
	CRLF	
	ICALL1	RT-END-OF-GAME
	JUMP	?CND12
?CCL19:	PRINTI	"Suddenly from above, you hear the sound of something heavy crashing through leaves and branches. You glance up and then jump aside just in time to avoid being killed by"
	ICALL	RT-PRINT-OBJ,TH-BRASS-EGG,K-ART-THE
	PRINTI	", which hits"
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
	PRINTI	" with a loud ""WHUMP!""

"
	JUMP	?CND12
?CCL16:	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" pushes"
	ICALL	RT-PRINT-OBJ,TH-BRASS-EGG,K-ART-THE
	PRINTI	" out of the nest. It lands in"
	ICALL	RT-PRINT-OBJ,RM-GROVE,K-ART-THE
	PRINTI	". "
?CND12:	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	" leaves the nest and resumes circling the forest.
"
	EQUAL?	HERE,RM-ABOVE-FOREST \TRUE
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	


	.FUNCT	RT-RAVEN-WAIT-FOR:ANY:1:1,OBJ,N
	SET	'GL-RAVEN-OBJ,OBJ
	FSET?	CH-RAVEN,FL-BROKEN \?CCL3
	SET	'N,6
	JUMP	?CND1
?CCL3:	SET	'N,2
?CND1:	ADD	GL-MOVES,N
	CALL	RT-QUEUE,RT-I-RAV-GROVE-1,STACK
	RSTACK	

	.SEGMENT "OWL"


	.FUNCT	RT-RM-ABOVE-FOREST:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	FSET	RM-RAVEN-NEST,FL-SEEN
	FSET	RM-RAVEN-TREE,FL-SEEN
	PRINT	K-FLY-HIGH-MSG
	PRINTC	32
	EQUAL?	OHERE,RM-TOW-CLEARING \?CCL6
	PRINTC	89
	JUMP	?CND4
?CCL6:	PRINTI	"In the distance, y"
?CND4:	PRINTI	"ou see an ivory tower rising above the trees"
	EQUAL?	OHERE,RM-TOW-CLEARING \?CCL9
	PRINTI	" nearby. In the distance"
	JUMP	?CND7
?CCL9:	PRINTI	". Nearby"
?CND7:	PRINTI	", one tall tree sticks up above the rest. In its uppermost branches is a huge nest"
	IN?	CH-RAVEN,RM-RAVEN-NEST /?CCL11
	IN?	TH-RAVEN-EGG,RM-RAVEN-NEST \?CND10
?CCL11:	PRINTI	", and sitting in the nest is"
	IN?	CH-RAVEN,RM-RAVEN-NEST \?CCL16
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE
	IN?	TH-RAVEN-EGG,RM-RAVEN-NEST \?CND10
	FSET	TH-RAVEN-EGG,FL-SEEN
	PRINTI	" and its solid gold egg"
	JUMP	?CND10
?CCL16:	FSET	TH-RAVEN-EGG,FL-SEEN
	PRINTI	" a solid gold giant raven's egg"
?CND10:	PRINTC	46
	IN?	CH-RAVEN,RM-ABOVE-FOREST \?CND19
	FSET	CH-RAVEN,FL-SEEN
	PRINTI	" Looking around, you see the giant raven "
	ZERO?	GL-RAVEN-OBJ /?CCL23
	IN?	GL-RAVEN-OBJ,CH-RAVEN \?CCL23
	PRINTI	"struggling to bring"
	ICALL	RT-PRINT-OBJ,GL-RAVEN-OBJ,K-ART-A
	PRINTI	" up to its nest."
	JUMP	?CND19
?CCL23:	FSET?	CH-RAVEN,FL-LOCKED \?CCL27
	PRINTI	"swooping down towards the grove."
	JUMP	?CND19
?CCL27:	PRINTI	"circling nearby."
?CND19:	FSET	RM-GROVE,FL-SEEN
	PRINTR	" Far below you, you see a grove."
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL29
	SET	'GL-PICTURE-NUM,K-PIC-AIR-SCENE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL29:	ZERO?	CONTEXT \FALSE
	RFALSE	

	.ENDSEG

	.SEGMENT "TOWER"


	.FUNCT	RT-RM-RAV-PATH:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are"
	ICALL1	RT-STANDING-MSG
	PRINTI	" on a narrow trail, deep within the enchanted forest."
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-ENCHANTED-FOREST \?CCL9
	PRINTI	"The path soon peters out into little more than a trail that continues to run to the northeast."
	JUMP	?CND4
?CCL9:	PRINTI	"The trail looks like it broadens into a path up ahead."
?CND4:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL11
	SET	'GL-PICTURE-NUM,K-PIC-FOREST-PATH
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL11:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-GROVE:ANY:0:1,CONTEXT,RM
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are in a grove of tall trees, deep within the enchanted forest."
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-RAV-PATH \?CCL9
	PRINTI	"The trail ends in a grove of tall trees."
?CND4:	FSET	RM-RAVEN-TREE,FL-SEEN
	PRINTI	" One tree in particular seems taller than the rest. A path to the southwest leads back into the forest.
"
	RFALSE	
?CCL9:	PRINTI	"You descend to the forest floor below.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL11
	EQUAL?	PRSA,V?LOOK-UP \FALSE
	EQUAL?	PRSO,ROOMS,RM-RAVEN-TREE \FALSE
	FSET	RM-RAVEN-NEST,FL-SEEN
	PRINTR	"At the very top of the tree you can see a large nest."
?CCL11:	EQUAL?	CONTEXT,M-END \?CCL18
	ZERO?	GL-RAVEN-OBJ /?CCL21
	IN?	GL-RAVEN-OBJ,CH-RAVEN /FALSE
	IN?	GL-RAVEN-OBJ,RM-GROVE /FALSE
	SET	'GL-RAVEN-OBJ,FALSE-VALUE
	CALL2	RT-DEQUEUE,RT-I-RAV-GROVE-1
	RSTACK	
?CCL21:	IN?	TH-RAVEN-EGG,RM-GROVE \?CCL28
	CALL2	RT-RAVEN-WAIT-FOR,TH-RAVEN-EGG
	RSTACK	
?CCL28:	IN?	TH-BRASS-EGG,RM-GROVE \FALSE
	CALL2	RT-RAVEN-WAIT-FOR,TH-BRASS-EGG
	RSTACK	
?CCL18:	EQUAL?	CONTEXT,M-ENTER \?CCL32
	SET	'GL-PICTURE-NUM,K-PIC-GROVE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL32:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?LAND-ON,V?ENTER,V?WALK-TO \FALSE
	EQUAL?	HERE,RM-RAVEN-NEST \?CCL41
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL44
	CALL2	RT-GOTO,RM-GROVE
	RSTACK	
?CCL44:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL46
	CALL1	RT-CLIMB-DOWN >RM
	ZERO?	RM /TRUE
	ICALL2	RT-GOTO,RM
	RTRUE	
?CCL46:	PRINT	K-DEADLY-FALL-MSG
	CRLF	
	RTRUE	
?CCL41:	EQUAL?	HERE,RM-ABOVE-FOREST \FALSE
	CALL2	RT-GOTO,RM-GROVE
	RSTACK	


	.FUNCT	RT-UP-RAV-GROVE:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL,K-FORM-SALAMANDER /?CCL6
	FSET?	RM-RAVEN-TREE,FL-TOUCHED \FALSE
?CCL6:	RETURN	RM-RAVEN-TREE
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL10
	CALL1	RT-FLY-UP
	RSTACK	
?CCL10:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL12
	CALL1	RT-CLIMB-UP
	RSTACK	
?CCL12:	ICALL1	RT-RAV-CANT-CLIMB-UP
	RFALSE	


	.FUNCT	RT-RM-RAVEN-TREE:ANY:0:1,CONTEXT,RM
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You are"
	EQUAL?	CONTEXT,M-LOOK /?CND4
	PRINTI	" now"
?CND4:	PRINTI	" clinging to the side of"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-TREE,K-ART-THE
	PRINTR	"."
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL7
	SET	'GL-PICTURE-NUM,K-PIC-RAVEN-TREE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL7:	EQUAL?	CONTEXT,M-BEG \?CCL11
	EQUAL?	PRSA,V?ENTER,V?CLIMB-OVER /?PRD16
	EQUAL?	PRSA,V?CLIMB-ON,V?CLIMB-DOWN,V?WALK-TO \?CCL14
?PRD16:	EQUAL?	PRSO,TH-GROUND \?CCL14
	EQUAL?	P-PRSA-WORD,W?JUMP,W?LEAP,W?DIVE \?CCL21
	CALL1	RT-JUMP-OFF-TREE-MSG
	RSTACK	
?CCL21:	CALL1	RT-CLIMB-DOWN-TREE-MSG
	RSTACK	
?CCL14:	EQUAL?	PRSA,V?ENTER,V?CLIMB-UP,V?WALK-TO \?CCL23
	EQUAL?	PRSO,TH-SKY \?CCL23
	CALL1	RT-CLIMB-UP-TREE-MSG
	RSTACK	
?CCL23:	EQUAL?	PRSA,V?JUMP \?CCL27
	CALL1	RT-JUMP-OFF-TREE-MSG
	RSTACK	
?CCL27:	EQUAL?	PRSA,V?LOOK-ON,V?EXAMINE \FALSE
	EQUAL?	PRSO,TH-GROUND \FALSE
	PRINTI	"The ground is "
	GRTR?	GL-RAV-P-CNT,3 \?CCL34
	PRINTI	"far"
	JUMP	?CND32
?CCL34:	GRTR?	GL-RAV-P-CNT,1 \?CCL36
	PRINTI	"a short distance"
	JUMP	?CND32
?CCL36:	PRINTI	"just"
?CND32:	PRINTR	" below you."
?CCL11:	EQUAL?	CONTEXT,M-END \?CCL38
	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER /FALSE
	CALL1	RT-FALL-OFF-TREE
	RSTACK	
?CCL38:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL45
	FSET	RM-RAVEN-TREE,FL-SEEN
	EQUAL?	HERE,RM-GROVE \?CCL48
	PRINTR	"The tree towers above you."
?CCL48:	EQUAL?	HERE,RM-RAVEN-NEST \?CCL50
	PRINTR	"The tree supports the raven's nest."
?CCL50:	EQUAL?	HERE,RM-ABOVE-FOREST \FALSE
	PRINTR	"The tree is far below you."
?CCL45:	EQUAL?	PRSA,V?CLIMB-UP \?CCL54
	CALL1	RT-CLIMB-UP-TREE-MSG
	RSTACK	
?CCL54:	EQUAL?	PRSA,V?CLIMB-DOWN \?CCL56
	CALL1	RT-CLIMB-DOWN-TREE-MSG
	RSTACK	
?CCL56:	EQUAL?	PRSA,V?DISMOUNT \?CCL58
	EQUAL?	HERE,RM-RAVEN-TREE \?CCL61
	CALL1	RT-JUMP-OFF-TREE-MSG
	RSTACK	
?CCL61:	DIROUT	D-TABLE-ON,K-DIROUT-TBL,0
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?25
	PRINTI	"n't on"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-TREE,K-ART-THE
	PRINTC	46
	CALL1	RT-AUTHOR-OFF
	RSTACK	
?CCL58:	EQUAL?	PRSA,V?ENTER,V?LAND-ON,V?WALK-TO \FALSE
	FSET?	HERE,FL-AIR \FALSE
	CALL2	RT-GOTO,RM-RAVEN-NEST
	RSTACK	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-GN-TREE:ANY:2:2,TBL,FINDER,PTR,N
	ADD	TBL,8 >PTR
	GET	TBL,1 >N
	INTBL?	RM-RAVEN-TREE,PTR,N \?CCL3
	RETURN	RM-RAVEN-TREE
?CCL3:	INTBL?	P-IT-OBJECT,PTR,N \FALSE
	RETURN	P-IT-OBJECT

	.ENDSEG

	.SEGMENT "TOWER"


	.FUNCT	RT-CLIMB-UP:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	EQUAL?	HERE,RM-RAVEN-TREE /?CTR5
	RETURN	RM-RAVEN-TREE
?CTR5:	RETURN	RM-RAVEN-NEST
?CCL3:	EQUAL?	HERE,RM-RAVEN-TREE \?CCL8
	IGRTR?	'GL-RAV-P-CNT,K-RAVEN-TREE-MAX \?CCL11
	PRINTI	"You reach the top of"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-TREE,K-ART-THE
	PRINTI	" and climb into"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-NEST,K-ART-THE
	PRINTI	".

"
	RETURN	RM-RAVEN-NEST
?CCL11:	ICALL2	RT-RAV-CLIMBING,K-CLIMB-UP
	RFALSE	
?CCL8:	SET	'GL-RAV-P-CNT,0
	RETURN	RM-RAVEN-TREE


	.FUNCT	RT-CLIMB-DOWN:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	EQUAL?	HERE,RM-RAVEN-TREE /?CTR5
	RETURN	RM-RAVEN-TREE
?CTR5:	RETURN	RM-GROVE
?CCL3:	EQUAL?	HERE,RM-RAVEN-TREE \?CCL8
	DLESS?	'GL-RAV-P-CNT,1 \?CCL11
	PRINTI	"You reach the foot of"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-TREE,K-ART-THE
	PRINTI	" and jump off onto the ground.

"
	RETURN	RM-GROVE
?CCL11:	ICALL2	RT-RAV-CLIMBING,K-CLIMB-DN
	RFALSE	
?CCL8:	SET	'GL-RAV-P-CNT,K-RAVEN-TREE-MAX
	RETURN	RM-RAVEN-TREE


	.FUNCT	RT-CLIMB-UP-TREE-MSG:ANY:0:0,RM
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL3
	EQUAL?	HERE,RM-RAVEN-NEST \?CCL6
	CALL	RT-YOU-CANT-MSG,STR?286,RM-RAVEN-TREE
	RSTACK	
?CCL6:	CALL2	RT-GOTO,RM-RAVEN-NEST
	RSTACK	
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL8
	CALL1	RT-CLIMB-UP >RM
	ZERO?	RM /TRUE
	ICALL2	RT-GOTO,RM
	RTRUE	
?CCL8:	CALL1	RT-RAV-CANT-CLIMB-UP
	RSTACK	


	.FUNCT	RT-CLIMB-DOWN-TREE-MSG:ANY:0:0,RM
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL3
	EQUAL?	HERE,RM-GROVE \?CCL6
	CALL	RT-YOU-CANT-MSG,STR?287,RM-RAVEN-TREE
	RSTACK	
?CCL6:	CALL2	RT-GOTO,RM-GROVE
	RSTACK	
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL8
	CALL1	RT-CLIMB-DOWN >RM
	ZERO?	RM /TRUE
	ICALL2	RT-GOTO,RM
	RTRUE	
?CCL8:	PRINT	K-DEADLY-FALL-MSG
	CRLF	
	RTRUE	


	.FUNCT	RT-JUMP-OFF-TREE-MSG:ANY:0:0
	LESS?	GL-RAV-P-CNT,4 \?CCL3
	MOVE	CH-PLAYER,RM-GROVE
	SET	'OHERE,HERE
	SET	'HERE,RM-GROVE
	PRINTI	"You leap off of"
	ICALL	RT-PRINT-OBJ,RM-RAVEN-TREE,K-ART-THE
	PRINTI	" and fall to"
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
	PRINTI	", a bit bruised and battered but otherwise alright."
	CRLF	
	SET	'GL-PICTURE-NUM,K-PIC-GROVE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL6
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL6:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CCL8
	ICALL1	RT-UPDATE-PICT-WINDOW
	RTRUE	
?CCL8:	EQUAL?	GL-WINDOW-TYPE,K-WIN-MAP \TRUE
	ICALL1	RT-UPDATE-MAP-WINDOW
	RTRUE	
?CCL3:	PRINT	K-DEADLY-FALL-MSG
	CRLF	
	RTRUE	


	.FUNCT	RT-RM-RAVEN-NEST:ANY:0:1,CONTEXT,RM,EGG?
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL8
	PRINTI	"land in"
	JUMP	?CND4
?CCL8:	PRINTI	"climb into"
?CND4:	FSET	RM-GROVE,FL-SEEN
	ICALL	RT-PRINT-OBJ,RM-RAVEN-NEST,K-ART-THE
	PRINTI	".
Far below you, you see"
	ICALL	RT-PRINT-OBJ,RM-GROVE,K-ART-THE
	PRINTC	46
	IN?	CH-RAVEN,RM-RAVEN-NEST \?CCL11
	FSET	CH-RAVEN,FL-SEEN
	PRINTI	" The other occupant of the nest is a giant raven that is clearly unhappy with your presence."
	JUMP	?CND9
?CCL11:	FSET?	CH-RAVEN,FL-LOCKED /?CND9
	ZERO?	GL-RAVEN-OBJ \?CND9
	FSET	CH-RAVEN,FL-SEEN
	PRINTI	" You can see"
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE
	PRINTI	" circling above."
?CND9:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL16
	SET	'GL-PICTURE-NUM,K-PIC-RAVEN-NEST
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL16:	EQUAL?	CONTEXT,M-ENTERED \?CCL20
	IN?	CH-RAVEN,RM-RAVEN-NEST \?CCL23
	CRLF	
	ICALL	RT-PRINT-OBJ,CH-RAVEN,K-ART-THE,TRUE-VALUE
	PRINTI	"'s razor-like talons dig into your flesh and kill you instantly.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL23:	FSET?	CH-RAVEN,FL-LOCKED /TRUE
	ZERO?	GL-RAVEN-OBJ /?CCL26
	ICALL2	RT-DEQUEUE,RT-I-RAV-GROVE-1
	CALL1	RT-I-RAV-GROVE-1
	RSTACK	
?CCL26:	CALL1	RT-I-RAV-NEST-1
	RSTACK	
?CCL20:	EQUAL?	CONTEXT,M-BEG \?CCL28
	EQUAL?	PRSA,V?DROP \?PRD33
	EQUAL?	P-PRSA-WORD,W?THROW /?CTR30
?PRD33:	EQUAL?	PRSA,V?PUT-IN,V?PUT \?PRD36
	EQUAL?	PRSI,TH-GROUND,RM-GROVE /?CTR30
?PRD36:	EQUAL?	PRSA,V?THROW \?PRD39
	EQUAL?	PRSI,FALSE-VALUE,ROOMS,TH-GROUND /?CTR30
	EQUAL?	PRSI,RM-GROVE /?CTR30
?PRD39:	EQUAL?	PRSA,V?EXTEND \?PRD44
	EQUAL?	PRSI,FALSE-VALUE,ROOMS,RM-RAVEN-NEST /?CTR30
	EQUAL?	PRSI,GLOBAL-HERE /?CTR30
?PRD44:	EQUAL?	PRSA,V?MOVE \?CCL31
?CTR30:	ZERO?	GL-PLAYER-FORM \?CCL51
	MOVE	PRSO,RM-GROVE
	EQUAL?	PRSO,TH-RAVEN-EGG \?CND52
	FSET?	TH-RAVEN-EGG,FL-BROKEN /?CND52
	FSET	TH-RAVEN-EGG,FL-BROKEN
	PUTP	TH-RAVEN-EGG,P?SCORE,4258
?CND52:	PRINTI	"You throw"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTI	" to"
	ICALL	RT-PRINT-OBJ,RM-GROVE,K-ART-THE
	PRINTI	" below."
	CRLF	
	EQUAL?	PRSO,TH-RAVEN-EGG,TH-BRASS-EGG \TRUE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \TRUE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RTRUE	
?CCL51:	EQUAL?	PRSO,TH-RAVEN-EGG,TH-BRASS-EGG \?CCL62
	PRINTI	"The egg is solid "
	EQUAL?	PRSO,TH-RAVEN-EGG \?CCL65
	PRINTI	"gold"
	JUMP	?CND63
?CCL65:	PRINTI	"brass"
?CND63:	PRINTI	". It's too heavy for"
	ICALL2	RT-FORM-MSG,K-ART-A
	PRINTR	" to move."
?CCL62:	CALL2	RT-ANIMAL-CANT-MSG,STR?288
	RSTACK	
?CCL31:	EQUAL?	PRSA,V?ENTER,V?CLIMB-OVER /?PRD69
	EQUAL?	PRSA,V?CLIMB-ON,V?CLIMB-DOWN,V?WALK-TO \?CCL67
?PRD69:	EQUAL?	PRSO,TH-GROUND \?CCL67
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL,K-FORM-SALAMANDER \?CCL74
	CALL2	RT-DO-WALK,P?DOWN
	RSTACK	
?CCL74:	PRINTI	"Throwing caution to the winds, you stand on the edge of the nest and execute a perfect swan dive into the air. Just as it occurs to you that you are not a swan, it occurs to the ground to smash into - and kill - you."
	CRLF	
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL67:	EQUAL?	PRSA,V?ENTER,V?CLIMB-UP,V?WALK-TO \FALSE
	EQUAL?	PRSO,TH-SKY \FALSE
	CALL2	RT-DO-WALK,P?UP
	RSTACK	
?CCL28:	EQUAL?	CONTEXT,M-END \?CCL80
	IN?	TH-RAVEN-EGG,RM-RAVEN-NEST /?PST82
	IN?	TH-BRASS-EGG,RM-RAVEN-NEST /?PRD84
	PUSH	0
	JUMP	?PRD85
?PRD84:	PUSH	1
?PRD85:	SET	'EGG?,STACK
	JUMP	?PEN81
?PST82:	SET	'EGG?,1
?PEN81:	EQUAL?	EGG?,GL-EGG-IN-NEST? /FALSE
	SET	'GL-EGG-IN-NEST?,EGG?
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL80:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL93
	EQUAL?	PRSA,V?PUT-IN,V?PUT,V?THROW \FALSE
	EQUAL?	HERE,RM-GROVE \FALSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?25
	PRINTI	"n't strong enough to throw"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	" that high."
?CCL93:	EQUAL?	PRSA,V?EXAMINE \?CCL101
	FSET	RM-RAVEN-NEST,FL-SEEN
	EQUAL?	HERE,RM-GROVE \?CCL104
	PRINTR	"The nest is at the very top of the tree."
?CCL104:	EQUAL?	HERE,RM-RAVEN-TREE \?CCL106
	PRINTR	"It looks like the home of a giant raven."
?CCL106:	EQUAL?	HERE,RM-ABOVE-FOREST \FALSE
	PRINTR	"The nest is below you in the top of the tree."
?CCL101:	EQUAL?	PRSA,V?LAND-ON,V?ENTER,V?WALK-TO \?CCL110
	EQUAL?	HERE,RM-GROVE \?CCL113
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL116
	CALL2	RT-GOTO,RM-RAVEN-NEST
	RSTACK	
?CCL116:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL118
	CALL1	RT-CLIMB-UP >RM
	ZERO?	RM /TRUE
	ICALL2	RT-GOTO,RM
	RTRUE	
?CCL118:	CALL1	RT-RAV-CANT-CLIMB-UP
	RSTACK	
?CCL113:	EQUAL?	HERE,RM-ABOVE-FOREST \FALSE
	CALL2	RT-GOTO,RM-RAVEN-NEST
	RSTACK	
?CCL110:	EQUAL?	PRSA,V?LOOK-IN \FALSE
	EQUAL?	HERE,RM-ABOVE-FOREST \FALSE
	PRINTI	"You see"
	ICALL2	PRINT-CONTENTS,RM-RAVEN-NEST
	ICALL2	RT-IN-ON-MSG,RM-RAVEN-NEST
	ICALL	RT-PRINT-OBJ,RM-RAVEN-NEST,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-EXIT-NEST:ANY:0:1,QUIET
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL3
	EQUAL?	P-WALK-DIR,P?DOWN \?CCL6
	RETURN	RM-GROVE
?CCL6:	CALL2	RT-FLY-UP,QUIET
	RSTACK	
?CCL3:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL8
	CALL2	RT-CLIMB-DOWN,QUIET
	RSTACK	
?CCL8:	ZERO?	QUIET \FALSE
	PRINTI	"Throwing caution to the winds, you stand on the edge of the nest and execute a perfect swan dive into the air. Just as it occurs to you that you are not a swan, it occurs to the ground to smash into - and kill - you."
	CRLF	
	ICALL1	RT-END-OF-GAME
	RFALSE	

	.ENDSEG

	.ENDI