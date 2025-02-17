//	ON ENTER/EXIT - TRIGGER sNPC CONVERSATION WITH ENTERING PC
//
//  ROBERT HARRIS   12/10/2012	ROBERTHARRIS@ROBERTHARRIS.COM
//	
//	ROBERT HARRIS	12/10/2012	REMOVED GETOBJECTSEEN CHECK.  PERCEPTION EVENT MAY NOT HAVE FIRED PRIOR TO ENTERING TRIGGER.
//
#include "std_i0_misc"

void main()
{
	object oNPC;
	object oPC;
	string sNPC;
	
	sNPC = GetLocalString(OBJECT_SELF, "sNPC");
	
	oPC = GetEnteringObject();
	oNPC = GetNearestObjectByTag(sNPC);
	
	if (GetIsPC(oPC) && GetIsObjectValid(oNPC))
	{
		if (GetLocalInt(oPC, sNPC + "_spoken") == 0 && !GetIsInCombat(oPC) && !GetIsInCombat(oNPC))
		{
			SetPartyInt(oPC, sNPC + "_spoken", 1);
			AssignCommand(oNPC, ActionStartConversation(oPC, "", FALSE, FALSE, TRUE, FALSE));
		}
	}
}