//	ON ENTER - MAKES PLACEABLES USEABLE BASED ON SUCCESSFUL SKILL CHECK
//
//	SEE SISTER SCRIPT - GTR_USEABLE_BY_SKILL_EX
//
//	TRIGGER VARIABLES
//
//	nSkill		- THE SKILL BEING USED
//	nDC			- THE DIFFICULTY CLASS OF THE SKILL
//	sPlaceables	- A COMMA DELIMITED LIST OF OBJECT TAGS TO MAKE USEABLE
//	sMessage	- MESSAGE TO SEND PC ON SUCCESSFUL CHECK
//
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	11/21/2007
//
//	10/03/2012		RFH		MADE MULTIPLAYER FRIENDLY
//							ONCE FOUND ALWAYS FOUND
//
#include "x0_i0_stringlib"
#include "std_i0_skill"

void recursiveCheck(object oPC);
int GetIsInTrigger(object oPC);

void main()
{
	object oPC;
	
	oPC = GetEnteringObject();
	if (GetIsPC(oPC))
	{
		recursiveCheck(oPC);
	}
}

void recursiveCheck(object oPC)
{
	int nNth;
	object oPlaceable;
	string sPlaceable;
	string sPlaceables;

	if ((GetLocalInt(OBJECT_SELF, "USEABLE_" + GetTag(OBJECT_SELF)) == FALSE) && GetIsInTrigger(oPC))
	{
		if (GetIsSkillSuccessfulPrivate(oPC, GetLocalInt(OBJECT_SELF, "nSkill"), GetLocalInt(OBJECT_SELF, "nDC")) || GetLocalInt(oPC, "FOUND_" + GetTag(OBJECT_SELF)) == TRUE)
		{
			nNth = 0;
			sPlaceables = GetLocalString(OBJECT_SELF, "sPlaceables");
			sPlaceable = GetTokenByPosition(sPlaceables, ",", nNth);
			while (sPlaceable != "")
			{
				oPlaceable = GetObjectByTag(sPlaceable);
				SetUseableFlag(oPlaceable, TRUE);
				nNth++;
				sPlaceable = GetTokenByPosition(sPlaceables, ",", nNth);
			}
			PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);
			SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "sMessage"));
			SetLocalInt(OBJECT_SELF, "USEABLE_" + GetTag(OBJECT_SELF), TRUE);
			SetLocalInt(oPC, "FOUND_" + GetTag(OBJECT_SELF), TRUE);
		}
		else
		{
			DelayCommand(6.0, recursiveCheck(oPC));
		}
	}
}

int GetIsInTrigger(object oPC)
{
	int bInTrigger = FALSE;
	object oCreature;
	
	oCreature = GetFirstInPersistentObject();
	if (oCreature == oPC) bInTrigger = TRUE;
	
	while (GetIsObjectValid(oCreature) && !bInTrigger)
	{
		oCreature = GetNextInPersistentObject();
		if (oCreature == oPC) bInTrigger = TRUE;
	}
	
	return bInTrigger;
}