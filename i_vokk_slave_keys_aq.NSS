//	ON ACQUIRE - ADVANCE JOURNAL WHEN SLAVE KEYS ARE ACQUIRED
//
//	08/07/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

void main()
{
	int nJournalEntry;
    object oPC;

	oPC = GetModuleItemAcquiredBy();
	nJournalEntry = GetJournalEntry("vokk_free_slaves", oPC);
	if (nJournalEntry > 0 && nJournalEntry < 20)
	{
		AddJournalQuestEntry("vokk_free_slaves", 20, oPC, TRUE, FALSE);
	}
}