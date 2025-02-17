//dasolm_enc_exit

#include "dasolm_inc"

void main()
{
	object oPC = GetExitingObject();
	if (!GetIsPC(oPC)) return;	
		
	DasOL_Enc_AreaOnExit(oPC);
}