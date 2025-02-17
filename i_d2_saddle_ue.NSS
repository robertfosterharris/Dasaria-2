// i_d2_saddle_ue
//
// simple test harness for rideable mounts using equipped item
//
#include "std_inc_mounts"

void main()
{
	object oPC = GetPCItemLastUnequippedBy();
	object oSaddle = GetPCItemLastUnequipped();
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Saddle OnUnEquip() Running!");
	
	// on second thought, just let them unequip this way
	/*
	if (GetLocalInt(oSaddle,"nUnequippedByScript") != 1)
	{
		SetLocalInt(oPC,"nForceRequip",TRUE);
		AssignCommand(oPC,ActionEquipItem(oSaddle,INVENTORY_SLOT_CLOAK));
		SendMessageToPC(oPC,"Cannot unequip saddle from inventory screen.  To dismount, instead right click on controlled character and select 'Dismount' from the menu");
		return;
	}
	*/
	
	//AssignCommand(oPC,ClearAllActions());  
	ActionDismount(oPC,oSaddle);
}