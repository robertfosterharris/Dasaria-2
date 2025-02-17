#include "dasolm_inc"

int StartingConditional(int nCheck)
{
	object oPC = GetPCSpeaker();
	return DasOL_CheckPartyLeader(oPC);
}