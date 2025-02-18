void main()
{
	object oPC = GetLastKiller();
	int nEntry = GetJournalEntry("talontmb_lich",oPC);

	if ( (nEntry == 2))
	{			
		AddJournalQuestEntry("talontmb_lich",3,oPC,TRUE);
	}
}