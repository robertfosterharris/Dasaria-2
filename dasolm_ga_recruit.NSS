// dasolm_ga_recruit
//
// return warparty to map last exited location


#include "dasolm_inc"

void main(int nSoldiers)
{
	object oPC = GetPCSpeaker();
	
	DasOL_DoRecruit(oPC,nSoldiers);
}