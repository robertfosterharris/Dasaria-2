//	ON ACQUIRE - ADVANCE JOURNAL IF ON QUEST TO RECOVER STONE TABLET
//
//	07/21/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

void main()
{
    object oPC;

	oPC = GetModuleItemAcquiredBy();
	if (GetJournalEntry("totd_missing_daughter", oPC) == 110)
	{
		AddJournalQuestEntry("totd_missing_daughter", 120, oPC, TRUE, FALSE);
	}
}