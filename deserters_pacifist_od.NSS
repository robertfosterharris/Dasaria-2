//deserters_pacifist_od
//advances journal state ondeath
void main()
{
	object oPC = GetLastKiller();
	
     if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
     {
     	oPC = GetMaster(oPC);
     }
	 	
	int nEntry = GetJournalEntry("docks_deserters",oPC);
	if ( nEntry == 6 || nEntry == 7)
	{
		AddJournalQuestEntry("docks_deserters",8,oPC,TRUE);
	}
}