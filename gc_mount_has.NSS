// gc_has_mount
// wired 02/04/2012
// check if player owns a mount

#include "std_inc_mounts"

int StartingConditional()
{

    object oPC = GetPCSpeaker();
	
	if (GetMountType(oPC) > 0) return TRUE;
	else return FALSE;

}