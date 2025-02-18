#include "x2_inc_itemprop"

void AddFlamingEffectToWeapon(object oTarget, float fDuration, int nCasterLevel)
{
	// wired 12/20/07 no clue what this was but there is no IP_CONST_ONHIT_CAST_* = 141
	//itemproperty ipOnHitCastSpell = ItemPropertyOnHitCastSpell( 141, nCasterLevel );
	itemproperty ipVis = ItemPropertyVisualEffect( ITEM_VISUAL_FIRE );
	itemproperty ipFlame = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d8);
	
	//IPSafeAddItemProperty(oTarget, ipOnHitCastSpell, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
	IPSafeAddItemProperty(oTarget, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    IPSafeAddItemProperty(oTarget, ipVis, fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
}

void main()
{
	effect eDur;
	object oWeapon;
	object oPC;
	
	oPC = GetPCSpeaker();
	eDur = EffectVisualEffect( VFX_DUR_SPELL_FLAME_WEAPON );
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oPC, 300.0);
		 
	oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (IPGetIsMeleeWeapon(oWeapon)) AddFlamingEffectToWeapon(oWeapon, 300.0, 2);

	oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if (IPGetIsMeleeWeapon(oWeapon)) AddFlamingEffectToWeapon(oWeapon, 300.0, 2);
}