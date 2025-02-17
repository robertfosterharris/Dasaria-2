
// gui_d2_mount
// wired 01/29/2012
#include "std_inc_mounts"


void main()
{
	object oPC = OBJECT_SELF;
	object oMount = GetPlayerCurrentTarget(oPC);
	int nMountType;
	string sTag = GetTag(oMount);
	

	if (!GetIsObjectValid(oMount)) return;
	
	if (GetIsAreaInterior(GetArea(oPC))) return;
	
	nMountType = StringToInt(GetStringRight(sTag,1));

	if (GetDistanceBetween(oPC,oMount) > 5.0f)
	{
		SendMessageToPC(oPC,"That creature is too far away to mount.");
		return;	
	}	
	
	// special case: paladin mounting their animal companion
	if (GetHasFeat(3041,oPC,TRUE) && GetMaster(oMount) == oPC)
	{
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Paladin Special Case");
		AssignCommand(oPC,ActionMount(oMount,0));
		return;
	}
		
	if (nMountType == 0 || GetStringLeft(sTag,8) != "d2_mount"  )
	{
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: MountType was 0 OR Tag didn't start with d2_mount");
		SendMessageToPC(oPC,"You cannot mount that creature.");
		return;
	}
	
	if (GetLocalObject(oMount,"oRider") != oPC)
	{
		SetLocalObject(oPC,"oMountTarget",oMount);
		DisplayMessageBox(oPC,0,"This is not your mount. Steal mount?","gui_d2_steal_mount","",TRUE,SCREEN_MESSAGEBOX_DEFAULT,0,"STEAL",0,"CANCEL");
		return;
	}

	AssignCommand(oPC,ActionMount(oMount,nMountType));
}