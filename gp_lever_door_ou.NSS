//	ON USED - UNLOCKS AND/OR OPENS A COMMA DELIMITED LIST OF DOOR
//
//	OBJECT VARIABLES:
//	sDoorList	COMMA DELEIMTED LIST OF DOORS TO UNLOCK
//	bOpen		1 TO OPEN
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	05/07/2012
//
#include "x0_i0_stringlib"

void unlockDoor(object oDoor, int bOpen);

void main()
{
	int bOpen;
	int nNth;
    object oPC;
    object oDoor;
	string sDoor;
	string sDoorList;
	
	nNth = 0;
	bOpen = GetLocalInt(OBJECT_SELF, "bOpen");
	sDoorList = GetLocalString(OBJECT_SELF, "sDoorList");
	sDoor = GetTokenByPosition(sDoorList, ",", nNth);
	
	while (sDoor != "")
	{
		oDoor = GetObjectByTag(sDoor);
		if (GetIsObjectValid(oDoor))
		{
			unlockDoor(oDoor, bOpen);
		}
		nNth++;
		sDoor = GetTokenByPosition(sDoorList, ",", nNth);
	}
}

void unlockDoor(object oDoor, int bOpen)
{
	object oPC = GetLastUsedBy();
	
	PlaySound("as_sw_lever1");
	if (GetLocked(oDoor))
	{
		ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
		DelayCommand(0.25f, AssignCommand(oDoor, SetLocked(oDoor, FALSE)));
		if (bOpen) DelayCommand(0.50f, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
		SendMessageToPC(oPC, "Unlocked.");
	}
	else
	{
		ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
		DelayCommand(0.25f, AssignCommand(oDoor, ActionCloseDoor(oDoor)));
		DelayCommand(0.50f, AssignCommand(oDoor, SetLocked(oDoor, TRUE)));
		SendMessageToPC(oPC, "Locked.");
	}
}				