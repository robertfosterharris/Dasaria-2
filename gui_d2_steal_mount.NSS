//gui_d2_steal_mount

#include "std_inc_mounts"

void main()
{
	object oPC = GetControlledCharacter(OBJECT_SELF);
	object oMount = GetLocalObject(oPC,"oMountTarget");
	
	ActionStealMount(oPC,oMount);

}