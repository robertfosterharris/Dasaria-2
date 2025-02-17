//  TRIGGER ON ENTER SCRIPT
//
//  DRAW TRIGGER AROUND AN ENCOUNTER TO ACTIVATE / DEACTIVATE THE ENCOUNTER
//  BASED ON THE CURRENT HOUR AND A COMMA DELIMITED LIST OF ACTIVE HOURS
//
//  TRIGGER VARIABLE
//  sHoursActive =  A COMMA DELIMITED LIST OF HOURS THE ENCOUNTERS WITHIN THE TRIGGER SHOULD BE SPAWN
//  sEncounterTag   =  OPTIONAL TAG OF THE ENCOUNTER TO ACTIVATE/DEACTIVATE (DEFAULT IS ALL ENCOUNTERS WITHIN THE TRIGGER)
//
//  ROBERT HARRIS   ROBERTHARRIS@ROBERTHARRIS.COM   04/26/2007
//
//  04/26/2007  RFH 	ADDED OPTION ENCOUNTER TAG
//	06/26/2007	RFH		CREATED SETTIMEDENCOUNTER
//	12/04/2008	RFH		EXECUTE FLEE BEHAVIOR FOR CREATURES WITHIN AN DEACTIVATED ENCOUNTER
//

void ExecuteFlee(object oEncounter);
void SetTimedEncounter(int nActive, object oEncounter);

void main()
{
	int bActiveFlag;
	object oEncounter;
	string sHour;
	string sHoursActive;
	string sEncounterTag;

	sHour = "," + IntToString(GetTimeHour()) + ",";
	sHoursActive = "," + GetLocalString(OBJECT_SELF, "sHoursActive") + ",";
	sEncounterTag = GetLocalString(OBJECT_SELF, "sEncounterTag");

	if (FindSubString(sHoursActive, sHour) == -1)
	{
		bActiveFlag = FALSE;
	}
	else
	{
		bActiveFlag = TRUE;
	}

	oEncounter = GetNearestObjectByTag(sEncounterTag);
	if (GetIsObjectValid(oEncounter))
	{
		SetTimedEncounter(bActiveFlag, oEncounter);
	}
	else
	{
		oEncounter = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_ENCOUNTER);
		while(GetIsObjectValid(oEncounter))
		{
			SetTimedEncounter(bActiveFlag, oEncounter);
			oEncounter = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_ENCOUNTER);
		}
	}
}
//	
//	SETS ENCOUNTER STATUS ON FIRST TRIGGER
//	THEN AGAIN ON EVERY STATUS CHANGE
//
void SetTimedEncounter (int bActiveFlag, object oEncounter)
{
	if (!GetLocalInt(oEncounter, "nInitialized"))
	{
		SetEncounterActive(bActiveFlag, oEncounter);
		SetLocalInt(oEncounter, "nLastState", bActiveFlag);
		SetLocalInt(oEncounter, "nInitialized", TRUE);
	}
	if (GetLocalInt(oEncounter, "nLastState") != bActiveFlag)
	{
		if (bActiveFlag == FALSE) ExecuteFlee(oEncounter);
		SetEncounterActive(bActiveFlag, oEncounter);			
		SetLocalInt(oEncounter, "nLastState", bActiveFlag);
	}
}
//
//	EXECUTE FLEE BEHAVIOR FOR CREATURES WITHIN AN DEACTIVATED ENCOUNTER
//
void ExecuteFlee(object oEncounter)
{
	object oNPC;
	
	oNPC = GetFirstInPersistentObject(oEncounter, OBJECT_TYPE_CREATURE);
	while(GetIsObjectValid(oNPC))
	{
		if (GetIsEncounterCreature(oNPC))
		{
			ExecuteScript("gtr_timed_encounter_flee", oNPC);
		}
		oNPC = GetNextInPersistentObject(oEncounter, OBJECT_TYPE_CREATURE);
	}
}