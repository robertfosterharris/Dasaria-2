// gc_mount_valid
// wired 02/04/2012
// check if mount is already spawned

#include "std_inc_mounts"

int StartingConditional()
{

    object oPC = GetPCSpeaker();
	object oMount = GetLocalObject(oPC,"oMount");
	
	if (GetIsObjectValid(oMount))
	{
		return TRUE;
	}
	return FALSE;
}