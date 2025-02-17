#include "dasolm_inc"

int StartingConditional()
{
	object oPC = GetPCSpeaker();
	return (DasOL_CheckPartyGathered(oPC));
}