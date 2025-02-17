// ga_mount_creatures
//
// simple  mount script from a convo
//

#include "std_inc_mounts"
void main()
{
	object oPC = GetPCSpeaker();
	object oMount = OBJECT_SELF;
	int nMountType = GetLocalInt(oMount,"nMountType");
	
	if (nMountType == 0) nMountType = 1;
	
	AssignCommand(oPC,ActionMount(oMount,nMountType));
}