// dasolm_ga_fixpartyreps
//
// adjust all reps when we leave the battlefields
// party-wide, assumes same node as aligned party jump!!!


#include "dasolm_inc"

void main()
{
	object oPC = GetPCSpeaker();
	
	object oMem = GetFirstFactionMember(oPC);
	while (GetIsObjectValid(oMem))
	{
		DasOL_fixReps(oMem);
		oMem = GetNextFactionMember(oPC);
	}
}