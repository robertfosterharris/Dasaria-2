//	CHECKS IF PC SPEAKER IS IN FACTION
//
//	12/05/2008	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_faction"

int StartingConditional(string sFaction)
{
    object oPC;
	
	oPC = GetPCSpeaker();
	return GetIsInFaction(oPC, sFaction);
}