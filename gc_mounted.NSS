// gc_mounted
// wired 02/04/2012
// check if player is mounted

#include "std_inc_mounts"

int StartingConditional()
{

    object oPC = GetPCSpeaker();
	
	return GetIsMounted(oPC);

}