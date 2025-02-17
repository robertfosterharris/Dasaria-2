#include "dasolm_inc"

void main()
{
	object oPC = GetEnteringObject();
	
	if (!GetIsPC(oPC) || !GetIsObjectValid(oPC)) return;
	
	DasOL_setRepsOnEnter(oPC,FALSE);
}