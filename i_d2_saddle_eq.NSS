// i_d2_sadd1e_eq
//
// simple test harness for rideable mounts using equipped item
//
#include "std_inc_mounts"

void main()
{
	object oPC = GetPCItemLastEquippedBy();
	object oSaddle = GetPCItemLastEquipped();
	
	if (bDEBUG_mounts) SendMessageToPC(oPC,"OnEquip() Running!");

	SetLocalObject(oPC,"oSaddle",oSaddle);
	SetMountedAppearance(oPC); 
}