/*
Word of Unveiling
Type of Feat: Heritage.
Prerequisite: Baraanman Heritage.  Character Level 3.
Range: Personal
Area of Effect / Target: Colossal
Duration: Instant

Specifics: The language of the Baaranmen is said to be close to that true language spoken by the gods themselves, as such it has a poor beyond that of most mortal languages.
This feat grants the ability to purge all magical forms of invisability with in a 30 foot radius once per day per Baraanman heritage feats possessed.

Use: Selected.
*/
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

	object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject(); 
	
	int iFeatUsed = GetSpellFeatId();
	int iSpellID = GetSpellId();

    effect eLOS = EffectVisualEffect(VFX_HIT_AOE_SONIC);
	
	
	if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
    if (!GetHasSpellEffect(iSpellID, oPC)) 
	{
	
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eLOS, oPC);

				
		oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
	    while (GetIsObjectValid(oTarget))
	    {
			RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, oTarget);
			RemoveSpecificEffect(EFFECT_TYPE_GREATERINVISIBILITY, oTarget);	
			
	        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
	    }
	
	    SignalEvent(oPC, EventSpellCastAt(oPC, iSpellID, FALSE));
	
		
		

		
	}
}




