//	GA_COHORT_REMOVE - REMOVES THE COHORT FROM THE PARTY AND SAVES TO THE DATABASE WITH sSTATUS
//
//	sSTATUS		1	COHORT_STATUS_ALIVE
//				2	COHORT_STATUS_DEAD
//				3	COHORT_STATUS_FIRED
//
//	ROBERT HARRIS	04/30/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"

void main(string sStatus = "1")
{
	object oCreature;
	object oPC;
	
	oCreature = OBJECT_SELF;
	oPC  = GetLocalObject(oCreature, "oPC");
	
	SaveCohort(oCreature, sStatus);

	SetCreatureScriptsToSet(oCreature, SCRIPTSET_NOAI);
	ClearAllActions(TRUE);
	
	RemoveHenchman(oPC, oCreature);

	DelayCommand(6.0, DestroyCohort(oCreature));
}