//	ON ACQUIRE - ADVANCE JOURNAL IF ON QUEST TO RECOVER STONE TABLET
//
//	07/21/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

void main()
{
    object oPC;

	oPC = GetModuleItemAcquiredBy();
	if (GetJournalEntry("totd_missing_daughter", oPC) == 200)
	{
		AddJournalQuestEntry("totd_missing_daughter", 210, oPC, TRUE, FALSE);
	}
}