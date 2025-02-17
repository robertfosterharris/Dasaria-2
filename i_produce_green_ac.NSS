// i_produce_green_ac
// 1 point acid damage for 60secs

#include "x2_inc_itemprop"

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

	itemproperty iAcid = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID, IP_CONST_DAMAGEBONUS_2);
	IPSafeAddItemProperty(oTarget, iAcid, 60.0);
}