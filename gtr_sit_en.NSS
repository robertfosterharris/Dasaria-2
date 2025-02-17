//	ON ENTER - MAKES CREATURES SIT DOWN AGAIN
//
//	TRIGGER VARIABLES
//
//	sCreatures 	- A COMMA DELIMITED LIST OF NPC TAGS TO HAVE SIT
//
//	USAGE NOTES:
//	SEE GB_SIT_SP
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/03/2007
//
#include "x0_i0_stringlib"

void Sit(object oCreature);

void main()
{
	int nNth;
	object oCreature;
	string sCreature;
	string sCreatures;

	nNth = 0;
	sCreatures = GetLocalString(OBJECT_SELF, "sCreatures");
    
	sCreature = GetTokenByPosition(sCreatures, ",", nNth);
	while (sCreature != "")
	{
		oCreature = GetObjectByTag(sCreature);
		SetAILevel(oCreature, AI_LEVEL_NORMAL);
		ClearAllActions(TRUE);
		ActionJumpToLocation(GetLocalLocation(oCreature, "lChair"));
		ActionDoCommand(Sit(oCreature));
		SetAILevel(oCreature, AI_LEVEL_DEFAULT);
		nNth++;
		sCreature = GetTokenByPosition(sCreatures, ",", nNth);
	}
}

void Sit(object oCreature)
{
	PlayCustomAnimation(oCreature, "sitidle", 1);
}