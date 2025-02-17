// Placeable OnUsed Template	
/*
	Required: Static=FALSE, Usable=TRUE, CurrentHP>0, attach script to the OnUsed event
	Suggested: Plot=TRUE, DefaultActionPreference="Use"
*/
//

#include "ginc_debug"

void main()
{
	object oUser = GetLastUsedBy();
	effect eEffect = EffectAttackDecrease(2);
	effect eEffect2 = EffectBlindness();
	
	
	effect eVis = EffectVisualEffect(VFX_IMP_POISON_L);
    // Apply the visual effect to the target
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
    // Apply the effect to the object   
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oUser, 300.0f);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect2, oUser, 60.0f);
	FloatingTextStringOnCreature("You breath a noxious cloud of used kitty litter.",oUser);
}