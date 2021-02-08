
	.SEGMENT "0"


	.FUNCT	V-HINTS-NO:ANY:0:0
	EQUAL?	PRSO,ROOMS /?CCL3
	ICALL1	DONT-UNDERSTAND
	JUMP	?CND1
?CCL3:	SET	'GL-HINTS-OFF,TRUE-VALUE
	ICALL2	RT-AUTHOR-MSG,K-NO-HINTS-MSG
?CND1:	SET	'CLOCK-WAIT,TRUE-VALUE
	RETURN	2


	.FUNCT	V-HINT:ANY:0:0,N,WHO
	ZERO?	GL-HINTS-OFF /?CCL3
	PRINTI	"You look inside the crystal, but it has gone dark. Merlin's voice echoes in your mind, ""Earlier, in the true spirit of adventure, you disabled the hints. Go forward, therefore, and continue your quest."""
	CRLF	
	JUMP	?CND1
?CCL3:	PRINTI	"You look inside the ball and see the hazy outline of a hint menu."
	ZERO?	GL-HINT-WARNING \?CCL6
	SET	'GL-HINT-WARNING,TRUE-VALUE
	PRINTI	"

Merlin comes into the cave and says, ""You can get a hint simply by looking in the crystal. But I know that sometimes you will be tempted to get a hint before you really want or need to. Therefore, you may at any time during your adventure type HINTS OFF, and I will make the crystal go dark. This will disallow the seeking of help for the remainder of that session. If you still want a hint now, then look once more into the crystal.""

Merlin disappears.
"
	JUMP	?CND1
?CCL6:	PRINTI	"..
"
	INPUT	1,50,RT-STOP-READ
	ICALL1	DO-HINTS
	ICALL2	V-$REFRESH,FALSE-VALUE
	PRINTI	"Back to the story..."
	CRLF	
?CND1:	SET	'CLOCK-WAIT,TRUE-VALUE
	RETURN	2

	.ENDSEG

	.SEGMENT "HINTS"


	.FUNCT	RT-H-STONE-STOLEN?:ANY:0:0
	IN?	TH-STONE,RM-CHURCHYARD \TRUE
	RFALSE	


	.FUNCT	RT-H-LOT-ATTENTION-2?:ANY:0:0
	FSET?	RM-GREAT-HALL,FL-TOUCHED \FALSE
	FSET?	TH-GAUNTLET,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-FIGHT-LOT?:ANY:0:0
	IN?	CH-LOT,RM-FIELD-OF-HONOR /TRUE
	FSET?	CH-LOT,FL-LOCKED /TRUE
	RFALSE	


	.FUNCT	RT-H-BEAT-LOT?:ANY:0:0
	FSET?	CH-LOT,FL-LOCKED /TRUE
	RFALSE	


	.FUNCT	RT-H-DEFEAT-LOT?:ANY:0:0
	FSET?	CH-LOT,FL-BROKEN \FALSE
	FSET?	CH-LOT,FL-LOCKED /TRUE
	RFALSE	


	.FUNCT	RT-H-I-KNIGHT-2?:ANY:0:0
	FSET?	RM-MEADOW,FL-TOUCHED \FALSE
	FSET?	TH-MAGIC-RING,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-CASTLE-2?:ANY:0:0
	FSET?	RM-CASTLE-GATE,FL-TOUCHED \FALSE
	FSET?	RM-HOLE,FL-TOUCHED /TRUE
	RFALSE	


	.FUNCT	RT-H-PASSWORD-2?:ANY:0:0
	FSET?	RM-CASTLE-GATE,FL-TOUCHED \FALSE
	FSET?	RM-CELL,FL-TOUCHED /TRUE
	RFALSE	


	.FUNCT	RT-H-PASSWORD-3?:ANY:0:0
	FSET?	RM-CASTLE-GATE,FL-TOUCHED \FALSE
	FSET?	RM-HALL,FL-TOUCHED /TRUE
	RFALSE	


	.FUNCT	RT-H-HEARD-PASSWORD?:ANY:0:0
	FSET?	TH-PASSWORD,FL-TOUCHED /TRUE
	RFALSE	


	.FUNCT	RT-H-PRISONER-OUT?:ANY:0:0
	FSET?	CH-PRISONER,FL-AIR /TRUE
	RFALSE	


	.FUNCT	RT-H-PRISONER-2?:ANY:0:0
	FSET?	RM-CELL,FL-TOUCHED \FALSE
	FSET?	CH-CELL-GUARD,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-SWORD?:ANY:0:0
	FSET?	TH-SWORD,FL-LOCKED \TRUE
	RFALSE	


	.FUNCT	RT-H-BRACELET-2?:ANY:0:0
	FSET?	CH-KRAKEN,FL-SEEN \FALSE
	LOC	CH-KRAKEN
	ZERO?	STACK \FALSE
	RTRUE	


	.FUNCT	RT-H-HEARD-MURMUR?:ANY:0:0
	FSET?	TH-ROCK,FL-BROKEN /TRUE
	RFALSE	


	.FUNCT	RT-H-EGG-2?:ANY:0:0
	FSET?	TH-RAVEN-EGG,FL-SEEN \FALSE
	FSET?	TH-BRASS-EGG,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-TOWER-2?:ANY:0:0
	FSET?	RM-TOW-CLEARING,FL-TOUCHED \FALSE
	FSET?	TH-IVORY-KEY,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-NAME-2?:ANY:0:0
	FSET?	CH-RHYMER,FL-SEEN \FALSE
	FSET?	RM-CRACK-ROOM,FL-TOUCHED /TRUE
	RFALSE	


	.FUNCT	RT-H-NAME-3?:ANY:0:0
	FSET?	CH-RHYMER,FL-SEEN \FALSE
	FSET?	RM-CRACK-ROOM,FL-TOUCHED \FALSE
	FSET?	RM-CELLAR,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-TUSK-2?:ANY:0:0
	FSET?	RM-NORTH-OF-CHASM,FL-TOUCHED \FALSE
	FSET?	TH-BOAR,FL-ALIVE /FALSE
	RTRUE	


	.FUNCT	RT-H-SEEN-BOG?:ANY:0:0
	FSET?	RM-BOG,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-SEEN-THORNY-ISLAND?:ANY:0:0
	FSET?	RM-THORNEY-ISLAND,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-BLACK-KNIGHT-2?:ANY:0:0
	FSET?	CH-BLACK-KNIGHT,FL-SEEN \FALSE
	FSET?	TH-SWORD,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-BLACK-KNIGHT-3?:ANY:0:0
	FSET?	CH-BLACK-KNIGHT,FL-SEEN \FALSE
	FSET?	TH-SWORD,FL-SEEN \FALSE
	LESS?	GL-SC-EXP,66 /FALSE
	RTRUE	


	.FUNCT	RT-H-DRAGON-2?:ANY:0:0
	FSET?	CH-DRAGON,FL-SEEN \FALSE
	FSET?	TH-WHISKY-JUG,FL-SEEN /TRUE
	RFALSE	


	.FUNCT	RT-H-TALKING-DOOR-2?:ANY:0:0
	FSET?	RM-HOT-ROOM,FL-TOUCHED \FALSE
	FSET?	RM-ICE-ROOM,FL-TOUCHED /TRUE
	RFALSE	


	.FUNCT	RT-H-SEEN-DEMON?:ANY:0:0
	FSET?	CH-DEMON,FL-LOCKED \TRUE
	RFALSE	

	.ENDSEG

	.ENDI
