// golino_enc_enter
// wired 08/22/2009 enable quest encounter
void main()
{
	object oPC = GetEnteringObject();
	string sETag = GetLocalString(OBJECT_SELF,"sETag");
	object oEncounter = GetNearestObjectByTag(sETag);
	if 
	 (GetJournalEntry("akmill_writhehearts",oPC) == 5) 
			
	{
		SetEncounterActive(TRUE,oEncounter);
		TriggerEncounter(GetNearestObjectByTag("korgov_golino"),oPC,0,-1.0);
		
		
	}
}