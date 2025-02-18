/*
Ancient Insight

Type of Feat: Race.
Prerequisite: Baraanman.
Specifics:  Although they appear as other men the Baraanmen are an ancient race and know secrets that the younger races of men have yet to fathom. This feat grants a permanent +3 bonus to the Lore skill.
Use: Automatic.

Note this should be in addition to skill focus lore!!
*/

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"


void main()
{
	object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject(); 
	
	int iFeatUsed = GetSpellFeatId();
	int iSpellID = GetSpellId();

    effect eSpellEffect;

    if (!GetHasSpellEffect(iSpellID, OBJECT_SELF)) 
	{
		eSpellEffect = SetEffectSpellId(eSpellEffect, iSpellID);
		eSpellEffect = EffectSkillIncrease(SKILL_LORE,3);
		eSpellEffect = ExtraordinaryEffect(eSpellEffect);		
		SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, iSpellID, FALSE));
    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpellEffect, OBJECT_SELF);
	}
}