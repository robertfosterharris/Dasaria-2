/*
Type of Feat: Heritage.
Prerequisite: Baraanman Heritage. Character Level 9.
Range: Personal
Area of Effect / Target: Colossal
Duration: 6 seconds / Character Level
Save: Will Negates
Spell Resistance: Yes

Specifics: The language of the Baaranmen is said to be close to that true language spoken by the gods themselves, as such it has a power beyond that of most mortal languages.
This feat grants the ability to cast <i>War Cry</i> once per day per Baraanman heritage feats possessed (caster level equal to character level).
You let out a powerful shout that grants the Baraanman a +2 bonus to attack and damage. All enemies within the area of effect are stricken with fear.

DC: 14 + the number of Baraanman heritage feats possessed

Use: Selected.

Based on NW_S0_WarCry
*/

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ginc_custom_races"

void main()
{
	object oPC = OBJECT_SELF;
	int iFeatUsed = GetSpellFeatId();
	int iSpellID = GetSpellId();
   //Declare major variables
    object oTarget;
    int nLevel = GetTotalLevels(oPC, FALSE); //False = negative levels reduce your effectiveness
	int iDC = 14 + iCountHertitageFeats(oPC);
    effect eAttack = EffectAttackIncrease(2);
    effect eDamage = EffectDamageIncrease(2, DAMAGE_TYPE_SLASHING);
    effect eFear = EffectFrightened();
    //effect eVis = EffectVisualEffect(VFX_HIT_SPELL_SONIC);
    effect eLOS = EffectVisualEffect(VFX_HIT_AOE_SONIC);
	effect eBuf = EffectVisualEffect ( VFX_DUR_SPELL_WAR_CRY );
	effect eVisFear = EffectVisualEffect (VFX_DUR_SPELL_CAUSE_FEAR);
    effect eLink = EffectLinkEffects(eAttack, eDamage);

	if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	eLink = EffectLinkEffects(eLink, eBuf);
	eLink = SetEffectSpellId(eLink, SPELL_WAR_CRY);
	
	eFear = EffectLinkEffects (eFear, eVisFear);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLOS, oPC);
    //Determine enemies in the radius around the bard
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC) && oTarget != oPC)
        {
           SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_WAR_CRY));
           //Make SR and Will saves
           if(!MyResistSpell(oPC, oTarget)  && !MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_FEAR))
            {
                DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oTarget, RoundsToSeconds(4)));
				//DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));VFX we don't need
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
    }
    //Apply bonus and VFX effects to bard.
    RemoveSpellEffects(GetSpellId(),oPC,oPC);
    RemoveSpellEffects(SPELL_WAR_CRY,oPC,oPC);	
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF); //PMils OEI 07.08.06- NWN1 stuff, in NWN2 we're trying to not use the hit fx for buffs
	DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(nLevel)));
    SignalEvent(oPC, EventSpellCastAt(oPC, SPELL_WAR_CRY, FALSE));

}