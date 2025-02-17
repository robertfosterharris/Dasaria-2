// gc_has_spelleffect
//
// wired 05/08/2009 
// int SPELL_CHARM_PERSON                      = 16;
// int SPELL_CHARM_PERSON_OR_ANIMAL            = 17;
// int SPELL_MASS_CHARM                        = 111;
//
//	defaults to checking PC_SPEAKER

#include "ginc_param_const"

int StartingConditional(int nSpellEffect, string sCreatureTag)
{
	object oTarget = GetTarget(sCreatureTag, TARGET_PC);
	
	if (GetHasSpellEffect(nSpellEffect, oTarget))
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}