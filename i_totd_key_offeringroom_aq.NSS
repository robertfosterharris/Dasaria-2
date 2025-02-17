//	ON ACQUIRE - ADVANCE JOURNAL IF ON GOOD ROUTE
//
//	07/21/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

void main()
{
    object oPC;

	oPC = GetModuleItemAcquiredBy();
	if (GetJournalEntry("totd_missing_daughter", oPC) == 100)
	{
		AddJournalQuestEntry("totd_missing_daughter", 110, oPC, TRUE, FALSE);
	}
}