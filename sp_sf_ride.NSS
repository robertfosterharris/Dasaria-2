// sp_sf_ride
// wired 2012/07/14
// skill focus ride

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

	effect eIncrease;
	
    if (!GetHasSpellEffect(1809, OBJECT_SELF))
	{	
		eIncrease = SetEffectSpellId(eIncrease, 1809);
		eIncrease = EffectSkillIncrease(28,3);
		eIncrease = ExtraordinaryEffect(eIncrease);		
		SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 1809, FALSE));
    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eIncrease, OBJECT_SELF);
	}
}