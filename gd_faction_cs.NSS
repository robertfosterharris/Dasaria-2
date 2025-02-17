//	ON CLOSED - LOCKS THE DOOR FOR FACTION MEMBERS
//
//	ROBERT HARRIS	10/31/2008	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_faction"

void main()
{
	object oPC;
	string sFaction;
	
	oPC = GetLastClosedBy();
	if (GetIsPC(oPC))
	{
		sFaction = GetLocalString(OBJECT_SELF, "sFaction");
		if (GetIsInFaction(oPC, sFaction))
		{
			ActionLockObject(OBJECT_SELF);
		}
	}
}