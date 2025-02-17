//ka_worldmap_evade
//Stuns the target for a variable number of seconds on the World Map
#include "ginc_overland_ai"

void main()
{
	object oPC = GetPCSpeaker();
	object oEncounter = OBJECT_SELF;
	
	float fPartyCR = GetChallengeRating(oPC);
	float fEncounterCR = GetChallengeRating(oEncounter);
	int nLevelDifference = FloatToInt(fPartyCR - fEncounterCR);
	if(nLevelDifference > 4)
		nLevelDifference = 4;
	
	int nRand = Random(4) + 2;
	
	if(nLevelDifference >= 0)
		nRand += nLevelDifference;
	
	else
		nRand = 2;
	
	float fDuration = IntToFloat(nRand);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), OBJECT_SELF, fDuration);
	SetLocalInt(OBJECT_SELF, "00_bEvaded", TRUE);
}