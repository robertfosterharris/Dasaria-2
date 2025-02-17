// gc_weaponinhand
// wired 09/18/08
#include "x2_inc_itemprop"
int StartingConditional()
{
	object oWeapon;
	object oPC;
	
	oPC = GetPCSpeaker();		 
	oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (IPGetIsMeleeWeapon(oWeapon) ||
		IPGetIsRangedWeapon(oWeapon) )
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}