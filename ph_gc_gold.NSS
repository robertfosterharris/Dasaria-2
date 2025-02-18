// ph_gc_gold
//

#include "ginc_playerhousing"

int StartingConditional(int nClass)
{
	object oPC = GetPCSpeaker();
	return CheckGold(oPC, nClass);
}