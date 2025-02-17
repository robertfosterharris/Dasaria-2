//  TRIGGER ON ENTER SCRIPT - REPLACES GTR_TIMED_ENCOUNTER_EN
//
//	TRIGGERS AN ENCOUNTER BASED ON THE CURRENT HOUR AND A COMMA DELIMITED LIST OF ACTIVE HOURS
//
//  TRIGGER VARIABLE
//  sHoursActive	A COMMA DELIMITED LIST OF HOURS DURING WHICH THE ENCOUNTER IS ACTIVE
//  sEncounterTag   TAG OF THE ENCOUNTER TO ACTIVATE (THE ACTUAL ENCOUNTER TRIGGER SHOULD BE OUTSIDE THE WALKMESH)
//	sDelay			THE NUMBER OF SECONDS BETWEEN RESPAWNS
//	sCreatureList	COMMA DELIMITED LIST OF CREATURES TO DESPAWN WHEN ENCOUNTER IS NOT ACTIVE
//					ACTIVATES THE CREATURES "FLEE" BEHAVIOR IF SET OR DESTROYS CREATURE
//
//  ROBERT HARRIS   ROBERTHARRIS@ROBERTHARRIS.COM   01/02/2011
//

#include "std_i0_time"
#include "x0_i0_stringlib"

int GetIsCorrectHour();
int GetIsPastDelay();
void DespawnCreatures();

void main()
{
	object oEncounter;
	object oPC;
	string sHour;
	string sHoursActive;
	string sEncounterTag;
	
	oPC = GetEnteringObject();
	if (GetIsPC(oPC))
	{
		if (GetIsCorrectHour())
		{
			if (GetIsPastDelay())
			{
				oEncounter = GetObjectByTag(GetLocalString(OBJECT_SELF, "sEncounterTag"));
				if (GetIsObjectValid(oEncounter))
				{
					//SendMessageToPC(oPC, "Triggering " + GetLocalString(OBJECT_SELF, "sEncounterTag"));
					SetEncounterActive(TRUE, oEncounter);
					TriggerEncounter(oEncounter, oPC, ENCOUNTER_CALC_FROM_FACTION, -1.0);
					time_stamp_seconds_set(OBJECT_SELF, "nLastActivated");
					SetLocalInt(OBJECT_SELF, "nSpawnCount", GetLocalInt(OBJECT_SELF, "nSpawnCount") + 1);
				}
			}
		}
		else
		{
			DespawnCreatures();
		}
	}
}

int GetIsPastDelay()
{
	int bCorrectDelay;
	
	//SendMessageToPC(GetEnteringObject(), "Seconds Elapsed = " + IntToString(time_stamp_seconds_elapsed(OBJECT_SELF, "nLastActivated")));

	if (time_stamp_seconds_elapsed(OBJECT_SELF, "nLastActivated") >= GetLocalInt(OBJECT_SELF, "nDelay") || GetLocalInt(OBJECT_SELF, "nSpawnCount") == 0)
	{
		bCorrectDelay = TRUE;
	}
	else
	{
		bCorrectDelay = FALSE;
	}

	return bCorrectDelay;
}

int GetIsCorrectHour()
{
	int bCorrectHour;
	string sHour;
	string sHoursActive;
	
	//SendMessageToPC(GetEnteringObject(), "Current Hour = " + IntToString(GetTimeHour()));

	sHour = "," + IntToString(GetTimeHour()) + ",";
	sHoursActive = "," + GetLocalString(OBJECT_SELF, "sHoursActive") + ",";

	if (FindSubString(sHoursActive, sHour) == -1)
	{
		bCorrectHour = FALSE;
	}
	else
	{
		bCorrectHour = TRUE;
	}
	
	return bCorrectHour;
}

void DespawnCreatures()
{
	int nNth;
	int nIndex;
	object oCreature;
	object oArea;
	string sCreature;
	string sCreatureList;	
	
	nNth = 0;
	oArea = GetArea(OBJECT_SELF);
	sCreatureList = GetLocalString(OBJECT_SELF, "sCreatureList");
	sCreature = GetTokenByPosition(sCreatureList, ",", nNth);
	
	while (sCreature != "")
	{
		nIndex = 0;
		oCreature = GetObjectByTag(sCreature, nIndex);
		while (GetIsObjectValid(oCreature))
		{
			if (oArea == GetArea(oCreature))
			{
				ExecuteScript("gtr_timed_encounter_flee", oCreature);
				//SendMessageToPC(GetFirstPC(), "Despawning = " + sCreature);
			}
			nIndex++;
			oCreature = GetObjectByTag(sCreature, nIndex);
		}

		nNth++;
		sCreature = GetTokenByPosition(sCreatureList, ",", nNth);
	}
}