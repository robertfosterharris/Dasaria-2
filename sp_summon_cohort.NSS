//	LEADERSHIP FEAT - SUMMON COHORT
//
//	ROBERT HARRIS	11/08/2013	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"

void main()
{
	int bFound;
	int nNth;
	object oPC;
	object oCreature;
	string sID;
//
//	LOOK FOR AN EXISTING COHORT
//
	oPC = OBJECT_SELF;
	bFound = FALSE;
	nNth = 1;
	
	oCreature = GetHenchman(oPC, nNth);
	while (GetIsObjectValid(oCreature) && !bFound)
	{
		if (GetLocalString(oCreature, "cohort_id") != "")
		{
			bFound = 1;
		}
		else
		{
			nNth++;
			oCreature = GetHenchman(oPC, nNth);
		}
	}
	
//
//	A COHORT HAS BEEN FOUND.  INITIATE CONVERSATION.
//
	if (bFound)
	{
		DelayCommand(6.0, AssignCommand(oCreature, ActionStartConversation(oPC)));
	}
	
//
//	A COHORT HAS NOT BEEN FOUND.  SEARCH THE DATABASE.
//
	else
	{
		SQLExecDirect("SELECT cohort_id FROM cohort WHERE leader_id = " + getPCid(oPC) + " AND cohort_status = " + COHORT_STATUS_ALIVE);
		if (SQLFetch() == SQL_SUCCESS)
		{
			sID = SQLGetData(1);
			SQLSCORCOExec("SELECT cohort_object FROM cohort WHERE cohort_id = " + sID);
			oCreature = SQLRetrieveObject(GetLocation(GetWaypointByTag("wp_cohort_spawn")));
			
			ChangeToStandardFaction(oCreature, STANDARD_FACTION_DEFENDER);

			SetLocalObject(oCreature, "oPC", oPC);
			SetLocalString(oCreature, "cohort_id", sID);
			SetCreatureScriptsToSet(oCreature, SCRIPTSET_NOAI);

			SendMessageToPC(oPC, "Summoning your cohort...");

			DelayCommand(6.0, SummonCohort(oCreature));
		}
//
//	NO COHORT IN DATABASE
//
		else
		{
			SendMessageToPC(oPC, "Cohorts must be recruited before they are summoned.  Seek out a recruiter.");
		}
	}
}