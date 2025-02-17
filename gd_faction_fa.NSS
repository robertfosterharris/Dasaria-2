//	ON FAILED TO OPEN - UNLOCKS AND OPENS DOORS FOR FACTION MEMBERS
//
//	ROBERT HARRIS	10/31/2008	ROBERTHARRIS@ROBERTHARRIS.COM
//
//  Wired 02/09/2009 Change ActionUnlockObject to SetLocked FALSE to support transitions
#include "ginc_faction"

void main()
{
	object oPC;
	string sFaction;
	
	oPC = GetClickingObject();
	sFaction = GetLocalString(OBJECT_SELF, "sFaction");
	if (GetIsInFaction(oPC, sFaction))
	{
		SetLocked(OBJECT_SELF,FALSE);
		ActionOpenDoor(OBJECT_SELF);
		SendMessageToPC(oPC, "You used a key.");
		DelayCommand(15.0f, ActionCloseDoor(OBJECT_SELF));
		DelayCommand(15.0f, SetLocked(OBJECT_SELF, TRUE));
	}		
}