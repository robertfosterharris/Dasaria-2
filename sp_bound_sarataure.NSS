/*
sp_bound_sarataure

Always on  effect that makes sure Dark elves are being evile!
*/
#include "ginc_custom_races"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
	object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject(); 
	
	int iFeatUsed = GetSpellFeatId();
	int iSpellID = GetSpellId();
	int iAlignWith = GetAlignmentGoodEvil(oPC);
	
	if(iAlignWith != ALIGNMENT_EVIL && GetHasFeat(FEAT_HIST_UNBOUND_TO_SARATAURE, oPC) == FALSE)
	{
		FeatAdd(oPC, FEAT_HIST_UNBOUND_TO_SARATAURE, FALSE, TRUE);
	}
	
}

//

