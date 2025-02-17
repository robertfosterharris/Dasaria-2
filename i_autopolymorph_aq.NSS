// i_autopolymorph_aq
// DM Asylum 18 February 2010

#include "ginc_item_script"

void main()
{
    object oPC      = GetModuleItemAcquiredBy();
    object oItem    = GetModuleItemAcquired();
	int nPoly		= StringToInt(GetName(oItem));
	
	// 	Don't run this script unless it's aqcuired by a player or NPC	
	if (GetIsDM(oPC)) return;
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectPolymorph(nPoly,TRUE)),oPC);
}