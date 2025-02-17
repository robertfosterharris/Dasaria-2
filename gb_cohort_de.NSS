//
//	ON DEATH: COHORT
//
//	ROBERT HARRIS	04/30/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"

void main()
{
	object oCreature;
	object oPC;
	
	oCreature = OBJECT_SELF;
	oPC = GetLocalObject(oCreature, "oPC");
	
	SetLocalString(oCreature, "sLastStatus", COHORT_STATUS_DEAD);
	SaveCohort(oCreature, COHORT_STATUS_DEAD);
}