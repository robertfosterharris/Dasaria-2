//	ON ENTER - DISPLAYS A MESSAGE BASED ON SUCCESSFUL SKILL CHECK
//
//	TRIGGER VARIABLES
//
//	int nSkill			- THE SKILL BEING USED
//	int nDC				- THE DIFFICULTY CLASS OF THE SKILL
//	string sMessage		- THE MESSAGE TO DISPLAY
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	09/14/2009

#include "std_i0_skill"

void main()
{
	object oPC;
	
	oPC = GetEnteringObject();
	
	if (GetLocalInt(oPC, GetTag(OBJECT_SELF) + "_DONE") == 0)
	{
		if (GetIsSkillSuccessfulPrivate(oPC, GetLocalInt(OBJECT_SELF, "nSkill"), GetLocalInt(OBJECT_SELF, "nDC")))
		{
			SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "sMessage"));
		}
		SetLocalInt(oPC, GetTag(OBJECT_SELF) + "_DONE", 1);
	}
}