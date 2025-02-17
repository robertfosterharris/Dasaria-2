//das_ol_enc_oce

#include "dasolm_inc"

void main()
{
	object oPC = GetFirstEnteringPC();
	
	if (!GetIsPC(oPC) || GetIsDM(oPC)) return;

	if (DasOL_CheckPartyLeader(oPC) )
	{
		DasOL_Enc_AreaOCE(OBJECT_SELF,oPC);
	}
}