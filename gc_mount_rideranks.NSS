// gc_mount_rideranks
// wired 02/04/2012
// check if player has enough ride for mount in convo

#include "std_inc_mounts"

int StartingConditional(int nMountType)
{

    object oPC = GetPCSpeaker();
	int nRideRanks = GetSkillRank(SKILL_RIDE,oPC);
	
	if (nRideRanks >=  GetRequiredRanks(nMountType))
	{
		return TRUE;
	}
	
	return FALSE;
}