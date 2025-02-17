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
	effect eEffect = EffectAttackIncrease(2);
	
	effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    // Apply the visual effect to the target
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
    // Apply the effect to the object   
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oUser, 90.0f);
	FloatingTextStringOnCreature("Tharon's blessings upon you",oUser);
}