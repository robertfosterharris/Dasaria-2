//std_trg_blindness_enter


#include "X0_I0_SPELLS" 

void main()
{
	object oPC = GetEnteringObject();
		if (!GetIsPC(oPC)) return;
		
    effect eBlind =  EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_BLIND_DEAF);
	effect eLink = EffectLinkEffects(eBlind, eVis);
	int nDC = GetLocalInt(OBJECT_SELF,"nDC");
	
	if (nDC == 0) nDC = 20;
	
	// Make Fortitude save to negate
    if (!/*Fort Save*/ MySavingThrow(SAVING_THROW_FORT, oPC, nDC))
    {
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SetEffectSpellId(SupernaturalEffect(eLink),-4444), oPC);
	}	
}