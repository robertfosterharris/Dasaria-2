// gc_mount_gold
// wired 02/04/2012

#include "std_inc_mounts"

int StartingConditional(int nMountType)
{

    object oPC = GetPCSpeaker();
	int nGold = GetMountPrice(nMountType);

    if ( GetGold(oPC) >= nGold ) return TRUE;
    

    return FALSE;

}