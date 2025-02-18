// mount_stable_oce

#include "std_inc_mounts"

void main()
{
	//coming from sOCEHook, so being executed by oPC
	object oPC = OBJECT_SELF;
	SpawnMountIfNeeded(oPC);
	
}