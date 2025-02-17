// gui_d2_dismount
// wired 01/29/2012
#include "std_inc_mounts"

void main()
{
	object oPC = OBJECT_SELF;
	object oSaddle = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
		
	/*
	if (GetPlayerCurrentTarget(oPC) != oPC)
	{
		SendMessageToPC(oPC,"You must target yourself to dismount.");
		return;
	}
	*/
	
	if (!GetIsMounted(oPC))
	{
		SendMessageToPC(oPC,"You are not mounted.");
		return;	
	}
	
	if (GetIsObjectValid(oSaddle)) SetLocalInt(oSaddle,"nUnequippedByScript",1);
	
	SendMessageToPC(oPC,"Dismounting.");
	//AssignCommand(oPC,ClearAllActions());
	DelayCommand(1.0f,ActionUnequipItem(oSaddle));
}