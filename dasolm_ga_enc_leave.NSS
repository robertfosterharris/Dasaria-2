// ga_das_ol_enc_leave
//
// return warparty to map last exited location


#include "dasolm_inc"

void main(int bVictory)
{
	object oPC = GetPCSpeaker();
	
	DasOL_Enc_Exit(oPC, bVictory);
}