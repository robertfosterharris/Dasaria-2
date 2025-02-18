// This is a copy of nx1_s1_protaura - Protective Aura.
// allows this effect to be applied via a history feat.
//
// The protective aura which surrounds angels (solars, planetars, etc.)
//
// JSH-OEI 6/6/07
// Original Script By: Preston Watamaniuk

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    object oTarget = GetSpellTargetObject(); 
    effect eAOE;
	if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
    if (!GetHasSpellEffect(1806, OBJECT_SELF)) // 201 = Protective Aura
	{
	
		eAOE = SetEffectSpellId(eAOE, 1806);
		eAOE = EffectAreaOfEffect(AOE_MOB_PROTECTION);
		eAOE = ExtraordinaryEffect(eAOE);		
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 1806, FALSE));
    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget);
	}
}