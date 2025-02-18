//	INCLUDE FILE -	SPAWN SARANDII AFTER THE FIGHT WITH RAVAEL AND COMPANY IS COMPLETE
//
//	07/22/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

void finishFight(object oArea)
{
	int nEntry;
	object oEncounter;
	object oPC;
	
	if (GetLocalInt(oArea, "totd_party_dead") && GetLocalInt(oArea, "totd_paladin_dead"))
	{
		oEncounter = GetObjectByTag("totd_spawn_priestess");
		oPC = GetLocalObject(oArea, "totd_PC");
	
		nEntry = GetJournalEntry("totd_missing_daughter", oPC);
		if (nEntry == 310) AddJournalQuestEntry("totd_missing_daughter", 320, oPC);
	
		SetEncounterActive(TRUE, oEncounter);
		TriggerEncounter(oEncounter, oPC, ENCOUNTER_CALC_FROM_FACTION, -1.0);

		DeleteLocalObject(oArea, "totd_PC");
		DeleteLocalInt(oArea, "totd_party_dead");
		DeleteLocalInt(oArea, "totd_paladin_dead");
	}		
}