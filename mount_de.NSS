// mount_de
//
// wired 02/04/2012

#include "std_inc_mounts"

void main()
{
	object oMount = OBJECT_SELF;
	object oPC = GetLocalObject(oMount,"oOwner");
	OnMountDeath(oPC);
}