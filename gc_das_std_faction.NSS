// gc_das_std_faction
// wired 09/14/09
// check reputation of a pc against the standard das npc factions
// fall back on nwn2 faction reputation if that's not set
// this is really for checking pc speaker against cear_guards 
// but made it extensible anyway
// uses standard compare ints, takes >,>,=,! or an int

#include "std_faction_i0"
#include "ginc_var_ops"
#include "ginc_param_const"

int StartingConditional(string sTest, string sFaction, string sTarget)
{
	object oTarget = GetTarget(sTarget, TARGET_PC);
	int nRep = std_reputation_get(oTarget, sFaction);
	
	// if the rep isn't set
	if (nRep == -1) 
	{
		nRep = GetReputation(GetObjectByTag("d2_faction_"+sFaction), oTarget);
	}
	
	if ( CompareInts(nRep, sTest) == TRUE) 
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}