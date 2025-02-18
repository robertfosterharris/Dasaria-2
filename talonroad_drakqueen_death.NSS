void main()
{
	object oPC = GetLastKiller();
	int nEntry = GetJournalEntry("talonroad_fliers",oPC);

	if ( nEntry == 1)
	{			
		AddJournalQuestEntry("talonroad_fliers",6,oPC,TRUE);
	}
}