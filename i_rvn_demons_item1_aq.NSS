void main()
{
	object oPC = GetModuleItemAcquiredBy();
	
	if (GetJournalEntry("ravenswatch_demons",oPC) == 1)
	{
		AddJournalQuestEntry("ravenswatch_demons",2,oPC,TRUE);
	}
}