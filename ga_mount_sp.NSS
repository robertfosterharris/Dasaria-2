// ga_mount_spawn
// wired 02/04/2012
// spawn mount into module if not already here

#include "std_inc_mounts"

void main()
{
    object oPC = GetPCSpeaker();	
	SpawnMountIfNeeded(oPC);
}