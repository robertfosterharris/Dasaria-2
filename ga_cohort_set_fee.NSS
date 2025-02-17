//	GLOBAL ACTION - SETS THE PLAYERS COHORT RECRUITMENT FEE
//
//	THE RECRUITMENT FEE EQUALS THE COHORTS LEVEL * 100
//
//	ROBERT HARRIS	05/01/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"

void main()
{
	int nCohortFee;
	object oPC;
	
	
	oPC = GetPCSpeaker();
	
	nCohortFee = GetStartingLevel(oPC) * 100;
	SetLocalInt(oPC, "nCohortFee", nCohortFee);
	SetCustomToken(3000, IntToString(nCohortFee));
}