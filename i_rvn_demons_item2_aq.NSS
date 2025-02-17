void main()
{
	object oPC = GetModuleItemAcquiredBy();
	
	if (GetJournalEntry("ravenswatch_demons",oPC) == 3)
	{
		AddJournalQuestEntry("ravenswatch_demons",4,oPC,TRUE);
	}		
}