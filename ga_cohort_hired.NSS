//	GLOBAL ACTION - PERMANENTLY REMOVES THE COHORT FROM THE PLAYERS EMPLOYMENT
//
//	ROBERT HARRIS	04/30/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"

void main()
{
	object oPC;
	object oCreature;

	oPC = GetPCSpeaker();
	
	oCreature = CreateCohort(oPC, GetLocalString(oPC, "sMetaClass"));
	
	if (GetIsObjectValid(oCreature))
	{
		DelayCommand(6.0,	InitializeCohort(oCreature));
		DelayCommand(7.0,	SaveCohort(oCreature));
		DelayCommand(8.0,	DestroyCohort(oCreature));
	}
	else
	{
		SendMessageToPC(oPC, "ERROR: FAILED TO INITIALIZE COHORT.");
	}
}