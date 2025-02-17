// gc_metafaction
// wired 08/03/2010
//
#include "ginc_renown"

int StartingConditional(int nMetaFaction)
{
	object oPC = GetPCSpeaker();
	if ( getMetaFaction(oPC) == nMetaFaction)
	{
		return TRUE;
	}
	return FALSE;
}