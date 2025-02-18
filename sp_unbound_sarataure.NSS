/*
sp_unbound_saraTaure

Always on  effect that nerfs good Dark Evils

*/

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ginc_custom_races"

void main()
{
	object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject(); 
	
	int iFeatUsed = GetSpellFeatId();
	int iSpellID = GetSpellId();
	int iAlignWith = GetAlignmentGoodEvil(oPC);
    int iLevel = GetTotalLevels(oPC, TRUE);
	int iCounter;
	effect eSpellEffectDecreaseInt;
	effect eSpellEffectDecreaseCha;	
	effect eSpellEffectDecreaseMagicResist;
	
	effect eLink;
	
	if(iAlignWith == ALIGNMENT_EVIL)	
	{
		FeatRemove(oPC, FEAT_HIST_UNBOUND_TO_SARATAURE);
	
	}
	else
	{
	    if (!GetHasSpellEffect(iSpellID, OBJECT_SELF)) 
		{
			eSpellEffectDecreaseInt = EffectAbilityDecrease( ABILITY_INTELLIGENCE , 2);
			eSpellEffectDecreaseCha = EffectAbilityDecrease( ABILITY_CHARISMA , 2);	
			eSpellEffectDecreaseMagicResist = EffectSpellResistanceDecrease( 11+ iLevel);
		
			eLink = SetEffectSpellId(eLink, iSpellID);
			eLink = ExtraordinaryEffect(eLink);
			eLink = EffectLinkEffects(eLink,eSpellEffectDecreaseInt);
			eLink = EffectLinkEffects(eLink,eSpellEffectDecreaseCha);
			eLink = EffectLinkEffects(eLink,eSpellEffectDecreaseMagicResist);
			 
			SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, iSpellID, FALSE));
	    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
			
			
			
			for(iCounter =1; iCounter <= 3; iCounter++)
			{
				DecrementRemainingFeatUses(oPC, FEAT_DROW_DARKNESS);
				DecrementRemainingFeatUses(oPC, FEAT_RACIAL_LIGHT);
				DecrementRemainingFeatUses(oPC, FEAT_RACIAL_SEE_INVIS);						
			}

			
		}
	}
}


