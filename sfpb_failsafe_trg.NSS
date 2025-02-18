// sfpb_failsafe_trg
// wired 2009/06/19

#include "sfpb_config"
#include "std_i0_markofdeath"

void ActionRespawn(string sResRef, location lDest)
{
	CreateObject(OBJECT_TYPE_PLACEABLE,sResRef,lDest,TRUE);
}

void main()
{
	object oPC = GetExitingObject();
	object oChest = GetNearestObjectByTag("SFPB_Chest");
	string sUserID = GetLocalString(oChest, "USER_ID");
	string sID = SF_GetPlayerID(oPC);
	location lDest = GetLocation(oChest);

	// sUserID should have been deleted off
	// the chest if sfpb_closed had fired 
	// properly, so if the player's ID is still
	// on the chest, we're in a bugged
	// placeable scenario

	
	// check again
	sUserID = GetLocalString(oChest, "USER_ID");
	if (sUserID == sID)  
	{
		SendMessageToPC(oPC,"FAILSAFE: CHEST SAVE HAS FAILED; DESTROYING CHEST. PLEASE RECOVER YOUR ITEMS MANUALLY.");
		SendMessageToPC(oPC,"FAILSAFE: EMPTY CHEST WILL RESPAWN IN THREE MINUTES.");
		SetPlotFlag(oChest,FALSE);
		DelayCommand(180.0,ActionRespawn(GetResRef(oChest),GetLocation(oChest)));
		DestroyObject(oChest);		
	}	
}