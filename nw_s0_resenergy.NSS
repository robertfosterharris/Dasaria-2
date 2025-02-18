//::///////////////////////////////////////////////
//:: Resist Energy
//:: NW_S0_ResEnergy
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Offers 20 points of elemental resistance.  If 30
    points of a single elemental type is done to the
    protected creature the spell fades
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////

// (Updated JLR - OEI 07/05/05 NWN2 3.5)

//:://///////////////////////////////////////////////////////////////////////
//:: k9burn's spell fixes edition 1
//:: Modified By: Richard Pavlicek (k9burn@yahoo.com)
//:: Modified On: Jan 15, 2007
//:://///////////////////////////////////////////////////////////////////////
//:: NOTES:
//::	Changed duration to 24 hours (to be like Endure Elements 
//::	and Protection from Elements)
/////////////////////////////////////////////////////////////////////////////


#include "nw_i0_spells"

#include "x2_inc_spellhook" 

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
	//k9burn - change duration to 24 hours like all other energy resist spells
	float fDuration = HoursToSeconds(24); //GetCasterLevel(OBJECT_SELF);
    int nAmount = 30;
    int nResistance = 20;
    int nMetaMagic = GetMetaMagicFeat();
    effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD, nResistance, nAmount);
    effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE, nResistance, nAmount);
    effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID, nResistance, nAmount);
    effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC, nResistance, nAmount);
    effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, nResistance, nAmount);
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_RESIST_ENERGY );
    //effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    //effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESIST_ENERGY, FALSE));	// JLR - OEI 07/11/05 -- Name Changed

    //Link Effects
    effect eLink = EffectLinkEffects(eCold, eFire);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eSonic);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eDur);
    //eLink = EffectLinkEffects(eLink, eDur2);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}