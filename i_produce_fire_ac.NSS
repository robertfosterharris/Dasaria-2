// i_produce_fire_ac
// 1 point fire damage for 60secs

#include "x2_inc_itemprop"

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

	itemproperty iFire = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_2);
	IPSafeAddItemProperty(oTarget, iFire, 60.0);
}