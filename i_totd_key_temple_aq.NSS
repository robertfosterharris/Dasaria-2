//	ON ACQUIRE - ADVANCE JOURNAL ON TO GOOD ROUTE
//
//	07/21/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

void main()
{
	int nJournalEntry;
    object oPC;

	oPC = GetModuleItemAcquiredBy();
	nJournalEntry = GetJournalEntry("totd_missing_daughter", oPC);
	if (nJournalEntry > 0 && nJournalEntry < 100)
	{
		AddJournalQuestEntry("totd_missing_daughter", 100, oPC, TRUE, FALSE);
	}
}