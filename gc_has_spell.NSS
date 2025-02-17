// wired 2008/01/16
// gc_has_spell
// int SPellID from nwscript.nss SPELL_*
// string sCreatureTag, default is $PC_SPEAKER
#include "ginc_param_const"

int StartingConditional(int nSpellID, string sCreatureTag)
{
    object oCreature = GetTarget(sCreatureTag, TARGET_PC);
	if (GetHasSpell(nSpellID, oCreature) > 0)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}