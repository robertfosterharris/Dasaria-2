// This is essentially a copy of nw_s0_lore

/*
Ancient Wisdom

Type of Feat: Heritage
Prerequisite: Baraanman Heritage.
Range: Personal
Area of Effect / Target: Caster
Duration: 60 seconds / Character Level
Save: Harmless
Spell Resistance: No

Specifics: Your people are ancient and have delved in to mysteries that the younger races of men have not yet even begun to ponder. 
This feat grants the ability to cast <i>Legend Lore</i> as per the spell three times per day (caster level equal to character level).

Your Ancient Wisdom grants you a +10 bonus to Lore checks, +1 per 2 character level.

Use: Selected

Does not stack with Legend Lore

*/

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

	object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();    		
	int iSpellID;
    int nDuration = 1;
    int nLevel = GetTotalLevels(oPC, FALSE);
    int nBonus = 10 + (nLevel / 2);
		
    effect eLore = EffectSkillIncrease(SKILL_LORE, nBonus);
    //effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_LEGEND_LORE );
    effect eLink = EffectLinkEffects(eLore, eDur);	
	
	if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
    if (!GetHasSpellEffect(iSpellID, oPC) || !GetHasSpellEffect(SPELL_IDENTIFY, oPC) || !GetHasSpellEffect(SPELL_LEGEND_LORE, oPC))
	{
		SignalEvent(oTarget, EventSpellCastAt(oPC, iSpellID, FALSE));
        //Apply linked and VFX effects
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, TurnsToSeconds(nLevel));
		
	}
}	




