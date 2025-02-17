#include "x2_inc_itemprop"

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

	itemproperty iFrost = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGEBONUS_2);
	IPSafeAddItemProperty(oTarget, iFrost, 60.0);
}