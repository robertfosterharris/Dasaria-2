//::///////////////////////////////////////////////
//:: Bigby's Forceful Hand
//:: [x0_s0_bigby2]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    dazed vs strength check (+14 on strength check); Target knocked down.
    Target dazed down for 1 round per level of caster

*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 01, 2003

//:://///////////////////////////////////////////////////////////////////////
//:: k9burn's spell fixes edition 1
//:: Modified By: Richard Pavlicek (k9burn@yahoo.com)
//:: Modified On: Jan 15, 2007
//:://///////////////////////////////////////////////////////////////////////
//:: NOTES:
//::	Redone to make an opposed strength check every round instead of once
/////////////////////////////////////////////////////////////////////////////
//:: ROBERT HARRIS		INTEGRATED CHANGES FROM V1.12
//::					VISUAL EFFECTS
//::					


#include "x0_i0_spells"
#include "x2_inc_spellhook" 
#include "x2_i0_spells"

int nSpellID = GetSpellId();
void RunBullRush( object oTarget, int nIteration, int nDuration, object oCaster );


void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
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
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)	//Duration is +100%
    {
         nDuration = nDuration * 2;
    }
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
			effect eHold = EffectVisualEffect( VFX_DUR_PARALYZED );
			//effect eDispellable = EffectMovementSpeedDecrease( 0 );
			//effect eLink = EffectLinkEffects( eHold, eDispellable );
			float fDuration = RoundsToSeconds( nDuration );
       		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHold, oTarget, fDuration);
		
			RunBullRush(oTarget, 0, nDuration, OBJECT_SELF);
        }
    }
}

// This function runs once per round for the entire duration
void RunBullRush( object oTarget, int nIteration, int nDuration, object oCaster )
{
//	object oCaster = OBJECT_SELF;
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
	if ( nIteration >= nDuration )
	{
		// Final graphic effect to show that its finished
		effect eImpact = EffectVisualEffect(VFX_HIT_SPELL_ILLUSION);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
	}
    if (GZGetDelayedSpellEffectsExpired(nSpellID,oTarget,oCaster))
    {
		return;
    }
	else
	{
		int nCasterRoll = d20(1) + 14;
		int nTargetRoll = d20(1) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetSizeModifier(oTarget);
		// * bullrush succesful, knockdown target for duration of spell
		if (nCasterRoll >= nTargetRoll)
		{
			effect eBullRush = EffectCutsceneImmobilize();
			eBullRush = ExtraordinaryEffect( eBullRush );
			//effect eKnockdown = EffectDazed();
			//effect eKnockdown2 = EffectKnockdown();
			//effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
			//Link effects
			//effect eLink = EffectLinkEffects(eBullRush, eVis);
			//eLink = EffectLinkEffects(eLink, eKnockdown2);
			//Apply the penalty
			
	        // Apply the impact effect
	        effect eImpact = EffectVisualEffect(VFX_IMP_BIGBYS_FORCEFUL_HAND);
        	ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
			
			// Only apply this effect for 1 round then check next round.
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBullRush, oTarget, RoundsToSeconds(1));
			// * Bull Rush succesful
			//FloatingTextStrRefOnCreature(8966,OBJECT_SELF, FALSE);
		}
		else
		// Show a visual that the hand didn't bull rush
		{
			effect eImpact = EffectVisualEffect(VFX_HIT_SPELL_ILLUSION);
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
			//FloatingTextStrRefOnCreature(8967,OBJECT_SELF, FALSE);
		}

		// run the next round		
		DelayCommand( RoundsToSeconds(1), RunBullRush( oTarget, nIteration+1, nDuration, oCaster ));
	}
}