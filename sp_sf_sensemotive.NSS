// sp_sf_sensemotive
// rw 20120802
// skill focus sense motive

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ginc_custom_skills"

void main()
{
	object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject(); 
	
	int iFeatUsed = GetSpellFeatId();
	int iSpellID = GetSpellId();


    effect eSpellEffect;

    if (!GetHasSpellEffect(iSpellID, OBJECT_SELF)) 
	{

		eSpellEffect = EffectSkillIncrease(SKILL_SENSE_MOTIVE,3);
			eSpellEffect = SetEffectSpellId(eSpellEffect, iSpellID);	
		
		eSpellEffect = ExtraordinaryEffect(eSpellEffect);		
		SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, iSpellID, FALSE));
    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpellEffect, OBJECT_SELF);
	}

}
